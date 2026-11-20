Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795135156;
	b=jbqIyUow/zUnpW/a5qpOEX5tC82lerSKkAPFXxPZ8OpIqcRFM692poui0WLhQAYgH9Zh
	 9TyABhRIka6a7LPlm9rgIOCNsJhnWGY8z4Xj/WG7Gy0W33gzH/6vov/lDhpID4edTWJ3C
	 ZAuPsMlP5h4BHTUa9pZ7pGtwCucePBxlBJ7njip601wtsusYc6QQDhSPhlmq2LUll13Or
	 BOJDQEwv+hc7yqt4WcRV2I34QS/ygzidKna07Gz70hJ7zo/3PGx/OmiX1pJI0hE901iM/
	 z6Pw1iRNK1TzLRTKRXTzRoGwQZOuzwAWLGTzUugzrZfl9Ffsqmxt9+mnmaGLEbvHEdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Message-ID:Subject:To:Cc:In-Reply-To:References:MIME-Version:
	 Date:Content-Type:Content-Transfer-Encoding;
	bh=5gxwyGctvojwIiXOCGBcUPizSCDvTG4IBxX7KHgzhdg=;
	b=vUVa3NyoWK2MdkOuECEA+LCNa2Chw9H1USMs68m3Bi/il/5Z/AR8uYs0WyprrJgv80yU
	 HetYLo80dl+5goacsO2Eag+gBDj0je2274/VPP7QerYciI5P8StLq9N7kiT0iUN32sjM1
	 E8Sbr3UWx4MAfRYhNjJpwYgSGwblSnKN/yLUjJRD7pm5bbG9Juv+Z5cZolUwZ8wq+XyRS
	 r1zlYTVClZekNH+CycGM+UrZIDfJ3j+7Wdgvtd/eDZY1+kH0xCOCjtWUwJWBXoh4V+/J4
	 adeiNxnb/LzsBJCQZn+LZbcmsKe5g+xKYPyBjyQMyikMnecpGmI18ZpFEMpAMzrS3qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AXIrbsRs;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A1606A326
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 00:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB2A1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AXIrbsRs
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3acec6677so532124c88.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 16:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795135155; x=1795739955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:cc:to:subject:message-id:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5gxwyGctvojwIiXOCGBcUPizSCDvTG4IBxX7KHgzhdg=;
        b=AXIrbsRssxXaO3w8GrpTDhyAHBoe8gHl6vr1AgWK/cwk9Q07YyUHncFHncJa46UUL3
         TgmkdDVvNftjYQdNRFgZsqI49nDzWumOSnYxV8wcUZs5Gcnn3anIwpCjKujLDJwmC8iK
         6ZK6VAZw9CgJl7Df/Bzv063r+hBx0B4fidZsdWJ1jC9OEal3iZJMf2BxLf882Td28SIX
         Wz+DJjNddHav9pLJ2ujtZ60os7JcAtjRIXP90PgnT+QSy1hSyARUgJcqpbzkKFaDOm2z
         mIqhczej3xSQrEXsLvf0mbJQVNl2nG2Qp8a8zIM9aNMdpQWUM+0SIaeq3USPn5pQh7m9
         qPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795135155; x=1795739955;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:cc:to:subject:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gxwyGctvojwIiXOCGBcUPizSCDvTG4IBxX7KHgzhdg=;
        b=GT8/KxyIZRHYnETNHmXO53+8Yl4FbE4SmxSPYNwPaicZhkeTMThi3fy2xZoKUj3arj
         SPAJCFKIVDi4JI2S4fKikNmsraWH9WZUl01mpaev49/DQPzB++6wze4qPh+N/z7NsLx0
         ZoIMdxQD3dGHh9clJoXyIhOvKPRpKuh+BX+j/bULApRQCO1Z33oMpeOnQ+Racn6POGHN
         LeiqRN28CZW6FaZmMFZuoEXd9OqwKCddZk0x58E3Lp8KCJkdHCYseFEmbykaac+AkqAt
         0Kbh0Kzu+s7xU4vVGavkGTLNglqcxZRBDIWlWgDCmfumzIeBSlwQ6OebCTuHJgXjT8xx
         59dQ==
X-Forwarded-Encrypted: i=1; AL+hErEGl7Pi2e16FhX/wi6CNbeMkP8aUucjb8XszBuTlXVKRH0vRIFxWIKtjcBjTD6DvMDLarqMJEYvnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9htjEQfFeRPkmEcFbho3BD460h720c8YXQxfIQqYpFRHvRiznd
	othj+itOm+ySQWndjSm14XLPUje0oDvFPfw9qr3aRqWBHklbZAJmQJXN
