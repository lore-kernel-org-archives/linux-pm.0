Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794412551;
	b=O6foP3Md496+b89eunxRIw3HKgqee7mnjBFluS7IFH6CUwPvLsxU7/hohfOQFXqwdstK
	 5dCzRmGE8H6MRnnTaU/YHEIjGWaIEEBrKW3w3+fwwUV6vJF4ric0fLwnT99XxYb3eePni
	 i3dAT5a8kU0lCBmeMdA5g8DW3p9IUnJmyZZR/kVX8OOjTW6ECBiDsPH2fKbwV8Ziw/7Ff
	 E/BLPwWKIg5EfPK4hkR3KkDzrtwumuNPltToWp7ilNIxAQkoUBQuqYm41EGGq62F8ycoJ
	 lwEiBqdn9ULWAqf1dI8j4ddC/BNmseya+JW9dZBX7NZGc1peCDSiQX50pKdSwM9SXnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CZ2sF011bYx56k309E4sDnRFziIX937z5+0Drmm4Jfk=;
	b=D5OwzmI0k9hqiKEPZcHyHXJLPrTZQeI5YB/pO3Yl+r8r3EnjMi0o4MMIHoRxjWQrGNJy
	 U+kP3UrtMZjn8JzFj6LileZcdyHxwGBL8+uKMz4DPcOI/JciM8XlFOpZ2onXu3+vbANRe
	 lP4IjW6piF7EeQbCrhF2MkQLWQJVGF6lBYnzoCPJA9AsD1UFQCLHjmkLnGpS0uDDsAIt6
	 +/OeQ+d7951WepGmDiOIuGjvmm+asCb1ZxaJOeFChEmgs5Tl8kMO3swcUeewsp+s6rMN0
	 aeEQVJPCHpiCVfqA1Nw4FZtS42KRDrhsaTS0+3dqng8RonY6OFZp2JYDJUHPuq2zCBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnpzOxUy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B2606A32D
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 15:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9B2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnpzOxUy
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1643054b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 07:55:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412551; cv=none;
        d=google.com; s=arc-20260327;
        b=E4ZaZF4v1hhKPipJ9yRSpvsmDteWS9jXB8p+uTLWpH7kaZvRZm8eum/X/cqPxmo0Sb
         StiAwYizmH6mFIxr7vni1SxzKq+zHx4zcbf57St0NHmkTbAmLb/OhXR76RIvqNARR80n
         qPrKYyJ0OhCUBF5FM2coD/S6YQoxEKwkiMKhrW7qMpcXnVw1lDMJfqrbpGCahbvh06Ub
         Jghj3jBsYjvFnFnn79n95A9gT0XeEW1/UdShOvuNrbFnw1p2dqSlHvU/9EfYFjGjKd8u
         NEIuqT9I3GLitO0rtlsE8qpW/YX/fTfZTWHNSuFLV4lBBshe1gX6QcO4hrB7cewQN/RM
         8+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CZ2sF011bYx56k309E4sDnRFziIX937z5+0Drmm4Jfk=;
        fh=LTPmXtNmQFi1uEJNYkkUGXYhcMco7E+QiPnCIwtprSQ=;
        b=tA/DwO5NHZ49kpECHaIojjMq7gtg4B7tawdY6nb7+c0MqskU24tV7GXXYS9mkbPD/J
         Z/nWXpJX99i9Z0MK92FXndwUjKoApX4auit/fzEKn09JxuPBnxQAMsHboHRrj8kRyi4v
         CszunN5k4C7zt0sEhYT/2h3cNtPzUIWxJLYCvBwgIbZWSxSJkNCOiJB6OlyH4Z6/sjRp
         ZZ6hvR93WY3kNf6Lbzh/WKf8B23rfh/PPyVzs3lnyXCzVyuz4mcBzmXsksmzIXv+rFoj
         HCH28eUNwvTdgoKos5mC23s1i3RRvDzkhAuDy3AwCFSqsNkXiDcPNYFDitZ5/OePGvdI
         tw3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794412551; x=1795017351; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZ2sF011bYx56k309E4sDnRFziIX937z5+0Drmm4Jfk=;
        b=GnpzOxUy4rtgzNNLgX+1nomUXNuIHp53Bb4QeqNZPr9C0BESqjTBblv5P88ZrEwhNJ
         HqdI/+q1RiCVzqd7KN9qo8dEi7r2EJQNlVpb2Ujv/6H11S+0ut49gOPNZOhTF082qNzB
         mbxxOPQwperNCfSTnWDebONPUWXcTrpmtOs92r/iFhpRiILu41A83Ukw516mYwpJRSBs
         n3TzOO5dPHdeBs5g5sDSAgPrz3ecXvlJEeQVoY9eFJICeZ0BW57qyYWxQcRPNI1ma48x
         bJIhSBVuXPJEeZ3PQki4fT8C9KNINmT2wucIwT/4ByDuqd53YDhOhX9SNq3PN5nDQ1fE
         +jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412551; x=1795017351;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CZ2sF011bYx56k309E4sDnRFziIX937z5+0Drmm4Jfk=;
        b=1dxNDNLCkB55nmV4k/PzVGEcG/KRlaY+TCEItCww7jeMn07inzUcv4U5ouexCRNz/C
         PHpRdzZmgcx/6iXpVAU5UcR6G9BGJVJCihmKet9ZcP7oi/2Op8BgBb19O2b3/9RBz9Yh
         qOV8RIPN/j7+SJ7ahUywYjiNI5m5MOMSlvtNrFRMD93c8uv6jX1kY4nzzFydntb7aPeQ
         7XWYkDFEGjRp8xT6EyBqPWxoAPTLtQ+9MvXsxYE+rVJFxgPCwAtRaSC/WMeTaWYDtaBb
         S67Z0jjsUxE9r9yQxtalltDJpcSGqIl+X9lhIq1DI3Zafpze0UEDedyPvUMGhgwEcsaO
         hKfg==
