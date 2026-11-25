Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575805;
	b=QZ8stVXTW4Vwyk2uGFXupc2gnYZlsizrb0LJrVvIW3/b0zLFN4c3gcYuyO2PFunByKUg
	 vkpXfEpmKNBmK5NIuZhguv+mXbK/IWFLcHVbZOPZBbkHXCalekNLlDq2qy64aWo91ItUm
	 jBk1Is7OT7uNh7XRjp5cy6Eg2i9MVEalWtCBZ8SEo0u2sr3/vKCCQuxEnh3xTU2LtQolP
	 +htYark59D7tGN7mPjlKcufm8zLEAhrL2+GF3c+HYiAAiw6UiXcHmGlrGkpB5VF68o5Um
	 UW9SbJR9t0ZhVcpJgM+1kTn0HwhSZlXjWVBWoF5XvMKP6xQSdp/DBTqA11mbJugSRFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=YqK2M/Yynv5vzFLqMgSa7NJZjQIGQnS1ueWuqR6kXUY=;
	b=Kcxp915H3v94RKFLeMSNSxxka9EjoNOFmNM+tSlFAGYs0mfZoaL71RifnC2TOX/ZPZ5e
	 01HEj6IkCns67q5vw4Tu0bhh+t7u7/ymZgoMHP9h5uRzkzkDkqthI63EmildshoXKZOgV
	 rgrGemNL8RoZ1S/H5LhKUMfrCR938nLg0ZzLu6M/sLmbfvQcDnZXcRosnKOj+Q1mI0Qww
	 yXD7yFq3SN1jIVk92iZy1dagRXVhNs86qDDt13x9DreIKG4L2Hqw4fseFKSsd2KtlNMi3
	 G/lsMBjUGpOkBh8bJtFnAgnxXTn+s2S2x2YTkFpKa2B+7jWnLaXMxx3yyq0TakkTdXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufNniQ5X;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932B606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1932B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufNniQ5X
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-386c336eab8so1594801eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575804; x=1796180604; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YqK2M/Yynv5vzFLqMgSa7NJZjQIGQnS1ueWuqR6kXUY=;
        b=ufNniQ5X9qByJ3a6jXn4U/XqEKMbII8PIg5Y2/CQlesuBwYx4husTAd+Vb3j9RQD2V
         K3VsfOPA8L93SwWTwRhD3IDJXCUdlK18qecUSlnOoNfGy80TpuWlDlYr+vADnXcAbO0n
         SlPBCTdoOUISCi/ZFW/KTmFLr039lWTEeTK7rPQkCDgQjlL8cdMvU6q/oJPnTKn48u2l
         T2Q94Dwdb8q+LPnjwzbAdH1wxJv+HDrKTRYUlYN77GpbgSZfAe3BhXwvX1nqRW+IbPT5
         nm31xPEUvr1lOm+K93PNB/2YXe5M3Nm54uctf+yiNZ0m97agP6DX302dJNxjXCoQ7XQP
         0POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575804; x=1796180604;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqK2M/Yynv5vzFLqMgSa7NJZjQIGQnS1ueWuqR6kXUY=;
        b=rVFEVjiBWToSukZyz+9vshEskmSkEAy73CGRYG2/BNo060VZ3tKjSzBTd9Z8MCaaEs
         k7akzs/LFGURnJyJ70TMnqINCT6Xli5nagK3uxYZ6AlgphaSbP1zzvR0uVfBzjfyOOXV
         TsUs/IiKV82yxkO7UNZ/VGYcZxmRNThHEaql6CYUUD+H1nFM5ny0ePV3a14R69qG3EJM
         iwuTsNxUpOZPRxFBf1qMXmz1br7U1g1Y4gVnYWM2XqQfDjiVh2EimungnlF/TrWPhkXy
         rU2niHs16a5fPPXwXEg58CymTBUHiwEwUI6jA/+Vs2IK7CLdv3yIr4ZnX/wfE4pNA3i4
         9gxg==
