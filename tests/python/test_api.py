import unittest
import requests
from requests.exceptions import ConnectionError

class TestRutinasAPI(unittest.TestCase):
    BASE_URL = "http://0.0.0.0:8080"
    
    def test_api_connection_failure(self):
        # Forzamos las conexiones a fallar
        invalid_base_url = "http://0.0.0.0:9999"
        
        with self.assertRaises(ConnectionError):
            requests.get(f"{invalid_base_url}/rutina")
            
        with self.assertRaises(ConnectionError):
            payload = {
                "nombre": "Test User Python",
                "edad": 25,
                "peso": 70.5,
                "altura": 1.75,
                "sexo": "M"
            }
            requests.post(f"{invalid_base_url}/confirmacion", json=payload)

    def test_get_rutina(self):
        response = requests.get(f"{self.BASE_URL}/rutina")
        self.assertEqual(response.status_code, 200)
        data = response.json()
        self.assertIsInstance(data, list)
        
        if len(data) > 0:
            rutina = data[0]
            self.assertIn('id', rutina)
            self.assertIn('fecha', rutina)
            self.assertIn('descripcion', rutina)

    def test_post_confirmacion_success(self):
        payload = {
            "nombre": "Test User Python",
            "edad": 25,
            "peso": 70.5,
            "altura": 1.75,
            "sexo": "M"
        }
        response = requests.post(f"{self.BASE_URL}/confirmacion", json=payload)
        self.assertEqual(response.status_code, 200)

    def test_post_confirmacion_invalid_sexo(self):
        payload = {
            "nombre": "Test User Python",
            "edad": 25,
            "peso": 70.5,
            "altura": 1.75,
            "sexo": "X"  # Invalid value
        }
        response = requests.post(f"{self.BASE_URL}/confirmacion", json=payload)
        self.assertEqual(response.status_code, 400)

if __name__ == '__main__':
    unittest.main()
