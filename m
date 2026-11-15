Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703711;
	b=LrSIkUtXQg1pf6OldnlZDgDtNrqu+T++Bi6Qxkab3ElgGU5Fw6evCaZVaqbpDcUFSXi8
	 PerazCoxCtELf2PIK3+biqLmuT2Nof72jzUDpSg7QvRGrJPUcuBVQEK2JoGZbWe51T703
	 bIco9Ut4ZuvO3iYtXhciZaiDVy9icGopaWsdkvAG/GzwS1tdqkvDcxFzbiaBYuJvccw46
	 Ttsp4pGkvKsDXl84CCONsB71KsiFPua7PqR3BZbBjnOJG/VJjT4CaGZCzhCVddi3A54kb
	 +7PSlfLh4nuZWZmnW0VfLwan4yDgQSKE3R4XG2an6Wn5ekLjZimVRk2sH6zNh4Halkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GNCaXsk/Xt/PN42cfY6qixho/TvY1Q+vI598MxtapPE=;
	b=n93u6BYwyMJzNVPeyGtd/E6xFIrsrtS3wsfNzi/f0fdxskbwyi+wybf8hHa5PHN9xres
	 bGNbQIDosd9PI81EzBNLuyi84J3nfvtotBvMW0yOvQpuUkbZuy+yf7Y5rDjlDX+IpjkG8
	 eE5D4iWpkSji3BqURbaPnwKgAr7+hv4GyGLTVRS2iBcGpW0ijZyW94Oq8BOXdJLlqDjvT
	 l/m7KBrsibm5wNEbVBQHtI9F+4iExPc2ax+SjDK/wRiC9EIrJJ9WCvqL82mEEBbkYZrKI
	 pvBV+SYhkbITkhIyGmdiNIWY3UVMC8hc+PohGygvr+AM/stymWjWKgbf22gd9UxIWgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DMcqLdbV;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C095606A329
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C095606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DMcqLdbV
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b75712fb57so2978343a12.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794703709; x=1795308509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNCaXsk/Xt/PN42cfY6qixho/TvY1Q+vI598MxtapPE=;
        b=DMcqLdbVjGQlExaBwxojv82/j1Te2Q8Gs0X17+IG0qyDhCFq+1Nt0dCxNncZ0loGmW
         ZfI5Ao6vE177C6wnSiZfUM7gpK6TuV+0KHsIWXhF/pUoR/PEaV8i6FwFa8Va6yqt/LHd
         h4CEm6Y8C0QXmF+mbfPCvi3DAy7buSqHon2Fx7W1oNtPLWQF4dvDeGIiU8u6lhB8Pti+
         pTIgV5tBB/eUMPJUVssMgjiqdsIAR0Wbd0u+0ec3qtj9TxZyDqlxy9VfCEv1GId/mNun
         1Mml1QtgowP/lu9GKK8iFct9z8Y0WG9Rl7uCqfPiyT2DdUYnrbgZKrSzwm5A3UZj7A82
         ZHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794703709; x=1795308509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNCaXsk/Xt/PN42cfY6qixho/TvY1Q+vI598MxtapPE=;
        b=H1wkzENgs4FrxNM0H3FcY1hWouCEfJK/8GLOzOamIQOmk9ZBTIMLdglZAFZlhgRicT
         7b8SeH54syMRtblQqKFtOVMTRNGVmk2czsC6qKUcVxQQMmzPqUu46yM1V1x12Aeau2hG
         t5ngYUKKCp0S6qRVkRHPzxS3QsopGsVQTrZDn+sAyrBSy6gZaEuLStb/Jesr3Ud8Qjwr
         0rh8K1ycoKfQ8Blrub+1/OI/+JafMMzO3+mLn22PHMilhy2Od17URqXWm6aG28jQF+xV
         MWQOYABIJNCfvXkTRVMATypDrpcHDaIVniUuaZn5dlnaafMM+HGd42z3j9Lqv7UCQ9Pr
         cXlQ==
