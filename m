Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896547;
	b=qvjs11gGYF9LIUx3/aKG+PLt7l4TQoN0dhT4lk1EKCZpHTrQt+ru2EQYu0VT2r4Hw9Ec
	 KxP+saCUXSllqJytuw23DQnJLVCuyvLjDZQNxsQARjrRZ8/QsBeK0FPwryIolTcIhKudg
	 upsc+HAvPjMoOjWH1dUG8xlzqAkZj9JgDQq0wOXdvS8zYdNdfW3kkhQbe3G8btEmCgxFZ
	 HPwtucjoZW71fEWr2xN0mLtFT1RbpMMUwTwPhRz8GtNVkOWs0KI0EMI6sCvxdzMp4IU/I
	 OnprG+2i7J2BS0pKnfShydUwsQsZlz+dN2PLwGXyz9Rbep4+gSSEs453x2udI7FwY9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
	b=0WUWjq9o20PNAFVZhr0i81zWPWTQrcHBIlxmLf4jL8LBxkTMCRvlnxlyk9b2hrX7wQmC
	 BE08m0HVpti9jKUHCT/qiDuZ1j3rDuUL59ipJB5ZG5vHfCEFpSJr9uP/w3XXqrZQ7o0Jk
	 zYJWWEigD1b+zRiaRYImzcPUcjPQ4kVQxjA5YfXQ91kUH23q7Lg18T8BNMne01FOJ7o9V
	 uWgwj8KwLPF2dnIl4vexRw7R0TIwIKj8myyoGqvtzFCBGNeK3rlBElJzuOHi4Hh1Keugw
	 P4+BPBpFHjfUldSJD+qnXNeJaO1kAHhX1AEZIrr4NSBXxT6DSjjLF8beUlcnTIpQNrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AogBztQa;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (unknown [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9660A263E
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 02:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90B9660A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AogBztQa
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so3391629c88.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 19:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896532; x=1793501332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
        b=AogBztQaefRHxqIf7r7yyiPJ32TbkKSI3EZbJyc0kM0DrFhuCiEAqIV7SisQG5g01m
         lP8walfX9nQXhaXidqzuNwI6Liv8Yr7pKoxYww/l1I3zNqNPsE0AbTEz1Y9/wA1xXQ+u
         pQ6Bjf0E790OrznGUopeKOQszZ9uwLfYdMH3COcZyZ4oSsC6QlaWXUQep2FG9atErDPJ
         rLSXwIHURFU/vZ1FggsB7lHTTHi5Nztr+uIT7tAjeUcGHkirI6ugimoSrRGeOsGzaU7p
         Ogm+9BojY6irQAwGPPBCC/Udjma2QscUnzmO2cmOitOQmo9ottCgL420ReMargrfLKyq
         LgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896532; x=1793501332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
        b=meksxaoHL5Ml79JJicNsCmDwkB8sDzi/SIS4kinKBRUXCDiPOjzBOQiMvKtfUC6IR4
         ZY7iMtt8cr8FCLbs04Kb+4ItLml7qzp3Awzl+UaAi6Ty2cQUDkD8wBUh/F7CNfiVcbQ7
         1bwDYAtPitpTuLpJUw43cnJ5b5CRDngAQ1EIwUULjnBe9EQeGdA4uqUnhVUg7CHAkqqW
         gRT5VNOkbl+PDfWjVTSQtxcdpjXgMUAN6k+cw+PJgj0v/emac029YIV6EZ5nxc2LBJlQ
         tU0zA8jO1guEbS0MkMAN+RJW0GJ5tumHYQEelBE1GZQz0n7vJQ9KNehwx0PX/E81FXNd
         ffXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWk0l+/JCfGBZqPdYs22XEqv5F6UP0rsb18BJFJ1AbCVPuJl9dzzgdiLI/UPj+QtS3YnUT8Am6+A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJg4CPqUkzH7XCUhazJ1tKWjMBPQgIEfKrZREUNjTPLuTukG9SY
	LZVEKKlstes9FvRsbt0EoLk++zdGUIBWLr+AhLPAb4gaSqQu/sB/s/gt
X-Gm-Gg: AYBFou2uWlS6/2kT7CzooGfYNG3VdxLq1rXfAL8KhbYbPdqdaZTcTRH/HGbS3S8Gt+K
	YYOp40ujViHJ2jkiD0WIhRueiqyBiMFpAmGltK/v7gCg6QFF+hPvFcnWuIwr89XIe3b/DfyYmyB
	pYQfReHWa9BpfuVVXdRrCQNNBALy3xici18Unr9AtH3qbGTyfBbPAP5zNKffVOgEVrxmWh16CGp
	HLI9aBlDN5hVkjlZMxpLE3EX3/sKSnmZ27M9w4ZdnZgxt4EF3JwHC40+mm+T/amgkLQivcx96AY
	zA0tQ5+fnAWALeYY5MAd2mc3zzYHunmGXLlOAcVvUKIOZC5kyz5Ss8qfES6feHslp58pBc6PbPu
	VkP1htlDxQN4qxs9YkO1pysJeR9SFf30Kl6UjjyXXRFCwKe2SWwAN0+tBnJGwIbrTLpaUhkKTOc
	eR02o7fwP3Uju+bZTA7AI0w7+BWnbIavQdEBpswL33ozEMaepQLLcYvMjWL62IX94DH9jpGgL5F
	/6EqqQz0u+ZAHVYf6jX62dajPMzBBbnnHvg604eSbAfX5sVWepMv/ayUmzdYiUv3HVY+UWRL+ce
	p66pi/2aab9aqlxU7VmZ5FdQaL+G+VGzH4YzCMkVAtZQ5CdyPpwDJHr3hpNAYtFz
X-Received: by 2002:a05:7022:ea5b:b0:19e:1ad9:1c2 with SMTP id a92af1059eb24-19e1ad9061emr760295c88.38.1792896531619;
        Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:43 -0700
Subject: [PATCH 3/8] Input: cyapa - use 4-argument
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-3-19bb97467982@gmail.com>
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
cyapa_smbus_read_block(), accounting for the final chunk size.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/cyapa_gen3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb954523b..0cdebf2c34e7 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -256,7 +256,7 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, len, values);
 		goto out;
 	}
 
@@ -265,7 +265,11 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
 		buf = values + I2C_SMBUS_BLOCK_MAX * index;
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd,
+						min_t(size_t,
+						      len - I2C_SMBUS_BLOCK_MAX * index,
+						      I2C_SMBUS_BLOCK_MAX),
+						buf);
 		if (ret < 0)
 			goto out;
 	}

-- 
2.56.0.257.gf7497c7d27-goog

