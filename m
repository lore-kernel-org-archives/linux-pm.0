Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864319;
	b=UPl6yPPrzf8blYGHQgY3n/+TKwVo6C4cupXbMUN8qqasj/hRvKTZ/1WldGNQOt5WEwVC
	 6RW1URAdLKD0xIuSJSzd3vHMcL9frK59gY4yBiq0QAa52e5b8yN6SQ8wOIGD+jFD/avNI
	 p/fdwFjj8AyOmB5zLWra/mOjUEVq6UvMKIG1ZlcRlV456KjtzygnMbc07xMX3M50km4an
	 HIN4P3OEttfIM1Ks4lnRqpQpaY7WNdGwZXNLF4ALNVlZNzBKHhfFkzq2w7iFNzQIBNQd7
	 +nwiinyA1f6XpKxBRNLu1xN8pdNrs3P5Lhz2mdZa2eHGy2VZuMdUpx0pMFBXzGAUyCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2SOARYtnJo18igv291sc1eP7B92CvpPV7r5k9Q4RbGA=;
	b=doZI0PsM9ifpzkQ3tzaVMDhM3XSgWJJl/yr3mdRYAG5p3UKUW7UGYv6P5/R3AkZZoq82
	 SddMFdBsFUUfl4juWUWhlgNEkpYLtYDCk0S9q1om+qllKoiI2D8190szGlgHn9oB5BGVQ
	 rxQdVBj0rTBUX5CswFTkR6vMuXO2gAbOvCbpSxmqStkGawfI6Cp8nTeKD1IY7lWiq5iGW
	 qHLP0+9zYwr3WWCx9bHgjwjUGnsD6AUvfOFXgGtuTSZl+53PEk37cLRAjQR+JJPKkwxpv
	 GGTwpwMd3V7yVNjgsi0OUca4yeRxjAqDLBKDk2Vg8ne/Gl97DQIY0heTa+sUcPGg8ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UOLL8Whu;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65B606A886
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC65B606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UOLL8Whu
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b467581b98so35086265e9.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864317; x=1795469117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SOARYtnJo18igv291sc1eP7B92CvpPV7r5k9Q4RbGA=;
        b=UOLL8Whu4LA8bNveYjnlOSE38Ii77baYdefAzKBwlYfl11uUi1Qrf9fMBGpquz3o2e
         vKn3CvN+EumW6pOW5Qn6+es+DJl3mdDy4k2yt3ueX3bbTGxSwZXA3h/2RRnVEUrB4Vvq
         pg7T/CRQIR6huYmF3hi7pPvvAazaohD0VbPSmnldcEEbXZ28dnJFa1HsvVM3Rheb4bOB
         uKvYq8v2IJyU99lrrsvgoB+lmkiGHwqEu/A5wTRI8NLDYOCbsRjCpmlLePXBIpd714go
         U9ADvoXRexU3wQChWFi39Z64trquY2qUbnIlSIIcnmix+ZWryn3+v1c+1a7M9VCBpCHx
         Ozvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864317; x=1795469117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2SOARYtnJo18igv291sc1eP7B92CvpPV7r5k9Q4RbGA=;
        b=D/Di3bVoVeIkSHFm1gzaR5zt90896nrdG7CFhLaKNPyLdY+DGgsIH8gREhx/b98t+6
         CrT9ujMmONaFapYwulNsWi2OcYHI9V9eYkukaG604v1LeQcHRYWqHxuOu2h04wor1/GK
         +sJtQdKsxWn4gYpOeqRNr/56MymWpZ5HK3yC/8r9F3mK5wQtwPbeokvf7GUt0zKIWVHV
         TkELc1GhXKfSg/YTq9XQv396jHJQWoEHDU4HcNxtAxV/5x4slVgE5W3zQ3T2RNXRbwdT
         lPHMRt51nZvcecALYbp2xvCyB3Rq6vpmnPwf036bHVTkzEx92oWeKbkuFd8C953le9Uw
         j1EA==
