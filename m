Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896536;
	b=uMnN4iQR3cbolDGR1Kq+3ZY7k+p8KbdlrUJGAK/DeKOHGTgmGmzFA9ZFptpNB2xb24rR
	 4nebQHCvwrKR77nZlkG0kuRsNeMQbOdmhOF4sgx7W1mtpD+/nt0D+VzGNzKNwIgsZ9N/g
	 g2c433SwOnaCEImPoiuMzuHe3tycmjbA4KPzoA/SZS0i0E7j2hZgIB5+/WYgm+IcWs6dH
	 rygiL3svzL6AhhvaO2d3EH79vprADSOGLM14qNanPwlA8oo4Zw20I5ZSIBsB3kMAizp6N
	 K2wtbSWvAgoMNQloRV52BBJDHGel8S+HfkW9YxBjN7TzFgy8qYzVP8DjERHj0VWGpkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
	b=QdXCOOBlAzEzZ+7Nz2pElv78Ww9o8Fa4t87/N153ibzjKzmIZ46c2+LpHOrqpdDSxy12
	 /fpKD1YjgXo72wnlb9M2/vsHnj1eM6oaEEY1JTpd//Y9mbEIIoS66vt9/U1GUD4Auiz+Y
	 gMytptU9Ky2IKJuAA90ejK7y7pLNOvINkmQzVpUsspuH1cKXUuNolYoQl/v3A3pprGQRe
	 t6BW9TqIg9imZDTDf9j2i30WgqZsloQAneeJF14tUyCasM6pGBIafeYw+ZHpxraGiJiuj
	 dbLrcSZn9qQS44yJEekXyxRFZIwmGjHrMITk2MA27RqiWZKra+/jnn3meE28dfiG5ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jY+GWyYS;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB838606A33F
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 02:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB838606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jY+GWyYS
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35f036b17easo4771091eec.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896535; x=1793501335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
        b=jY+GWyYS06WKW7sEDFJqidwo1kj5aZiu+FCc59Yl6t+aaUEEs04DN9aHOSFvf4pJ8Z
         qDTsGyTd2hnl7k5Ym46s4MK+M0SwUS6QT0od/3PXQUY9mRrVY4wqzdWTtw/7QLtKhHPa
         Wl1hqNxbGN8k3SsCbjwlCsOrJRQMs4gMf/tZHs8fW9xwTRoGmWNJzJ/3nkRIzMHK2jEx
         7Yvg/dWXiInPgUoSXDzs3Y09VvZo+NgZaXTjGaJ6myy/TWg725XOGN2XlqtCb0y6wNjt
         /5awgzg0f9X0YKC3fb5ZWJ1bxfPVtsB3fUtQFpxRIUQdbgAmX+A1x2JOoOg4XWscVZWx
         qdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896535; x=1793501335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6RWQvZ0010QMq8qM7UpBKJiUI/Pg5qFMdimoJtiVT4=;
        b=XpZPy4GISQpzbZysYDLS+f/K+YCwXqiKQHC1zGr3QefSwLsH8XWVlNrHXVU9hLyzpA
         YTuexHBf68FwWkP6Yt5t4Br2Rgsn02KvlBcTdCEmDZdx14rDSlKa4N6ctTbjHItnZtuN
         jx/b+C06EUF6dzAG8h6RLhzgxh5SeKjdz0+7iO7RruhSLOQPKYNRN9J9hI4ImB+BWUpC
         QNNX8iKBVKa5KANmeD834KulmgZb3m/HizYk8Q35TJXT26FF1vPkFe7AJ4oDtOk7l/7X
         rEonrnoUHdSF9g/exur2x8NGLbUt1ypQ2xOrsrkXm0wJi2C+Cx00ohlpD4Dn5Hcsbi7v
         kwaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2eDHtlB7wn+6QcDjz1oGdFGYrbYgXbQ4qOr44zstE43vzqtBB3SGikFmfHk+S7OZSaNt7hkNwsQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK0ZoDRBRIk2qC5T03MefKK2Pe+C4kQ8PIPVhOR9P35Jgjm3BfC
	h5JCljuWqhiLWBoYa5xc/4wTZKiYnhYr1i47zCnlXCYmc3uv4dUey6HE
X-Gm-Gg: AYBFou2p6PA0iuYlpYuRDxNJy0NOPD20H/7jV9gYmwJfOfj/wglDZNSkHsn75xIKV+t
	0WRPdFxoN8eQIx6N99xxxWsMR7sOhfyTT9ccI8misYRZJdinNvc4LGHh72KiS8y8+BzTxQ6PZNL
	OSoAispi32REgY8SsRseLblzd7jGVDQ2/OgfVha0WK+qG5X9LsCEBFz4VUX8pRKqJrq8COhPFet
	zID57fyGGGDjl1LjSnTYF3yiEM4RWaJ10mWDGLvUZhBvM/Z4tHulLzywoBVVPBfbI6O6oY4TKN9
	gZNUPDslJmIBWkDNZDs0pj0szAdz6fU3dYvFiP0+DXD2VUfjS9VMYco8QD+fuDEaj+JH92XDx5P
	WDwUGNHfTxKPKGXH8/rUxNIXEycaL2M3Eq5m/1VbX2EDxCPXUDhu7nCKQqMHJkMGTiPsJl71DLq
	HYeLpPIOPV7ezpNv7S3sMGCL/kbcHt3yWws+3DI3O18a8X14cz7RACN3XWqIeq2JzhWoQ4JNhM+
	q+0A6VbCGt8fILkhdtwENf7VmimK1a0EDguhXTiaONosvGrtxqf6j4GAjrrUcIKtWTEYbw9pEsR
	mZaFIl7F01Hd4TlsxM27XoQ99///3G/MKKmiA5E3zJ4=
X-Received: by 2002:a05:701a:ca07:b0:184:d593:2897 with SMTP id a92af1059eb24-1993f3ecfb6mr5382379c88.29.1792896534741;
        Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:54 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:45 -0700
Subject: [PATCH 5/8] Input: synaptics-rmi4 - use 4-argument
 i2c_smbus_read_block_data()
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-i2c-smbus-read-block-data-v1-5-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass the transfer length to i2c_smbus_read_block_data() in
smb_block_read().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8b61c2382297..a180becb7670 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -172,13 +172,13 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 
 /* SMB block read - wrapper over ic2_smb_read_block */
 static int smb_block_read(struct rmi_transport_dev *xport,
-			     u8 commandcode, void *buf, size_t len)
+			  u8 commandcode, void *buf, size_t len)
 {
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
 
-	return i2c_smbus_read_block_data(client, commandcode, buf);
+	return i2c_smbus_read_block_data(client, commandcode, len, buf);
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,

-- 
2.56.0.257.gf7497c7d27-goog