X-Forwarded-Encrypted: i=1; AL+hErEgfGsEd7CgGtIa8W4XFPd+Gsojmxa7+RkkgnPk96W4Xu1By+Pxxv5203W1W1qFrfSp6zS5id+tRg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/0KVxNzCcbwjG9waSBqJewRBGBuxI5P9LAAFvKp1m3+cEreM9d
	VYezfAVDR38+ggoWybJX8EA2y5B9h60EB1LxmY3Mr5TSxe2ij+8Nw8bn
X-Gm-Gg: AZFdTZcQz2GYmQqUW3axcyTseW3lRFhXVHmeRNfFlgsuVHSusy17HOAMsVN2/wAxt1n
	AiG8wNHV7Myxc6yAhdDzNFQzH+Ny/VrADxjj+XRKKLKevWOr1Kaq1JM6y9ZOdC6TA2J6G+Qce7f
	fIu+si5nU/tpctpSasEg/m/i2uRfQohmaS4ROmfgif+hYDTROFrZnz9NfT7pFWAYOafDxRaQjuD
	HSf7naoN3NamHzHx8aFQ2mEM03NsuI1DLH1rM6e6r3C8cUWJOSf3IOmfebCs1GsxsgifpihYY1V
	4nfrgl5657P3QZ+/kM6g3Vxk4qRiZZ+Y3cRdr/DQ+EQhSiGFPw9w2DPF274BXhuNG/8on3xCLjw
	Q0NBpxHUBYKTRDUKQoO7kwIIo0r0ZhyWNf9DRmCTa1BGougZQmo3a1G1+ts7Jfp5nLdhKtExQNj
	8ErKRRelS9Zp2QDBOLqM1l3rAwQ/nub1H5+QdI+ikK0CwlGkjRgK/3Yq3Bv5X5aBP/5t3FLQG3K
	qQjZWJzskb7cNVU/QFGxf1HTEglpBxHV+pvCRb23+Kzewe8HwvPTMfdxajedsZXR5MxfTblrsYl
	5NQpAEzoUl4cKeAAE3HejnUP2Z8f7qcStMP8KSYNE2nQ6wJSDPo8aVJouHrJL3Y8S+O6t1gCaor
	Bj2cg6BtSBfMvCnaWkI4u/im7
X-Received: by 2002:a05:7301:8616:b0:385:9424:5c08 with SMTP id 5a478bee46e88-38594245c66mr18684521eec.4.1795575803736;
        Tue, 24 Nov 2026 19:03:23 -0800 (PST)
Received: from [127.0.1.1] ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm55751171eec.26.2026.11.24.19.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:03:23 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Rafael J. Wysocki <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3] thermal/drivers/rcar_thermal: disable the work before
 masking the interrupt
Date: Wed, 25 Nov 2026 11:03:17 +0800
Message-ID: <179557579759.953320.4240333903133893045@gmail.com>
In-Reply-To: <20261124132521.GJ3898744@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
 <20261119022903.1493494-1-shunsheng1218@gmail.com>
 <20261124022219.1834499-1-shunsheng1218@gmail.com>
 <20261124132521.GJ3898744@ragnatech.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Niklas,

Thanks for reviewing this.

The devm_free_irq() calls are intended to protect the lifetime of the
sensor objects, rather than only to wait for an in-flight handler.

The driver requests its shared IRQs before allocating the individual
sensor priv objects.  Because devres releases resources in reverse
order, those objects can be freed before the managed IRQ handlers are
released.

Even after the thermal interrupt sources are masked, another device
sharing the IRQ line can trigger rcar_thermal_irq().  The handler still
walks common->head and calls rcar_thermal_had_changed() for each sensor,
even when the masked status is zero.

Therefore, synchronize_irq() would wait for the current handler, but
would not prevent a later invocation from accessing the freed sensor
objects.

devm_free_irq() removes this driver's handler before the sensor objects
can be freed, while leaving other users of the shared IRQ intact.

I agree that the commit message should distinguish this lifetime issue
from the delayed-work race more clearly.

Thanks,
Yaohan