X-Forwarded-Encrypted: i=1; AL+hErF5Ub0x9O4LErpUYEISr6FpdquX1FFyKW6eVQ0M1x4yxXZsoPjDH59+igSU+6dQnYtuImn1ToiPjg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+NOfEoSVcEY36wkB/E1MG5squDdBNbUv7xEj4LJZbGVoYgEV/Y
	IyPZDQS5xlQL6hj5BYnZX5D9RnA7Z2KwLtDYGOmc7PAmS7JVNAGSrMuU1JOX5F0=
X-Gm-Gg: AYBFou2z0yjO9xsI6bJJewfDsAg0myOKl4ZQtSFI1RWb6rBuOmZWU7efxjGd4UqdXig
	b8Cq5TTy1343Y4T0A59ei5GPR1b9Ri1I3kLKZK35jwjesFWaJL6f5atCQnAJji5YT7+EHfHvvfm
	IfYUQ7INSJF22bLv2kkPo1q7438f5IQg6Nn3G6WgdfwUt/g9awx7iP9Ovq1VvDu/H2bD5mx4o1I
	/ajJiDfrsMc/EhhytpOya2TZnp1vvRIHvhzxKHPUS1l6tMefxImmn+PaxUg6PUHVtZDTgNrKhOM
	fiRZvag+4E/56px5+IVIaapL7QFZ4GuRConQ8OH3MJYYJjO6IRsqqBZ9l92ZKM5B5NpSKcuwhy6
	w16vxPV7Rl0wkizyQyxPJ2cGjvd8197E2MKRtL1EUnIvtLuFXKOmdGCfB9hbWhqsYkmZoKT7s5R
	XNEsMtKaosr32b3Qq2FXuvYUlleV+YKm6aNdJZubaIwyEiDOWMM6cty1fHGaC9Y5dGZnFqWDgo0
	5FM60vy2Pzm+sULEzDPrIHgtiFWmhxsgpNA+Wls4L29VeDNRnHXZeBZNg2qtifKrTqxqz7sMjrq
	s/J2l4Tf10zUI4nbKv1LcN0fETERSdMvFJ7Lw4MKz6ZygHbdwymnuZhGWbg5lcKdMqJYWYPh7oB
	f5tLW6uAycl8XNLyCWXHFcyIq6eYfN1p8r7QU
X-Received: by 2002:a05:6402:a513:10b0:6b5:6ba3:5860 with SMTP id 4fb4d7f45d1cf-6b7c0c12b08mr3317211a12.17.1794703709333;
        Sat, 14 Nov 2026 16:48:29 -0800 (PST)
Received: from sohrab-omarchy.taila18b31.ts.net (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23dde49sm2857574a12.23.2026.11.14.16.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:48:28 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: admin@mswin.me
Cc: konradybcio@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: sm6125: add TSENS die temperature sensing
Date: Sun, 15 Nov 2026 01:48:24 +0100
Message-ID: <20261115004824.395133-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <a3f071d3-6082-47a1-bb00-9d8e72fa3cdd@mswin.me>
References: <a3f071d3-6082-47a1-bb00-9d8e72fa3cdd@mswin.me>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Roman,

On 16.09.2026 10:16, Roman Linev wrote:
> cpu4..cpu7 are the downstream cpu-1-{0..3} cluster
> sensors: they get #cooling-cells and per-CPU passive cooling maps, which
> stay inert until a cpufreq driver registers cooling devices.

I have been running the same TSENS description on a Mi A3 (laurel-sprout),
derived independently from the downstream trinket DT: same TM/SROT
addresses, 16 sensors, SPI 275/190 and the same sensor map. It currently
runs on next-20261113 and the zones read sane values.

I also have cpufreq-hw and CPU idle states for SM6125 working on that
phone, which is the piece your cooling maps are waiting for. I just sent
them as "[PATCH 0/3] arm64: dts: qcom: sm6125: Add cpufreq-hw and CPU idle
states" (you are on Cc) and left #cooling-cells out so that it does not
conflict with your patch 2/2.

I could only find v2 as a reply inside the v1 thread, without reviews
since. Did I miss a standalone posting? If not, it may be worth resending
it as its own series so that it gets picked up. Either way I will test the
latest version on my phone and reply with a Tested-by.

Thanks,
Majid
