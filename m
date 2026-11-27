Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772419;
	b=SnvjVBrmudKBogZ0vkaWzSp6cCY1Hxc46DqCSJoJjCaikQQ356bIZXuxGLLpOheV9eVG
	 N5kwbkhmVgQS2pKZP9DKP/s+yrszHVFywIPcbwLtmwPuvWBKHWGAm0K+ocRXTGvVPi+WV
	 cObHoN6RgoL1a+1SY1Mlp+QLBTCU5vGweZCyAEHIO7r5VTsH5FeDMSdBz/dXv0qaJssKw
	 AmfE0mPHg+h72W8Z0UhUTXGqNNjmLsc2DX1JWNjMHE2b6Cx5PX9ZGS/2wsjNmCL3OjZ73
	 eiX9e6KA/DAYGsM+Ibc9xMlYdUDXYe2fOv9KPux1OXxo4AkwvMJvGMrLFcqXUfVOT8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=j/S2sE6LJNqIp5xSQpYLBNCbXBU+Ch2UhYSZo3FN//s=;
	b=e76ioXtYEyenfbgy8XW4wajIRYU78l2b5utvwtTTM+8KrHdKkDC4Wt6f4FnhpAUeMqb7
	 52HoJbTuH7M2EW7bBegOpLVdbCy9tSRUx3zpHMlV7ayUPRV2psbnPldwf0is+GbGOv9BL
	 jkfbzA+4yd9GMEwoSnwc0QO54f3PYnfdM7GYXmau1PgY9s2zhbpQWJSStT//oerB63uOo
	 EffoBUyPsbCCuWB+9eli36+bPR5TmDTEJuN/o7IcALakt+C3aXd3Hq/MERFWFYhh3QGvb
	 zD61ZMU0il3RxFXQQPaVEzNIXh4uW93qJeMFwRXzUcPJ8i8tlPN/0f0xnAK8Ude0Mnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mechasystems.com;
	spf=pass smtp.mailfrom=mechasystems.com;
	dkim=pass header.d=mechasystems.com header.i=@mechasystems.com header.a=rsa-sha256 header.s=google header.b=FjuyAmVz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9F606A321
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B9F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mechasystems.com header.i=@mechasystems.com header.a=rsa-sha256 header.s=google header.b=FjuyAmVz
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b563e32936so3758667c88.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 01:40:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795772418; cv=none;
        d=google.com; s=arc-20260327;
        b=T+A9OHBuCZrq6v/X70w91P5mKABtVtrMlhBCvSNzJ0k8uKvZSn9/qc12fTbSfr1jll
         KSI4kUccRy1jhD7QFg+cqQnxXZ6sjFSTI9GVYu0oOm45u9EuPzVmQ//2hP/28UXQJVLT
         3lRS0azkWUSmT/7M+SJb4qlWEwEB7q58ChID6YHoPV/Tj33yZ5BDHAregFm/YqoLGrHI
         9pyA0x9EoDOsEV1TbKMfJIblM39Dzk6n95KbRtNvSRjbl/Yu1dToYdyzsRNNHiDmYFHo
         tF3EzCs+0bYnSz/w7BgB5/vMz01iLMzsgsids6uzmJavHN7baDh+Nof3pnlov9szSxo1
         bF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j/S2sE6LJNqIp5xSQpYLBNCbXBU+Ch2UhYSZo3FN//s=;
        fh=/gNjoG2q5b4VOlH512iiI6v3581FS4qA360TdN+qNmU=;
        b=D4MgsH8jEEohfQxj0ZnIzmTquzqlNpL+zss2r4ldVl8GENAePBbV4YFaJ/hVoEdBrC
         5cr/UVcRGLTNVpmmgzny1YWaGqvSx4cGETjlIyKwwZVE4sfEChsg2QyZWQjvSBU3VViT
         sTF4coXXZC77VLEl03SWohn7DkTO2Hm9wcpTHHQrgnS+1IW5LLlfNqSF/M7q4381Wser
         WeJoiyHulMzNmtHHWWJ2Sz9C/Z8Pr0+1yBKcmXrN6J53DEyYIV9jhNLrAy+oCH3DRCh0
         yBaO1nT/r4BpipTyud112HF5UjHbNkVxtKR5mJe1OjnCdd0ybWdBhuvgELWaPKBjCE0w
         4PTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechasystems.com; s=google; t=1795772418; x=1796377218; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/S2sE6LJNqIp5xSQpYLBNCbXBU+Ch2UhYSZo3FN//s=;
        b=FjuyAmVzedyapcV8+J5+xQLnT8tRrqPfgvZb3sfqnCUY+bcouKkmivF+Zy27oQXxTq
         luM2ZtgCdrzLeEe3KDO1EFLoP8CLQSMg5FcH9+MGCsp5glQgudYHj3mDvQF/lH6sfUJv
         yRiaKoRaIGY9ay1g+lMc8O57cNQxVcJAq4GqQyddiMPIU3NIl+om2uGbUyJZhnYEHDhq
         H8+JQuEp0yOHIPvAbvI0M0QdapiKhtLt190gOs/zcjngMtFS2pnT+4pybcnrg6qXvmtf
         NdwdyWZQLyOJ0ZXP4oEOMEaKZK37I+7+XZlvh6VNNSdwojQmCClZBnO4nKQ2dd8eEzBq
         klsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772418; x=1796377218;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j/S2sE6LJNqIp5xSQpYLBNCbXBU+Ch2UhYSZo3FN//s=;
        b=h+Aak9ElKYCRpJpveWIf3pRaX/G0zZq1NKhJVKi95KdklkQjk/po8GwHVagdBlxb4j
         Orre4+cYFBt+SH7ce3nK6HNMu/XGOgQAbSEd9bonT2ssTSiJwifX4UJ6zNT+PsPnYQaY
         ybwcEzcQ9+0lhJa0WFEgr0lkyaHNEtZDMbCqdIno4QX8A+5eDvqPmGqUt+V2ggcTjhJ9
         W65tHMcLMK7m5n7noBcJSAjNARFxLru+TYDGGZWJRhxL6ZOEzN9egguoINw5O2XN64CC
         gYz1QlaR9uWWGYgKrfXaNt9+/hoWdS/qJJnUg+5F+ipWZy5K4gDvVRckZRYfTsaMghJV
         isag==
