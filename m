Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246541;
	b=CAwhtlNLz2XJYx+SH8KtwkTOL9pW6wThS2zCcVZx3ZHJQ1qayfTYyvwxh8B6Z+ZWwbv7
	 TSi5zi4PoYv1T/RBArHj4o3AHuFto2Gq3HDrWSGkQ6kmmqmUrlDK3nSNvoizoOjhZ+2uw
	 I56Jj4VUJtiiGmiMyWn0j2xefD3EkZ0EdNCHGfYw6brlC4AOFy6oWzFHrSMOOC9AA8KHP
	 zKtrlYmysP18H8uPGVH1A/hWGrvuxv14yQgQrG4df9g1iGZiKEVp8Nwl9onvQhcUYyyfS
	 MoF7K5p739LMXVOPK69AVVG12DKe6TuKuLNqL3nEYoZqTSXWszplBRIoIFPmEuAbZMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MmsV1ThD3E4KMfcEvrDULM6QGE9kBcLsTn0dQnSK4co=;
	b=cw5yno7pYZKg6sEqlhGMmg4QAESgbb1Rml+DG/UcM8TYerh5b0yN6JG0uIoyui6UVSWl
	 Ry2N2XJW2EVVAbmaysXRKJ8UKXP6ghWSXznncJEyNg4rnu+3GjkxYYYe+pUX2xBhUV4cM
	 3Ouas9/voSnHK8B/NOjZMFSOna1RiDQMC7xiJdpfjFug9JZHgNY0y28GpcT+pri5uCc8c
	 XoWWSu03FUvGVHKKkxAo5wogXATNgITkD7geKU3I4Y8ef8aW7hM08eCivSJhZe9hf9+BF
	 4R4Vi3JRYJbXzUre1ipfEZfkRSpqG97l0afdeqPt6LwHw6A1zoKTulC4cGbHB579iPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9wQ32cP;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216F606A321
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 17:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3216F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9wQ32cP
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so14282765e9.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794246539; x=1794851339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmsV1ThD3E4KMfcEvrDULM6QGE9kBcLsTn0dQnSK4co=;
        b=q9wQ32cPD0so3ZqfuhtKzNTUawAwni8LAA8qq7zVdmSmiF2zoYuT7nv4t184BwaTAx
         OSusIKeJYV0aDt/JPYmkZUSgwBgqWd3VhxAejdJTZpysRLOf3WCdcgDzYXUgA73NiN4M
         qiNOwHZi/reQYemYTyQAQ/eTQ9rMsfpsbuBv9P2jbo5EhDzrw2BYaYlgQqzrh+LfNJBr
         EOwopcYxM34WU5x/tjB9XzT6iz7XSHllAYxdDpf8NzmVJVXzcliqMLHzvcmZFMMGoR/i
         g5qScX3lT6mQmHrFPjwmUrs3xEiFCQ8OeWMD/xhW81ym/Hvw9mHJsnjSi65NvzMA9CT6
         UhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246539; x=1794851339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmsV1ThD3E4KMfcEvrDULM6QGE9kBcLsTn0dQnSK4co=;
        b=UJshy3vrKARlwl55jdVDHci91tpUsDXRwm7+JHt/9Y4ezY73VIIR3a2ho/A0ahImCp
         8wA4uCEbcujUde9z2wXzdssHZQ+Y8pO8KYdxPHOJWbsdms+XEQRWlExoMiAGhpkEIHi0
         9vAwa8l70TYj3Bhja9iUYApr4lssql0jphRwcd+zKclJH9I0QaXVOw2PV78Ym+Y/TZVE
         Y72K9L7/6mwhwX10mNbvVrFms65mihPiCGDXoCRpwRiO1l+LsbSDgvbE2tD0TyNCk8QK
         iYrEvpcQT/cvsCFBVIGtcepKI3ZSpTbp5oZXv03GGjnoKptw9t20NwbApbI2fZuY3NG3
         19Gg==
X-Forwarded-Encrypted: i=1; AL+hErE0666tHbiOzw6LF4Hfy7oyUOSZsRSqu/MGFHDQBTCbGp5m8yXsWLnbq5IS7advoT9nkLh0+rLj2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+KfF6gq88yGLYAUwf/olm3uzLfVoel0A6SjggEdHicl4wRLogz
	LN2BmvBjOjaIPol8jzGu0OMfaXCpeWrxTeoS+fsz+La4Ebue93GVx86t
X-Gm-Gg: AYBFou3NlLEk9oWxMOKzQCB4B5J7Dmn0hTq/UQsXR4BYPD2BEENLRIwO8bjoct57yIb
	RTjaBfkDUPO29Oupjqn+iddeu8HRGmbX7A58TifrQuN9ccwwZksnGev98E5CX1Y8vlOtjto7ODR
	xkqetyr+B3xGfjEvA3ftapefSGfT2fuKukECxLScwl2DGpGe94liy7AHgWiIocjTDfmvLEzH0A3
	v6x9kzuFZWQSbcZxRqh9R2T1+6/SJlTlHD0xBkYdegd/Y1rTsVQj0NcscCPujRLsS79Tt9/9rGd
	zzYvkrQuNjSSp94LGK/o2o3KlWWthx8+waV32UkmdmClOFSF1d5u71ES1w+0UqjiL20DRw88MV2
	UyOSYOuKvXM+ftROPzV+rX35500A0TMEu/A3ZuXwjoAfK/NhSUHkTke3uMBggaSGpYz1R0S1PlL
	VLh00VGd2FPElXTExBn76DT23TZk6AUaiRlpqSTc2TdVU57EZRImRnR4i9LQhrgOAaHiHZGrEy6
	BQCjN8x4U+gU5UOQptUEsr8StgqbMYOSzy+b/9X5LF00aOHqkfJH+NrEw4sEJv1SRTMU1xiW7Wb
	Ft/ZEvLRgOERDE/2s8sdWjDI+yU=
X-Received: by 2002:a05:600c:6218:b0:4a1:a6e0:4ce4 with SMTP id 5b1f17b1804b1-4b963c88030mr89979545e9.33.1794246539561;
        Mon, 09 Nov 2026 09:48:59 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01d89f22sm7619465e9.3.2026.11.09.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:48:59 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Add Halliday interconnect provider driver
Date: Mon,  9 Nov 2026 17:48:46 +0000
Message-ID: <20261109174846.2091271-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f942043d-a46e-4792-b8cc-a00280eef29b@oss.qualcomm.com>
References: <20261109-halliday-icc-v1-0-def7cf786f75@gmail.com> <20261109-halliday-icc-v1-2-def7cf786f75@gmail.com> <f942043d-a46e-4792-b8cc-a00280eef29b@oss.qualcomm.com>
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

On 09/11/2026 14:30, Konrad Dybcio wrote:
> On 11/9/26 1:29 AM, Stanislav Aleksandrov wrote:
>> +static struct qcom_icc_node qhm_qup1;
>> +static struct qcom_icc_node qnm_a1noc_cfg;
>> +static struct qcom_icc_node xm_ufs_mem;
>> +static struct qcom_icc_node xm_usb3_0;
>
> Please take a look at the newest files in there, you can remove these
> forward-definitions. Otherwise, I think this looks good

Thanks, I'll drop them in v2.

Stanislav
