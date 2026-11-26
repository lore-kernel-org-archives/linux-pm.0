Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693934;
	b=HbF9xJZdFNFp3f5hrTnJ0cqEf7fV0CiTKJJd/GhxzLrMqUietOdEHE7zCgmGqwwCN1ME
	 EEWEGCAcTL28c32Tk2TpV0DdcUJCyFa8QNNVmOEOtSIX1ABHni+mSSK3JlLG/EN/L1spB
	 GcvEv055BMhojTjCRPobTG/xRlTFunVxL3jHSy6yg8mpolnawXwEsnL+c91MkTLHiErwc
	 3QGUV2iRnxq30xFMmRxZlVBuHozZfHf8CcKs/lhFDeYD/M/Bv53HPMVDt0WeYdtAX3r+G
	 jYGV8Zdp2MxbsZOYQQl6xXIavHBKfU+eQTwhyjrqpViyLF5kFUJ/PZ6LxUpHXipwvng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=amuRKHtIxZCusSd7NYHmthsgJGB4hV/bj//XXqhJ184=;
	b=vIBusMwOzVK8dq1RWZ8uqkiBH8oreTWONNTPtZbOM+l3jEDvHmtTZZ447OG20dTD+MH7
	 FUx5nHjPbRlgjPDNtZZ5gUZOssSUj7s5K/HWtCdO5MJUMN+21OFL/LVPPLj7QqhzDv+as
	 KLb/88P/VxX8MOuTW+GWcX1N6rXc+5aH/UzY+n5Biypdy/8zIL2MSm6JW4+2A3XuvVyjg
	 lJNReyo3688aEZrz/0GWdNhh92mFvfmP7jshvzDy2h39bLPaeSdHL365d27ZEf0yBj0oe
	 S3b8hzVaHH6rZVgEuwwANivnP58dORJNnLlP0cYW31gUziefMePDOiC6B7CYPjOilrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15C606A321
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C15C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b4d5e645d1so44324157b3.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:52:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795693928; cv=none;
        d=google.com; s=arc-20260327;
        b=qW32WSiz6D4hEv+uY/LL/YRTxShr8XHnixt3FQ8RFeQ85JoBNs0GNHKD12QnxW6f4z
         A4QUNx9qkL2GTlg6hTkrhHxvRRYH390ccxmdXpIma611ifG+Dw2U9ygD3s8beX/MOUGi
         SV842SloUOqMgExvf1LbvznTbU+7QZTLrZ8P1LBi+/wTIISOyRucNQSNABbjAa2GYuL2
         WDAKZeghM+TyR+PAhvHn0fTXoThUvxfl5lc+ad9UFnayzF4OLQpo2C7mmTVSBM8UaXAk
         tdOAQHTC958/8WsEaTxqiIKxgfaaCAJ1YHg9heCy2On+N3s0W0ThNJ7+puovu+f3lAyj
         rNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=amuRKHtIxZCusSd7NYHmthsgJGB4hV/bj//XXqhJ184=;
        fh=/MXux7W8pNR5YOPcUsQTAsT0+RIDaSFnJSbQCm9s9UI=;
        b=bniFJB0k7gKacUtsCF9zORXl43I38rjVUaKsVXB4E1l1fKF/BTvuIX6GVIkzPDYuza
         I1UjjomFQQ9Nkv8SUz1M7VhICsYq4EcCE+iJqRiHa8JBjy55Si/6/EPVu+QY0X9cvAzh
         J2MHnV6XjUnFu3JuIhVaOSNBEXC68DoJm72WW1LQVyr5YS544NBcXTL3rfCwQhO8MuIG
         yR/53gDq5SEdMaZpZqLOUbDWDDC1BEFQugT4ce4u2w8FeDdBukx1pwaUXmDzUOcyIzu0
         ilMQtLLJnP7q64CcTb11WP1EyIOP4JRo6b3FMc1q5W8ixeHuCC9F7WTs7XnFARxeCe/G
         aKdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795693928; x=1796298728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=amuRKHtIxZCusSd7NYHmthsgJGB4hV/bj//XXqhJ184=;
        b=JT06c3QKKCr3y0yVzTg+ate4KNvDPQLtPIUqXC2lnaoO1aKE1gjCZtRZ9qI2BWd8Mm
         UishDTnalNfXIWDh1EGZLG49GSRHC8u0qeHLlJ7Vy0vED+jjnLxd5tkJBybcBu20cAUx
         6DZXprA6wHS+OYNrVjq1zI18LZH1Bt8ZJ4LJobtqfLybwWovB37LpcwGK/D833KDbW8F
         +VYBYEUbXjWAgP5hCkHBmku9c1uHOCOFZL6pNgeCtZYYsOfEhtCLPp8+LVLRfYO1BUl1
         2cQujWKHYb+8iHKafr2QX++U+cY5W/FI0QcQK+gTIAdkKTJwphsDfqYlM3HhloKhU0QU
         5l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693928; x=1796298728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=amuRKHtIxZCusSd7NYHmthsgJGB4hV/bj//XXqhJ184=;
        b=WJBgQZ7zRcVgxWBCNpgivWeSAKdxnP8mmrNV2mc4XNyYrzeYekrW2ekHTmZ+CoMAZj
         U/f9TjRo9YoL7GHGZ0PiXvUOwKOi8yjiRe8RpbGyr1xtB2ud8IInE4ChL0FGXQMoXKlq
         cMoy1dCiu8JERoLLlB/4fJqmNgaA9Wj8ANlI8jvPToolU+em+VWg5CzNBaD6laSCEClZ
         Zy2CMhsUSrG6Up9rZvkysmCl7AJNofbQpX1GuS+hmcRyMV/Zf1yLkNVSi1fbvUa/fpJS
         /25DX1XglnYUfE9maaXuz6bSh33K9kL3rII9ZWysXhqVWiDJWdlHqD2mq4feeD6K4E7X
         uveQ==
