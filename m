Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896537;
	b=Xubm8NLIRv39/PB0AAiOUlgc15OzWwxye/hFaw7LrueA30jxGsG5/uohUMfpsgEfCLWK
	 n0/j3RC9iKDWAPVita9F9uvKMbLtBl8PUlZeQObSZwNBjrEF23tVHS0B8HzVSVK1V8Pdq
	 dMW/pfMF1KBNv/wpvUTscHa1cIR0hcftsX4vPVyPL6liisIYJh/XY9yhHr8IQlJCBrroP
	 X4/hTkW4eZeq5vUsu3yQqpIfOOUGTFMZnyof6AsHCTMeunzyacby+A9KUzw3sjXNVPARy
	 OGl/jBDtb6RGCGWEjNhvHJXS7Jirjfv7pj9oNSGuJqUa//vCFgx2JHtCYO8CDWcKbow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
	b=yxQuUvBgjna5iFVguVHHDEcI7Ul2OQLSH6X2tZGftqJMdxN3fiwragBCspR0+kph2DzI
	 Obm5tvaFu9ybiKKlpZYPjGfR6LP9NaIjiCOvHNTlLBa6squX1QwMAvDczOm41RxRHbwNk
	 vnXhvnyUZNOvsipD5jJYBiFZkNKSSZKTikTpNnldaQLpA9ybc0XMbea2qTD6JBJxX2AL7
	 RPYUvQ2yt8RQYlbGDzPKDWDD+tbHU1Ck/CHq0gumw/w9vRD6vFB+cnHkybPQXaRmnhuTL
	 vLnQzUPzUHX45HFESaaDO8qasbl3KlISlNiZ0VPveaFM4QFlEm00dvRpX1FJLULmoqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D13wWGtz;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E78606A32C
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 02:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12E78606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D13wWGtz
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so4724155eec.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896530; x=1793501330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
        b=D13wWGtzDrlBw9Im7u0R1IdFHg4wNG1163II6ub/nPI2fH0oV74hQzstoAqgvSxI+0
         myknq9Ug9x38jjUUZwY/vyXKIDGMNo3ZKXP0bAWsSPufchByNmfUqbjLR9h5DiQc64wx
         b41VuTc+OHb/42Uk60MIIq5H5njnW+qeWoLqYxKwISqmgf8YvNXxGq+BL+Qjc6HvXh7N
         0UFuKY7bms75KP1rs6qbQXAEM6K6vURDSsJu7wqzwbTz0/lIFC+uDNdCBWcUI60PHNnA
         Gm3DGTK35BKOy4/WnhcBiampzvbAyAb4nyB/WhiSNzemLHUAH++XTonf9uwlP/Mvv71a
         ZGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896530; x=1793501330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qch+gfvUWnIg/aFjnOTDzOw/h0vbAHOBkhrf0UIuzZ8=;
        b=DwQFbB53Cde8dpdWATvk7690DR6t1spDz3fWBxK+csBxo0OwND/8QoQXgZ9GwKp4eT
         GLJtSRoJh/7aVXKMVaATqWvArTQbfxxVn1EE2Q+s3J8nnJwWcKzLOylFyDOBfhQnWDD+
         Lx8vEC+D2NsR2PkqeSi7h+kdx/ZGNJhvET+U6qUSxTCuoTDevkxM21pOtUK4/f94UqXs
         gtyqUSfgFsfjt8/gtqjflAEp3m+st6fehO5FpEzYzJiTph9ZHTbQ4VVTqjICTcryGD/C
         e0AsYgaCGS8ZOnCFkMZsRA1CB4BlMJNuG7qoq0qoKXlMsT9OpFKz2XuQbSigoDjatC+b
         BmWA==
X-Forwarded-Encrypted: i=1; AKwUvBwCqyvXMwO5WRfGGaHX5QLIqiaJ0Lwo60KHvkAx6mE69/3XHdKaBt4XY2Gh5ddYYNcZ3Bce3fevcw==@vger.kernel.org
X-Gm-Message-State: AFq9FYInbBm9PJKU+zMQCIsMZyHSpFMF3vWw8qg6Q8RFHAiF8Qkz4exJ
	ctF/fjpsSPrxhuM8P0TiHNAqbqwQtXwX3SEK6cIyPDGKHXv5IJxccnTZ
X-Gm-Gg: AYBFou0+wRescTiSFlkixq3PjXjShXz6qxk++jl13uSqmSlyspakT6m8S6SmfEqdpBh
	/DhPStZy+yLjfbzHFhslU8U5W2waeoSChxLXrt0bHVIGDF1+CoIWhsPWE5gqGF540c4Qw+wIXbH
	vdUnafN1cNdfM26uaRK1QYTw3BxVqhr7DuFs8UixoOW3I0UQR5q3Z1ddAl18BBpDEFgLknvfkPD
	JY12Z1u25aIPx0GZTg8dc8qDFite/vhsTCQcACM1q4Sg0Y+smMvRxkzMywPGrjMHV3tFWx1ngiZ
	7qPXDGuW2NWcHg5i+eBCUmA1mD2n5l3BCpEyQHcnHwzNCLNWl9lFabhDQx0etMVHVzFoieXlB6d
	TvSw4tUvIayApbjPY6cQ9V9TDQQXOtzRLN/FdnVKCAiu7/R3SQbqCOf2UuyoSVQGTBO/bYEi4pr
	zIXn+Wuuj435kd59ocuYWRalU5HCU4L7oXea/E2+NkcmoNYaQzGMyIdwsjIgh5gN1dvM2wtD0c9
	MMkbeUWfvjJU1Q8/crUq3rQxuSzesa0nqwC9WH9SsHLkEvFsMbbyRT7PAT1jcCW03sPU90xMxGy
	kZerow5ykIEWw03urLnmq2GsoNALLr2T2K6cYSfwZDk=
X-Received: by 2002:a05:7022:7f0f:b0:187:c940:21b7 with SMTP id a92af1059eb24-19934e71e37mr4620736c88.9.1792896530109;
        Sat, 24 Oct 2026 19:48:50 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:42 -0700
Subject: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
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

Update the prototype of i2c_smbus_read_block_data() in the SMBus
protocol function table to include the length parameter.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/i2c/writing-clients.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
index 8bab8b16ca8a..896bf79ea564 100644
--- a/Documentation/i2c/writing-clients.rst
+++ b/Documentation/i2c/writing-clients.rst
@@ -366,7 +366,7 @@ in terms of it. Never use this function directly!
 	s32 i2c_smbus_write_word_data(struct i2c_client *client,
 				      u8 command, u16 value);
 	s32 i2c_smbus_read_block_data(struct i2c_client *client,
-				      u8 command, u8 *values);
+				      u8 command, u8 length, u8 *values);
 	s32 i2c_smbus_write_block_data(struct i2c_client *client,
 				       u8 command, u8 length, const u8 *values);
 	s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client,

-- 
2.56.0.257.gf7497c7d27-goog

