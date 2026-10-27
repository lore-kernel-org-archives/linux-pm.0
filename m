Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793137580;
	b=cosI3Sjcr+sUT9M9vMsOpxuy64TWLByhvgKpH/iXnTjkvC3aEXudfQ6E9d0Y3d9FwPAZ
	 fDF+uOGJ6XHf9ZMw3FVnod0Vj9+tW4qH7ff6xDXolxOIWIe+K4emn3FC/AAB6c3p1RnFn
	 cFRLHtSSLC7eWT0Np57FzCFmDAWqs9JQ3OJba0gRmvXnAtLVxxJBRksqaKwvcjzb99SQE
	 jJMXg6ckjNrLz4RUx+bdpSvUdfiji+Y2iHJNSvO45JYc3NrxU2v4OmW222/oHsQuJZAsK
	 Gl/As7UnIgZBjbJoTRoTHI94rkTb6buTYUra+WZzq2PF9xcBqQ95hVmmWL9iNwoFY0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:References:
	 In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index;
	bh=QFC3dMXMjls1OkSJlBz/j7yjixIsRn3p3uTGKR2xSH8=;
	b=q64IEX86erVdZ3NuQlcjNLQwNhWF4scQ+qHN7/9zZC0+jFhtdWhE/pWzDa5DK3Jw4Bns
	 mw9JG0J0sqqpN2YOLoqBQuGm4HhodIGj/Q9eg4tHsVid1NzA2yvnR+2aJlWc76NinG59o
	 LfLweBJo+NXl8FCdr5PmiIL0FbA94hkbXNJpYJZp25J7cgww5Tya6q5vH0HQ8tFBJqR1/
	 Y5covrvapI8yLrMyUhffmfae+uNfVMMu75lY3SY4dNQznrFw//SvwJ62VzHfB2wepJOf6
	 Q8NwDwOJEEYU3maepr4gky4i+GNQLMoH/sKCievJTR0fgize+vEilZzAkYjnZTYR+OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=telus.net;
	spf=pass smtp.mailfrom=telus.net;
	dkim=pass header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b="g8q2+/rz";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10A606A320
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 21:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F10A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=g8q2+/rz
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso264149a91.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1793137575; x=1793742375; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QFC3dMXMjls1OkSJlBz/j7yjixIsRn3p3uTGKR2xSH8=;
        b=g8q2+/rzhXuw6wKxw3KV2YR8BX8fg8Kds2z2AHAyF/6JetyVQz4ZLH8Ai7afnJXTmY
         mBbrKrodlIwcZK8ucZSVgMvatETDXNsIcJBix65BYRskrHTQ9fKkvRh4efC4wdsEIewB
         9kyRI0nT1p0qA8voAv9umdpuN3E4Gqlttse/fQ9LpiF9zaZubPw92b49AylMKdcFofUo
         TeKjfLgMxvEyyn0Ibmb9vA+tGlF6JzNksa6TAbxjdF37cIBdLaEUX/eR1hRccxN38iNH
         evz/3wIgh40x4x9VZ4jprGK7pMQHUuXcSfoENNZltFrbg0k5D4ZcQ6l5GMYSpNabUJ6u
         4wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793137575; x=1793742375;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QFC3dMXMjls1OkSJlBz/j7yjixIsRn3p3uTGKR2xSH8=;
        b=dezfS7uRXHkE4dcUWXQLxtXIcBT35aWKkdXfuP91b2A3d74dc5gakz+oG5N1G6CVRF
         5sDVJGshue3jVj/RZrkl6f4+NM6MwZoAp9pLAS3AScDU1e/mvXiepcnQQyC2A4a/GOZ9
         HwkHYLUQMrLWcdVwPEJT4Z5ZKB8X/O/f1v4JoUDGoP7WhmDcXeIKMB29Z1no12kvkByl
         ruAJ0AWv2Wusoz0Ccr3HMrHx/T5cfcJUnI0y2px12cpZ1+SlQCZ6SM98zpYTtQxcko+R
         heWPTShHVx2abEadc1VSQbsyJ0PDc57n69PhAwkXRwTOEZZXpC/fm1A/+OnrwVRdMQqx
         wX1A==
X-Gm-Message-State: AFq9FYL4ARxaFo06jV86wnG6dn4D2baeuLwJycVfbTx5gto/q5xiEUv3
	kT/y/HlIj2i2fyvzKRGsyRWTdO1u9QqrqJhFrqniSi4QxuCtvzNATHM2OMgjDUw8rEU=
X-Gm-Gg: AYBFou0pDrvXBMM6O8IlJQjFzZtVh+XELKRZApleEfR67bMLw42Av25egc439fuVtIa
	YHxylE/i6JxIUzKwsVbLuOgZ6FbfI7NlQJroiYfS/OdHcWrps+nZHzn4cClNm3TVPqLJdscEn+S
	aQK5qGyPHk1C1bL4D0orTNRcU8Bw9z6WlcqyMUM2v6qia3YuJBLw/xQiU8ZNJTqINXUvrlQGYRp
	RriSIkEwS47dyfzMm0SxEOZt4rk3KNEg/9OJSJUGWgV7VrZGuXrRmz52Qrx+2ogPcd8ltdU72Yh
	bjb4TkN5MB3dr06fcAl21YaJxrUaMcgAS8rI+A5NYS7I2WASYIlwOMi6ZJ67aKMUfXvDqcHoeN5
	3dloL7v2L3InKYLRLB82CvWlD5Q+hpa7eYpe9/eFIF9d3Vcf5PKA7q8PY8O50HNlaeATUytP/TD
	tU+RNivyTHCYZrSdvGjd4eFaweRC7ttMqmBmNoaxsATkPVMQUsZ8rJvLYKZ6yItlRhWGFXWRqTs
	tj5wh1SiUxoKaM8v5BQRNlSwW35+m6A7IkE3z73REFogGzMXNmTMPQSet9bcN4=
X-Received: by 2002:a17:90b:4a45:b0:3aa:fc22:8ab4 with SMTP id 98e67ed59e1d1-3ae58100ffcmr211135a91.29.1793137574706;
        Tue, 27 Oct 2026 14:46:14 -0700 (PDT)
Received: from DougS18 ([66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9a60f8sm33185a91.11.2026.10.27.14.46.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:46:14 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki \(Intel\)'" <rafael@kernel.org>,
	"'Zak'" <zakbrightonknight@gmail.com>
Cc: <linux-pm@vger.kernel.org>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
	"'Viresh Kumar'" <viresh.kumar@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com> <001101dd6631$6167dbd0$24379370$@telus.net> <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume without HWP
Date: Tue, 27 Oct 2026 14:46:15 -0700
Message-ID: <004401dd665c$97eda060$c7c8e120$@telus.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+ka4iSAouj32QbdBtcmCOlo9WegIHF20PAY25hX23Mu5WwA==

On 2026.10.27 Rafael wrote:
> On Tue, Oct 27, 2026 at 5:36=E2=80=AFPM Doug Smythies =
<dsmythies@telus.net> wrote:>
>> On 2026.10.27 07:37 Zak Brighton Knight wrote:

...

>> I confirm your findings and tested your proposed patch. It all worked =
fine.
>> I had not seen Rafaels's reply about a possible race condition until =
now.
>>
>> Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled.
>
> Passive or active mode?

Apologies for the incomplete report.

Passive mode has the issue. Active mode was fine without the need for =
the patch.

... Doug