X-Gm-Gg: AYBFou0UReSGH7qMWmy6uJc4lqh3nM8AO3sjQVWR+V8dC8CrQCBdakC6e2Fwoc4M2Pc
	dR3p6AFvgtoOGc3yWVWOU34HH0DngdoRY5c2QXWdXwujohmxXUkEVffMpSgsCtVV5/qjxpO+APX
	tM1xk8CXRpfsYt8qqS0oAbYX7aJQy5OcvXB5Fmt8ojgiRQeENvXEwJhSeMwaERZkUFMPB8INzt/
	+6QF/r5Utehw+KvtRFTLaTgNPWwyM7fcnBpRUkl53aLyl9X0CT6i6qqiNgpQnhc6etPq7/rq+Tx
	5sN93Lb/7CRWwKnwAJFiRG3QuAmftPD2qPtxEUM4n+exZxJTshWZK9Q1KTYaefk9UZUj/LjojeS
	kEiAtCuoDQfdnbtmygTaQ581i232pYm1y1M3AwbNJF0CSslr8SHxfYXhDqJngpy41/HuBuEmWEJ
	tKmwgOGfPI6zRYBS7iPJgCqpFLXVrcetOUSVnRJIM1WwGdWYOZ+i/PT5wAOoCo4G5KDZk8g/5xt
	AoS14DEMwzQYIIJLOjrXkppXIvdaKOp5WpVbBWtkMcF6cPE2iXlnQEI3BfBzR5ueziHRHeOIPNl
	R3LEE5KLT0N0zGD5ogLtpTJTS7j11+2Cb8+/eACdNMWhqA3QvDbZ1AlQtOcfL7h3Z/K3rIOdhCN
	LQ9FYABN1PdGLnzFkttSb2ZmK5QoKgCQUNtdekDY70dPtEstdn/M=
X-Received: by 2002:a05:701b:4555:20b0:1b5:2988:eba7 with SMTP id a92af1059eb24-1b556947286mr1278313c88.41.1795135154985;
        Thu, 19 Nov 2026 16:39:14 -0800 (PST)
Received: from [127.0.0.1] (ip68-107-67-45.sd.sd.cox.net. [68.107.67.45])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm2184747c88.10.2026.11.19.16.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:39:14 -0800 (PST)
From: jasmeet.bhatia.us@gmail.com
Message-ID: <32909f9cc196a161bf380b6f64603b75@gmail.com>
Subject: Re: [PATCH v1 0/2] efi/tpm: Preserve event log without changing x86
 E820
To: ilias.apalodimas@linaro.org
Cc: ardb@kernel.org, rafael@kernel.org, pavel@ucw.cz, linux-efi@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAC_iWjJ1L5MYWy2vHG3AHYcfqx7urJmaTYP7vuyvZm8GSnWCDw@mail.gmail.com>
References: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com>
 <a9e23066-aa75-44be-ac3b-9a15f4cf6047@app.fastmail.com>
 <DL6NCV1KQ9F9.6K6XZQCS4AF3@gmail.com>
 <c3ca811b-a6eb-4f4d-bbb2-4feef02e3db2@app.fastmail.com>
 <CAC_iWjL9jDsRaU7kEemYfwk292Nxa49cK0Rq=81pC=FWNRDhvg@mail.gmail.com>
 <b66f68b5220ddcadddb41340d3ea3388@gmail.com>
 <CAC_iWjJ1L5MYWy2vHG3AHYcfqx7urJmaTYP7vuyvZm8GSnWCDw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 20 Nov 2026 00:39:13 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Ilias,

On Wed Nov 18, 2026 at 10:11 PM -08:00, Ilias Apalodimas wrote:
> Hi Jasmeet,
> 
> On Wed, 18 Nov 2026 at 04:57, <jasmeet.bhatia.us@gmail.com> wrote:
> >
> > Hi Ard and Ilias,
> >
> > I wanted to follow up on this discussion after a couple of months.
> > My bad at being slow, at keep this discussion moving.
> >
> > Has there been any more considerations with the preferred approach,
> > regarding the EFI TPM event log reference and kexec?
> >
> > This issue is still relevant to Framework 16 owners and the temporary
> > fix has been confirmed to work for other users despite not being a
> > proper fix to this issue.
> >
> > I'm always happy to prepare and test any patches once we decide what
> > direction we want to move forward towards!
> 
> Ard suggested we discard the EventLog on kexecs and I agree that in
> its current state it doesn't offer much to security. Is there any
> specific reason you want it to survive?
> 

No, I don't have a specific reason to preseve the TPM event log across
kexec. My original patch only preserved it to avoid adding any
regressions, but I do agree that not preserving the event log would
simplify things greatly, and I can't think of it providing much value.

I'm hoping that will allow us to return back to the EFI_LOADER_DATA and
the E820 instability issue that was causing hibernation failures on
Framework laptops, and possibly other devices.

If you and Ard are comfortable with that approach, I'd be happy to prep
that patch and test it!

Thanks again for the guidance!

Jazz