X-Forwarded-Encrypted: i=1; AL+hErHZb4L65R0SIEG/aHdMXg6r2zXAUWsXKCXNC38U7BRm/thrKmxSrbbh0HTbsBPVb3z5pd9XuQzOEQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+grGUwYlHrKNzr0V0tjfCygsaqsxRdWY65rZYWlMPeKLVT3GDS
	P6G0d5AR5GILj1fo40U3v5Nehqta/NailN+PKC5p7Woyz2653OGUtgGftAgM+TUAkkKgYc3DcIP
	Jq9eLu3gZWBQPnY9x+45CtEiudXZybVioEH00WiSzKQ==
X-Gm-Gg: AZFdTZeiCxuhqhB6i6lbW3M5KROQ7ckaHbB/RX/u/iFBRjr2fe5AI1zAECrWgX3InGP
	m6ueVUxlKgKbzxMCcTNNo90EHaBIUg7Q2Qk2nPArqXJIv1vZp5EaK0zQua2gS4kPqPWJRsZBroO
	KI6E2DFpZYoqe8dvZsK7n1PAdWhzdQaL8Y7Pn72NjnQfn+irCJZZi1W9dOXZ/9Q9PZ1IfSA+pON
	bTs08YOSDRenMoXecEHDFMoOZJjF3UzW/e3mfnlhRXdnc29skcRuk7xoPdowhdcEmS1pUW0QI6i
	IM6aAZpjskcWS+msB8ifNxwdmZwc5Ob614/Kq2ynSGDNCk/3zDeE7c/BYY/qIx1JNdpYTBVYwUz
	Fh0qJkUeLpzX04NKHz9W3Q8okYnbelMJvYoa3fO6983D3gkpN1JcF
X-Received: by 2002:a05:7022:1585:b0:15b:7f7a:730d with SMTP id
 a92af1059eb24-1b55690c5a4mr24437470c88.28.1795772417913; Fri, 27 Nov 2026
 01:40:17 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126164058.2373605-4-ivitro@gmail.com>
In-Reply-To: <20261126164058.2373605-4-ivitro@gmail.com>
From: Advait Dhamorikar <advaitd@mechasystems.com>
Date: Fri, 27 Nov 2026 15:10:06 +0530
X-Gm-Features: Aa3M54pqKM0_HhnbUssU_T72ZIWahp4yBY12MFpBmxas869Jc17TdRiWDxmiqGk
Message-ID: <CAAPs2HRq=BXVabGvHfK33XcCnu1huzkBW8=VxzaJVcz85Cwc7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pmdomain: imx: fix suspend/resume order of the
 blk-ctrl virtual devices
To: Vitor Soares <ivitro@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vitor Soares <vitor.soares@toradex.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>, 
	Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Tested on i.MX8MP Mecha Comet with both patches applied on top of
7.3.4, Suspend to idle, RAM and resume no longer hangs.

Tested-by: Advait Dhamorikar <advaitd@mechasystems.com>

Best Regards,
Advait
