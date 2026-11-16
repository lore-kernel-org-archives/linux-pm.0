Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864314;
	b=nrwe+nOSbAlPjKCQOdJ1C5u8QKejX1UffUvkqxVmgzPL6+7e824Wk2ReExTBCbuNn9It
	 RvJKq08SEIsrSHg60oAElO0cXtxZXefuEZdZiHqqSUSxfsIc9H7PH/hV6fPdKHorkVcVE
	 mZuewltKeQ+AOg/ZXl1c67zPARMft11ChXyyYBOSPuy+EG9Z5brNMBX4erF4b4Bu38NG1
	 51wVbkBdrmiPDUuEMMKjF7n1bUUKOu8H9XJWOQQbdutX4IhgkzJCLfxUJ4jam9y3vTNG5
	 6mQ+5Jd8+Vb0wj3t49EERZ9Nt6YI/arOo2gsyT2/02+zLWqU/H2iIviB5mZCbkmrpcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TQn2kGhWJbaBGD65fKWwqKtr6XDMTGh3Rmtbd55zkps=;
	b=j9WanP/tU3CFWDEVxzbq6QzwSvhW3OT1jjRamZds1KpZ8JivfGFHf41El6msDvLdP+7L
	 c2H+vEJ6A1A6pvkOuKlF3x3iEVJuFvAMIYOdw9Nf7hwrn8hVOU6qyIZPsXWvg52QV6D/5
	 8nmrMzmTFsMvf+r4WxsR5iZ/QeWZhmJY+sU2DIHNF2BSJzpdXf0ip7MeJPE/OnvXBr1lY
	 B4OBG048wgCPtYOGOcpRa22QRwOZ6xm0+nzM/t51QbYNtB0OdqwGaJSHI0o3U1LOgDyr5
	 rw9Yw7T9V8RG0GaFDY/WreA9+q9isMhyU9oX4iPqD0ORKbM0Q+tWs6su3/UguRzr/Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=crKqWpBy;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB471606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB471606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=crKqWpBy
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so11292675e9.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864312; x=1795469112; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TQn2kGhWJbaBGD65fKWwqKtr6XDMTGh3Rmtbd55zkps=;
        b=crKqWpBy9v9PmTiWD5cN4fT6cTPSUgRhGGLMmQFSUba8ExVSKF2vjESeXDDhOae5pA
         rka/KPNPbUmqrz86doZE658P+yDvCys0FbcqJ018GzsU7GCACJ4O06ZWwGgHaPMxA2OD
         ytTESXi9Hcn4bA8D1y02uinkXD4u+sRReZTUIqiKVJGQdu4hQRfNtfPYK2mQsCxvXiti
         PEIdXijhuXSwohct+dh7Qh3Rfoh2sRFjHXqa5TT5MyEMDzSO26jZYkC8X8a1GDfbt1Ij
         8szutdp+XbCjFldFdxWhT/sxaFGGpgMMmbg89VoZusnty0wapoSXJc9jEKLdSZekifB5
         4ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864312; x=1795469112;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TQn2kGhWJbaBGD65fKWwqKtr6XDMTGh3Rmtbd55zkps=;
        b=OxWaV+bCfxGeHm8C0SEAd76eRvvCGgxrWf3hvgBnvFScQgsjNF9kIjRrBKw+/Js7qD
         C14Kk4bCWJtHZccbpOO7iBJdbaRq2rcZrUJfFa5Y0QNQkJvMDO7VuWCMbt2cx7O01PAl
         sHxAoxdYAXBAwM8SIh6ROxdeyXNW/f7vbnLB4PNC5YLLgjxdZehjZDIXOh2cCmbE9JqL
         cQzdFlkgnj210OG3JMG7RoM1L7o1XPWDORfE3u4h+rkpELqoE03Nr9tQjBtURQ3pORhA
         cnsFBl1pFb9cUrNsmWBcEEo3ifvD5U6zxyTT/mrqHY1DKha+9TlE9ktL0whCqXmlfdeE
         tzWA==
X-Forwarded-Encrypted: i=1; AL+hErFoVYnh8ureiBblFuyP+GSl7xryBgRX0J9DjmPrEXguS2WqEMr32ORzRgiC3IytUZwoQM4T2KEV/Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+x8DRY3qbgYYat2LV7bsbLry8xcVOqKM0SsqO3yv1AeP6/Jclx
	rH3E56zm7pxiA8v2dOmDMoOTvSj5nUTpEFQhe6OfHTtZAmI/LFpsHqH+