X-Forwarded-Encrypted: i=1; AL+hErEXNhyl5W9++fE7+amKwq0PUZThyXgqAKe479MeI7OCu0yhV8G+/ZMvjpcBh1EbkeXhRCRh/5J+wg==@vger.kernel.org
X-Gm-Message-State: APuU4Z98q1YJVxd4sy9L2mXKdVSa52wM5fklKYRtw5AS6aD/ryAr/Io2
	rfvvO6mGbsPMmwuvxkTXfTpGRysNepPKVnxgo6ASHhTErpCUE3jUGzl3
X-Gm-Gg: AYBFou1HPhKivHMoRAyrlPNLjFBKH6QbetCZ9PBOEr5VneCtTMb41Ksx4zVvGoB/1L4
	Vuan3rNtc2C+R+cOJAlg/oWtq1dSArXkmekdoFfhTRmTeBcacmNoIBZA75krCg6i2zGfyuLz35C
	gArs+fGwwFfG1I9G3hmxtomHrxIO1r93Jg9cjbnfpA/H0HVJprZ8wZOSQwZZLeCNAUXbekaGxkN
	qKaRZbSzH+1mastWgqUvQwZLSP0dNaacuhk9BtJ99yYOKWG4Vl3LX79z5oFCoK3HKmBrCtIWRyZ
	5vcmUdClvsObOKfXc6GXr8yo2qPlFZLcU3yI8NFAC4Bo9H3xaMOyTuWoRrXW3vlzLB9DqhSAl59
	Q8bWBPaQHPRvQxHoyYBxIBGziif4cJMbRJU/NTXraGSnwNwwJWeHydw5sEHhlcaBo56rCHw0Wx3
	B4kuJ6EXT2CcZ+ZZf+kOIlZQTtKU+3xFE0GBsZaX1YGU1rdKpeNGtsWiZJY6G021GTtZq4eAVLC
	QHBpjrXepMM78xCxkg9Vo1iYr0CIjbTPgwXc+Y8lTq0/AeFEdUMN9YuoXAjbTFGM9fOCl6jmu73
	BLdfsFU1jF/9lCRe1FjAtiJHMsjk47fB3jNxMtg2
X-Received: by 2002:a05:600c:a302:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb7347d930mr63274065e9.9.1794864317319;
        Mon, 16 Nov 2026 13:25:17 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783854cesm26340475e9.1.2026.11.16.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:25:16 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:25:07 +0000
Subject: [PATCH v2 2/2] cpufreq: dt-platdev: Add Halliday to blocklist
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
Message-Id: <20261116-halliday-cpufreq-v2-2-e518cc055457@gmail.com>
References: <20261116-halliday-cpufreq-v2-0-e518cc055457@gmail.com>
In-Reply-To: <20261116-halliday-cpufreq-v2-0-e518cc055457@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864310; l=881;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=2GcqGR0zihHNnFXHb5IImaTefMurA0fW5o4gSm0JefA=;
 b=4lc+g+lfF1maKT/cQEhVa2dHnEqxr9Y+m7dCjl3rPKrIxUad1nOfy9KT8AZ+/l5jbkMGdKmvS
 Ef8hYu3BiTDCLxJ4PgoQacYXz8x4Ckmxj84jXTaB+zf63OVWiNTiiSN
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

The Qualcomm Halliday platform uses the qcom-cpufreq-hw driver, so add
it to the cpufreq-dt-platdev driver's blocklist.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bce4c87573a1..3d5709eaa08f 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -155,6 +155,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "nvidia,tegra234", },
 
 	{ .compatible = "qcom,apq8096", },
+	{ .compatible = "qcom,halliday", },
 	{ .compatible = "qcom,milos", },
 	{ .compatible = "qcom,msm8909", },
 	{ .compatible = "qcom,msm8996", },

-- 
2.55.0