X-Forwarded-Encrypted: i=1; AL+hErEjNhy6R8hcl6MibutHHXiSnnGE92vmAyd5RwJyTbzebK4ZxuVFuKZvxHSAWIAToaE+VIgKevCnOQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9JibjCVnHz9GpRMP6lTM8tw16B5AM+jmBEDQOaC92V1dByPStg
	aru/p897nSI+dzdjgvTkuY0t6x+7b5sEvceBPPo0Bhm+ZG0hgDuM2byfE1o8kVXyC3yqGaAa22M
	za99B6VOa/Zna1wGoGFEKrJ8lAGnC3WrRRqDcrRotXA==
X-Gm-Gg: AZFdTZdWO9m+ab3Nrytn024jhbO+/FlsPk6DYRb9mUUIeGv3nJGd4PvGGrvLx+wJd6q
	teALBBRmWymIjViJTRlvUJhRZegfjnU8euiOSQ8VCPj5YUHVIOvoVx4Aa1NRJLXJUE8UNn+qOmF
	cNwQ43RRiiMd1FKzTkgIRc8FlfT0lxjTDk1AM/ebkmLDaFiyN0CUlMt33q7pNfG2aiqASABaZ5M
	ycgHw6y4lL0GK7puv6m5W4mXcMKt/g+4BDaXfLA+GlxyQaHoaMEi0yQifkhey4DA0hGNmVNlDJS
	n5kaAnh3NcoNsoGLXgN5Lnzj5LB/8tkFQZAiT2hOdmhw5IxVrklHYuv4hYVvwvT4bMpbtc334uB
	6pPCjRZ09/8kLBEnBcKQMs+2gK1XOyQ6tgNXHreNcoWl+xUdZXfacnM65QFao2kaEViIX2gcpsX
	P5eRAbV/n8GvzzI4H93xniEA0wKeyixvs1D4nROhI0bjdJUSLaIYXNbw==
X-Received: by 2002:a05:690e:11cf:b0:67d:c7c7:f906 with SMTP id
 956f58d0204a3-67df4551fa1mr7645191d50.158.1795693928129; Thu, 26 Nov 2026
 03:52:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125173959.2198116-1-christian.loehle@arm.com>
 <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com> <2162b02c-642a-446c-973e-ca80607da294@arm.com>
In-Reply-To: <2162b02c-642a-446c-973e-ca80607da294@arm.com>
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Thu, 26 Nov 2026 11:51:57 +0000
X-Gm-Features: Aa3M54pjtUNnZ71ASyHQ6UnEf_ksRPjhBZS8ywckgTsHxI2GyTeeeUEsLldr4BU
Message-ID: <CANgGJDrnH7R9aTXhH-nj710OjwNcUTfpxE7eWGSP=9a3eoUnug@mail.gmail.com>
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU throttling
To: tudor.ambarus@linaro.org
Cc: Christian Loehle <christian.loehle@arm.com>, bzolnier@gmail.com, krzk@kernel.org, 
	rafael@kernel.org, daniel.lezcano@kernel.org, lukasz.luba@arm.com, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2026 at 10:50, Christian Loehle <christian.loehle@arm.com> w=
rote:
>
> On 11/26/26 09:16, Alexey Klimov wrote:
> > Hi Christian, Tudor,
> >
> > On Wed, 25 Nov 2026 at 17:40, Christian Loehle <christian.loehle@arm.co=
m> wrote:
> >>
> >> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command wri=
tes
> >> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU cl=
ocks
> >> independently of its interrupt mask. Setting it to 0 C limits all thre=
e
> >> clusters to about 200 MHz while cpufreq reports the requested frequenc=
ies.
> >> This was found through trial and error while tracking EAS regressions.
> >
> > Cpufreq reports the requested frequencies =E2=80=94 are these cached va=
lues
> > being reported?
> > Or is this what the kernel gets via the ACPM call?
>
> Requested frequencies are reported. The 200MHz I only deduced from PMU co=
unters.

Tudor, your thoughts?
Is ACPM reporting an incorrect rate or are those cached values?

Thanks,
Alexey