X-Gm-Gg: AYBFou2gbQ9bcI+rp6dQG85K0tNp/oIPdUJqZsxzVTgIbTPpRkVY7gOxXXbQCVrJLXk
	aDikD+nBdPxzELeNgaLHHslNlyvntH7rM8TKIYqMmoJCGOo6yRR56kO1UyqbBko7CvR611gZ2tg
	FJ19XtDPqOsUUIMOs8kaR1C4jIpzKJrFSag2d4fQY96KYTapvz/PEruVU/J9g0hvLmWZ4rB15si
	IViK7v/dSUm0KvNLtOy4OjXpOtGrewin9SJf5vy+Nfya4uDVNwxI7SMuOViGqrI2/Ez2ytc6SkB
	AaaboHIz17umTm3OWLEd5qgLtwfSMpa07QZ0Q7zA0UuSJQIf8x5M518T7R/Qn7bVmoxglkutf4A
	Y1i4aRYdv7omVmM0uQXZiKQNMRuVU8R2h+8KGvWreXOm9Bbg6avn38jKMn25mrAHpcXncg3hKRh
	FEaSf0IaL/tW3sy7XbYDhnIL8J6ZDWxSG5LhP57ooSqCrLQX4do0Xgc+NItsEFxwPapiszLahGU
	gOW0lAr3exc3p+rI7yZ81cGGX8kFVGiPtcZGH/BK3R3/osLGFBBVu2OLOEOnWK3dysySoGx6R+/
	6EEbfE04K91x/Gtn5vF1SMI3hGEsn4TMU5TKDvcho2ReohATqIAOPKTq2AZTTg==
X-Received: by 2002:a05:600c:8b81:b0:4bb:5f45:c97f with SMTP id 5b1f17b1804b1-4bb5f4f93f3mr183128505e9.27.1794864312370;
        Mon, 16 Nov 2026 13:25:12 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783854cesm26340475e9.1.2026.11.16.13.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:25:11 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Subject: [PATCH v2 0/2] Add cpufreq support for Qualcomm Halliday
 (SXR2250P)
Date: Mon, 16 Nov 2026 21:25:05 +0000
Message-Id: <20261116-halliday-cpufreq-v2-0-e518cc055457@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIALF0+2oC/2WNyw6CMBBFf4XM2hqmKFBX/odhUdoBxvCyBSIh/
 LuAceXyJOeeu4Anx+ThFizgaGLPXbuBPAVgKt2WJNhuDDKUMWKYikrXNVs9C9OPhaOXQFImuqZ
 IMr/ANusdFfw+ko/sy37Mn2SGvbMbFfuhc/PxOeHu/fLqPz+hQGHTREcqiVRc2HvZaK7PpmsgW
 9f1A8w7k3LCAAAA
X-Change-ID: 20261108-halliday-cpufreq-1e9c3581e2b4
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864310; l=1354;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=Vl3mWqPNXbM7HXPxqhlw3hT3lk2vRli8dmhGXwQ8GHA=;
 b=mUNNSB18W8LJ/FF5bhpDD3vmw81siwfrYgshJoZ1CBZT9EROHlU2rHOC6cPim2pc7eyXwRq4A
 GwdTh0lHIa0CJwIHlBExQXh3MMeIBeUNkfF9eAeGGTMsHnlz/DDr5mZ
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the CPUFREQ hardware (EPSS) of the Qualcomm Halliday SoC and
keep cpufreq-dt from probing on it.

This is part of the bring-up of the Qualcomm Halliday SoC (SXR2250P)
in the Samsung Galaxy XR. The DT changes follow in a separate series.

This work was made together with Claude, ChatGPT and Gemini.
Reviewed and tested on my Galaxy XR, where cpufreq runs through
qcom-cpufreq-hw.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
Changes in v2:
- Add the qcom-hw binding from the DT series (12/17 there), so that
  the cpufreq patches are in one series:
  https://patch.msgid.link/20261109-halliday-dts-v1-12-289114ab8197@gmail.com
- Use the "cpufreq: dt-platdev:" subject prefix (Zhongqiu)
- Link to v1: https://patch.msgid.link/20261109-halliday-cpufreq-v1-1-d87a397396fd@gmail.com

---
Stanislav Aleksandrov (2):
      dt-bindings: cpufreq: qcom-hw: Document Halliday CPUFREQ hardware
      cpufreq: dt-platdev: Add Halliday to blocklist

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 drivers/cpufreq/cpufreq-dt-platdev.c                           | 1 +
 2 files changed, 3 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-halliday-cpufreq-1e9c3581e2b4

Best regards,
--  
Stanislav Aleksandrov <lightofmysoul@gmail.com>

