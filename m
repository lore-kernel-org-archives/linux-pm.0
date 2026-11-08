Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794172383;
	b=RgwFdyk+VigT9UYowiGOlx+0PYaMuttNHFC3JiW2ZJ2wPLCRXvMGmYy8IJ6s8aQD3Eji
	 5ppXhUO4pPQQUu9CkJL+qSnLOQW4HQDv8wwH77oeZUZRetn+JA9NNniXAJ/K8RRXt/Hk3
	 TAkZKbZ3oYl+x41b6EM8oqCoCrPb33/SGWaRZJqLU3t/jNidtCcIIhJlMMx1mCitowQop
	 CrjpzZ6xcHEOu65AskF+7ymuQISziNMIK2bpwtj++A9+Ld/PSl+IBl/u/LgxzyjQ9eR6C
	 B2SaHbLQilCumax7yWiht54yCwTuo+mDs4IbY0eGSTQuBnYUAolS+hSTovae27HmslQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yiUBaJeEoNZmSx4wusGC1LfIu6NLX9ueZ6F9sYiAny8=;
	b=c3OL4TeNIMcFbx1wreLI1Vr/RlMLperUQ3Pb7Q9Jqy8nebQpwXimUgIXi1+ukYrXMQvX
	 JK36a0c2eAX9DzDuatD333GHFz3cvJqwFFLHjfeaNllLwKDWBtI7MRW+cNJtFyWXaa+kh
	 1Ey+uT6DbXc4BR+eyxZaP5brfGVXBSpAos51eAaG0ExyhP4lPXwZxo9IKDzRDumjjypS1
	 xZymb9c7NnhZcmUHjuHUcql6VUKT42BuYSMCoN/hJDdJ/jkZCuysBciiU5fPRK9fteNXI
	 ReZDxRwO3hs4waAfa9MBXqVJheKyrz0JHmaiGOl6hEiSPJzu4VdVWuIorPxNTmO+C3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=pqffzjLB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B461606A321
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 21:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B461606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=pqffzjLB
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6767d92cde6so238997d50.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 13:13:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794172382; cv=none;
        d=google.com; s=arc-20260327;
        b=cuihB0wQfdWTByeruv9YwNioalZhMqhGY0/XCcqtslEkVhARdKyFYP8CUebutsXMuu
         B/fw3bdsOZ0VjXwjvMEUWrdFOvSs7TQs5vqaHILiaQ+VtH0yURwOPv3BUwxOV/jDfHWT
         AYF2mxzsLSYldQ0ES2SOS6eU6chIgTX/gWz8w3gRWgd4gIiIlKC4CS7sd2sgvmTBwuoa
         iIjZuq4F9EA4m0TfHyhtTqwbUF9oIAoccIeC/sf3DbPMEjDsGXyB4dUWCrBH2HNGxsYF
         8ttI6+jRGmamgaRbNJT4Af70HF6OoZuazHBnQGODUGeCdyxFRzNeC1FukQLYYEyr4Gr1
         CDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yiUBaJeEoNZmSx4wusGC1LfIu6NLX9ueZ6F9sYiAny8=;
        fh=QoG6kwzxR2iCT2TENgArBKwv+Pn7Hzvz9lXAADZ/BnU=;
        b=bJ+g6uJnyfvXyEuSWRcuPUChrNXQPm3wnAWp/zIfzue4099mXPO0db+wmFX6tIyWBa
         yf+KwkBtsAZtgpojNQwTWlxHj0FUJEIceWQW/OwSAjqMSkuaYvGGGtiF54ZUo9fKILok
         bAoCpL2qo4wC5zaJA7RbgmxyS3/lYvuVcTNVoBtCF1En0QhIO9aipsMvAGRMwPFgbU0b
         zuwp+4bhRk/GXwIlcKhpBAD5cpn3xbQOpN9E0r1QV4YdgRg4GMeNLB/dS+9JTKk423tU
         zl8MrQakAtAfTP1NdCadvvyfWs9NwE5dmX2BihH0/4apKBhkSl9olB/3BZfQbY7sh4r7
         rADQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794172382; x=1794777182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yiUBaJeEoNZmSx4wusGC1LfIu6NLX9ueZ6F9sYiAny8=;
        b=pqffzjLBdDGNrfHUi5kCes/ULy62J13uQQkGThThgnMDZNzJ+gUxu3e6roaR6ck31d
         fRwLxWlkBfGNWm8/uEAQ1UvjSv/rAdjTp4+wvHgX4gI3KiQ9sFcvCgZzvbZEEbRbhaFr
         sCv9kiRelvwO1+1flT1owAsmcTE2VBWbukd1mqQ9Uo9QGFL1BKp02PQW4pqpvTj2no/D
         KcaQWbRImQ9GgQoU4eMui2hmBkrglw4Ee2vhVn92O2B2goN5LHxGGtiKK0j2x+vdlKeV
         +FCgbnYAeETXlghQHSrdGe+rfYP3XVvTV321FcbgTbC3gcyTAtqsvkMIale7nrytTOzv
         0vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172382; x=1794777182;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yiUBaJeEoNZmSx4wusGC1LfIu6NLX9ueZ6F9sYiAny8=;
        b=XlGs4r2pRKu9rFojoZBGiSFlbMj9HSyZJxxYt7RW4fF5xxBvVygC/OioWinWWeKD79
         09F9ufx8s97NlXnM5O79o7Gn+XlhOqmbNTkKroD8uyiZ2/J7iIQTBpSug5zumQy1TzYk
         CMIBH56BPLFUpZKJkxjG8523HnnFMYXvf8P9pezNF3t/SYjb0zWHmRsaGbyS5QRuAcVJ
         sKe+1PWemujQYr0QVy9z0vM848WkrGtg++Zv9dq8Ama1IoenSo+yc5kdLQdapHhq/ktV
         ASlPx7+ae+Ve3qXbaqHl/TKqWZcoxLu0vm5x7GjLI7df6MTlQKRkWF/fzlLPAu0INXJA
         Uopw==
