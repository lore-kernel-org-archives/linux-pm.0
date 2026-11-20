Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194571;
	b=i4TfoHtZjN1wQFzoR05J3uWeRROU0GVgQX0sES60ZFcgAzhDLL8vhG2y/ZbGmocrCpHG
	 o0jLTEs/BB0fNREYHQfkiRUeOK7dD5UgTmCDdqiL7rZmToOTCNs5xn4kW+jjtOOwaKfOp
	 TeQpiAWPRF7eD6FFox1/7/+XhwlNujwqMPq4jLpRjUIetROkhPtmKzpfHcKzaUcuyc4tM
	 OMKBpSIoOI0zhaS1Fv5VGB9BK29zKrGzA8SA/DT0VBpz6x8nElNesYXIGXLz9QT0F6lWs
	 lCCwCpd7gGKy5HoowN2ScWs/F7GYUIzT92rwHJYwJkMakLd+V+rZ5rqECII9+ORzo4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194571;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5juQiS4NV5WDA9Mql8KGEciA+P/kt6ePCjBKpgAiReU=;
	b=RC6WaYLu2zHnn0Fy1arny4iboVyTit+4DDT9VdpzlTXD+lkyM95C7p80JByw5SfwJH0j
	 tcyf+McstGusmg2Q4LjleSc2Z8mYd0GSY19yvMe+cBtL+p0qFzIsMiib40482b5XCedOO
	 2aLWR2wkKd4+dEkbnNcbXVZ/rd/unCnIcQANM6awMG1apwJZgx7h//hGXVN+oYkIqztt1
	 r78af3AajSeiSg9aaeF93SMyqdsiZr7RfOICAKsgqUJH4Cs0GVG7WfIf8bAtQTSh8xZdB
	 Cq78qXgaqgrB8jC5zrCHQRrLfrc4urQzUEsGwOA6vMZMSJQsKrf0hzHa20Clu48TbQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aghKennR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F1606A32C
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aghKennR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2F91F000D2
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795194570;
	bh=5juQiS4NV5WDA9Mql8KGEciA+P/kt6ePCjBKpgAiReU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aghKennRr03xKxOZoOVVsaoxmHiuOy0Arzqjh3H4+XaTwDwLCqX5lvfDqb64plhp7
	 fXC3HOhWZSNVnSjey0BZGwbkggKW9VUBdNvFQoZce47WYlvYwXrDsZ/hbuj/7+Ru6F
	 eW/LVZAJcVEPLuQhWIBRruZPXBY7NxhZ39BQCeH/A8g4oLNsZ4TrtirSVTTmc9ZCCC
	 OIRmAZOrUmF8gGos7dRV8FXHw8GStK8LMakqItoXqqETUZMbvf6VxTxitY1kkUfSA8
	 iuUSFdy5KsLFRBEwdl08sOm7zchndL/PVYSnBbMhD0TjDHui/JuP90Xwsjcsb9YOUv
	 Za234rg6qzPNg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ae85add4ceso5853971fa.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:09:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEHVTvMYFwCWGzSNhsWzZARKg0nByzmMDGpg3BHZyc7/3gz/LZGe0Z4H7UM746qdU0QT966fjOxRw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9CJfSQnrywEeLwQvbFkrY1zw84ZGVViW6dmdZe9BxSjwmkjC7e
	24r1GBAG+aTEAUCG2Noo4Yb+TwaDQMtwe1K3zv4umn7x6BGAlSHKesU94pvoVbkY7GC4gxCmnDO
	Bq2err/cwcaWjIOH1LoTiMryJgU1SMoU=
X-Received: by 2002:a05:6512:3093:b0:5c1:595f:b370 with SMTP id
 2adb3069b0e04-5c1bc6d253fmr1174527e87.3.1795194569103; Fri, 20 Nov 2026
 09:09:29 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-intel-pstate-online-max-freq-v1-1-1bbdae2b4986@hsal.es> <20261115085234.40661-1-xzhangjr@gmail.com>
In-Reply-To: <20261115085234.40661-1-xzhangjr@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 18:09:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_XsA_vv5XyjvtbkNXBJNhwDkYoJSfE78KsA50BaUq+Q@mail.gmail.com>
X-Gm-Features: Aa3M54r8cdEJAdD0Zd7M4FbDyba-DKAmCj_dmkYEh4fRehGNENiucSzO3VGQDYs
Message-ID: <CAJZ5v0j_XsA_vv5XyjvtbkNXBJNhwDkYoJSfE78KsA50BaUq+Q@mail.gmail.com>
Subject: Re: [PATCH RFT] cpufreq: intel_pstate: Refresh cpuinfo.max_freq when
 a CPU goes online
To: Ximing Zhang <xzhangjr@gmail.com>, Hugo Sales <hugo@hsal.es>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 9:53=E2=80=AFAM Ximing Zhang <xzhangjr@gmail.com> w=
rote:
>
> On Sat, Nov 14, 2026, Hugo Sales wrote:
> > I have no HWP machine, so the HWP capability path is untested
>
> The patch fixed the stale cpuinfo_max_freq on my Core i7-10510U with
> intel_pstate in active mode and HWP enabled.
>
> The test changed no_turbo while CPU 7 was offline, then brought CPU 7
> back online. These are policy7/cpuinfo_max_freq readings in kHz:
>
>   Turbo change   Unpatched   Patched
>   off to on        1800000   4900000
>   on to off        4900000   1800000
>
> Both patched readings matched CPU 7's reference with all CPUs online.
> CPU 0 stayed online and reported the expected maximum in both cases.
>
> Tested-by: Ximing Zhang <xzhangjr@gmail.com>

Applied as 7.4-rc material, but I renamed
intel_pstate_update_cpuinfo_max_freq_locked() to
__intel_pstate_update_cpuinfo_max_freq().

Thanks!
