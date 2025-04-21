const axios = require('axios');

const BASE_URL = 'http://0.0.0.0:8080';

describe('Rutinas API Tests', () => {
    test('GET /rutina should return array of rutinas', async () => {
        const response = await axios.get(`${BASE_URL}/rutina`);
        
        expect(response.status).toBe(200);
        expect(Array.isArray(response.data)).toBe(true);
        
        if (response.data.length > 0) {
            const rutina = response.data[0];
            expect(rutina).toHaveProperty('id');
            expect(rutina).toHaveProperty('fecha');
            expect(rutina).toHaveProperty('descripcion');
        }
    });

    test('POST /confirmacion should succeed with valid data', async () => {
        const payload = {
            nombre: 'Test User JavaScript',
            edad: 25,
            peso: 70.5,
            altura: 1.75,
            sexo: 'M'
        };

        const response = await axios.post(`${BASE_URL}/confirmacion`, payload);
        expect(response.status).toBe(200);
        expect(response.data).toBe('Confirmación insertada exitosamente');
    });

    test('POST /confirmacion should fail with invalid sexo', async () => {
        const payload = {
            nombre: 'Test User JavaScript',
            edad: 25,
            peso: 70.5,
            altura: 1.75,
            sexo: 'X'
        };

        await expect(
            axios.post(`${BASE_URL}/confirmacion`, payload)
        ).rejects.toThrow();
    });

    test('GET /rutina should handle connection failure', async () => {
        const invalidBaseUrl = 'http://0.0.0.0:9999';
        
        await expect(
            axios.get(`${invalidBaseUrl}/rutina`)
        ).rejects.toThrow('connect ECONNREFUSED');
    });

    test('POST /confirmacion should handle connection failure', async () => {
        const invalidBaseUrl = 'http://0.0.0.0:9999';
        const payload = {
            nombre: 'Test User JavaScript',
            edad: 25,
            peso: 70.5,
            altura: 1.75,
            sexo: 'M'
        };
        
        await expect(
            axios.post(`${invalidBaseUrl}/confirmacion`, payload)
        ).rejects.toThrow('connect ECONNREFUSED');
    });
});