X-Forwarded-Encrypted: i=1; AL+hErHi0iIDEF0vKDgT9CB6lESHyEZ+MRMkr3pXMp9jHHSHRJ6gxmvdtnB7t7fFvsu7wd+tRLJt3m8Sjg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/C2RozHvnA1k5jpd1V22kKvtLtP9VMRHI9FyUScs0fziZ2k80Z
	jbhmIIs7LndvEnyq5J1UeImaBMuH6r6uvwMTGzlH0S4x4zrkThsw/jP8jznKvVzEqyr0x7Zbg7N
	0SJRGCOuPHbxe8GHQgbOEw4dbV+fqpgw=
X-Gm-Gg: AYBFou2HV7z3/bGhlIJJv/PAgl+KXcie2PWXfwDR/uAaNxYxiK2WitaoJ6rCaq9aaRS
	0x+LXhT1KIWYWj77MSRzonofyf7ScMOACsiqGy2NhEjVp2F2uZI4Z40Ua6tAQIACZtstOjElcNr
	pgsOvnWqWi46bw80SF7G/E24ZKRxcK6uj3N2ldQPaDz6jwm49AooCRnH4Hsgx41+bDUqFNS2ptI
	e6/6jMJzf/fOOsv9d7wgPSrrWXGaflIpPtXjRmqLkvH2YN5+5EjZKz9gZtfQd7Mq2vsQar6xql8
	Eg+hVU9UvtLS15eVmfvTX077zJgdzJRMYTFcwp7J4PT3BikT08HEXlc63Ua8qKk9KXBdLHBUD0P
	aiizkcSxfUyRih4nzYl/7BqVsm9mlVkAuHrByWb+weN/orHxhnTR//POJOXCIaAjPGsHHJf582s
	goQz30D0zVoTX6mOc=
X-Received: by 2002:a05:690e:1917:b0:677:ceec:5eb6 with SMTP id
 956f58d0204a3-67c3da75649mr1372951d50.91.1794172382380; Sun, 08 Nov 2026
 13:13:02 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at>
 <20261106101913.46664-3-christian.koever-draxl@student.uibk.ac.at> <CAFBinCDS_toG+4BySkUoXx73a2JWtp+tD6NHwYHk4mU+p+GF=Q@mail.gmail.com>
In-Reply-To: <CAFBinCDS_toG+4BySkUoXx73a2JWtp+tD6NHwYHk4mU+p+GF=Q@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 8 Nov 2026 22:12:51 +0100
X-Gm-Features: AclHuK-s_rDsDj1PWZlIOcV5ImuQxceuPlDPh6uQEE-d_X3ekVMWkJWbJHC7kWk
Message-ID: <CAFBinCADS55=UYVXRFkavSXQFtpCGG-wiXG9r2PSRWPFnppcww@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] thermal/drivers/amlogic: add S4 support
To: christian.koever-draxl@student.uibk.ac.at
Cc: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?B?Q2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhs?= <ckoever@outlook.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 10:07=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Fri, Nov 6, 2026 at 11:19=E2=80=AFAM
> <christian.koever-draxl@student.uibk.ac.at> wrote:
> >
> > From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
> >
> > The S4 CPU sensor reads its calibration through the secure monitor and
> > otherwise matches the T7 setup, including the separate bus and
> > functional clocks, so reuse the T7 data for it.
Sorry for following up so quickly. I think I mis-understood this.
From what I see in the dt-bindings patch the thermal sensor(s) on S4
and T7 are fully identical. If that's the case then sashiko is right
and this patch needs to be dropped (and replaced by using t7 as a
fallback compatible string) in dt-bindings and .dtsi