X-Forwarded-Encrypted: i=1; AL+hErF8YynffLAfYEB7YaGxKhr8mR3X0S7ygQqeaFxsjLOE2c7Mb58r3NZqLNR8pKTKVZd5nEfBbtEu3w==@vger.kernel.org
X-Gm-Message-State: APuU4Z97ekNaGSRNRjg+2Ooc1O+Mim1MJ2hIuwIrgURhcei2hxboa307
	CyW5z+FluhnoMN3dL57zFCpNuCUSLraeqd3x85+4EYXSxYDpx1vehN0j5S6XUK2rQOoJrXujEXg
	JgZDtc3aMbV4Jd5WnpOLgJJCHYQVdAFI=
X-Gm-Gg: AYBFou0lwhWvM3eFKQjsjqrquTI0Stor5m/o/VV4oZF2QjlcYVkUgk+dO6GI7qpQjJv
	GN4AHe/IAafiLQ2DCgBTJq2i0JdeCUY7Az0zQQV3trvhIzAhg6/6erM1rKq7GjRO75r7KI59qBq
	nSxXZGeVM7S6vnhjd9AOnvx62EImBC7zQkeVs1hz7PaWp8GZ+Y+WF2rzt4MknWAunJhPN5lx1rW
	yN08W9x14n8zqhuycv2Q/LofFGJWtxxyIuEW1iqMXQ3mXnyyZA8//tr9LT1l8ATx3kSqCIjZ9VZ
	HTdB7N+dNwJ6cRSFDS9EguPUCP3GSf5OcAyhernuEWJRuZZkyglKGdR0yWv9OUgh1f2MrSJEMni
	6u+JAPvIf38UyIIf28SeEYA9CAL1E28Gt1CtO
X-Received: by 2002:a05:6a00:148f:b0:8b5:94e0:91a2 with SMTP id
 d2e1a72fcca58-8bc1b6ff204mr3147477b3a.10.1794412550801; Wed, 11 Nov 2026
 07:55:50 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-halliday-cpufreq-v1-1-d87a397396fd@gmail.com> <07e6065f-d31a-47ce-87a8-dee76d545c18@oss.qualcomm.com>
In-Reply-To: <07e6065f-d31a-47ce-87a8-dee76d545c18@oss.qualcomm.com>
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 11 Nov 2026 15:55:38 +0000
X-Gm-Features: AclHuK_QWl5tUYuHPvePYN4KL-2u0N35nbHD37mi1vC9QZALV0h2AcZUI5iIE98
Message-ID: <CAEo19OgY+iN46pPrGYyCCKoRdAkhLmStOay0Ggd=SVbqRjOYOg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Add Halliday to cpufreq-dt-platdev blocklist
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 14:48:57 +0800, Zhongqiu Han wrote:
> Nit: It is better to use the "cpufreq: dt-platdev:" prefix in the
> subject.

Thanks for the review. I'll update the subject prefix in v2.

Best regards,
Stanislav
