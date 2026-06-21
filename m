Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBC224FA
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782084852; cv=none; b=KIETHd2exidgtXu/1Vo9h3bAG3Tlye8p/FqOrtCakq/u9kNRjWtPzfLU5uyWZVyZCM8yDNM+3yrmD5cPvQov1rYpDlv+QR8hGbhtB+wRmctjRr5expaJKWIy/ynAqgar8FOxwVwPnMK3XAUtJSNv4E3qEAvo7tHd/UKsangZ8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782084852; c=relaxed/simple;
	bh=zDJnGBrqxevnoYcALrF8kUlCGKMQsyHViF0rPZhXCps=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qt9ND082qNJQWnY1uPQFK3TKCqPrL6kFSbJHJ2BQZpoiY7rS0haKL65+cCOR8LALEA+g/NYk4fN/FwhXy34wb02qpR6JiSsLCCrKfW7qvcjJWI/5W1we8ew5K+AostRxnUeqYl4X9Ym1V4uXRe1xpkRyLNQ1wsXTrNfOdbzly+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=UoOlFJ4y; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="UoOlFJ4y"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so2197558a91.0
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1782084850; x=1782689650; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHVp7NOOBZqfJclQSzSRGxXaQ1Id5GELheljSSb2QMw=;
        b=UoOlFJ4yQqVnF2C3TvuxZdM7pcFL7/R0Ga2TcZ6gNYpkPACXbAwM108okMiwNDnE9W
         XvadePE0TDnUGUDCQIE/0lUa+WjsiC1lEkzkE45iI2JIog8607X3f6bmtyZTLgI7dG4w
         Ptm/zGzH1WYZ0zj9BDhiGnuLPw1SmigxL4uTvNXMQbmnS4Co85QNYP9cgf5IiaJLDxb4
         Z7hF0rXfChSYohAWenwIOfV5WBZHNMrg9RDgayoH/Ubt6CfEKZpEhIilCWJB+qrZkV0E
         AJTENAQzlbv77hRdLdJP/oTSSltRLdhQmkllGTbcpC8FOpWYKb4ymGbwiguGLHf4w2nn
         02rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782084850; x=1782689650;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHVp7NOOBZqfJclQSzSRGxXaQ1Id5GELheljSSb2QMw=;
        b=lYHdnIk05tZL4iY2A7pqYXLAe4gMv31B3lH6/I2ObePDURbFPXPH6s5zhBx8BWlbWc
         Yk/MPgnJrcXe1y6OHp3Z/VD3I6so6kE3/X3lb0Gk+KEdECt1NNgTJmHT5D1ERQSY8sZb
         AIoltFPTu0x9/rYEEFBOBcDm339OiUOPesxRh0owZ0H/gHLgxPeh2hpC5AGEVGbbddJ3
         lqluliCiH/mNWvy+Lj3L/8HJykEWOZhswE1FfeIIjDxdry/561DQ4BwE++q75hVjUGo7
         p6fKp0svqFyPC6vdG2K5LsEBGAops7Q4usNHsIG+RCcfAmZWRTm1cPnmNa0kmRAJywj3
         0B3g==
X-Forwarded-Encrypted: i=1; AFNElJ+1z9A+kplSPPBZzJJyGckUdCfuJUnyy7/5HcxpjCq7LLMzPJeOJBO6C7B+gUvehbLOfIUpKEhQXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7F7YoPZayTU5viQLkFjMKVhLSiZKMXk3qJNNhmbhVFdlZ2RC
	X73XIp5nT9Xb1Fr679pnpqIlFuPuBHDWp759SsW2fttTZLUjF13R9KKnzhGfp9DxBgc=
X-Gm-Gg: AfdE7clmpmfGfLixWH/RDImPYNCSl32KjbRwMz4BkRaujACCaHbM+DI8wYhpdrOMYEc
	xq2gSyMGFU1FW7InIyH7RlsR9RdtLYh8NItJ+ax0nMwEGDiYgqlHQFmQy5OgIbAz88HUjSCjOdt
	ggHDDOgLfN08FCqbAvqT2R1eWp8//sX5fs55AfrwiB1rXbl5t2c6UY8ob+w/uvhTtcHVCRL9qYw
	axZAFPSCCYGERp+FcGbXXp9UulVwGwyuySW5I5biUB7IUavtYn6TlbJckCDkY1fv50jXw3uumhs
	xsIvVhHLH2YDTkyBrVAynghPrxuKO6KwCqMywuzpuyuWovId43abipo227lKbQa87oAVyynNLdg
	CEXBGV8kDEYU/9/TzmieRLB6B1237rJm1/xcYWdBv+iBI9BgdUZjt2B0mK76qTb3vlqrwSolEYC
	sQk9OqWJtyB4LfJBIuPqvDSITHA+Yd2JA=
X-Received: by 2002:a05:6a21:600c:b0:3a0:c325:aa11 with SMTP id adf61e73a8af0-3bb6c2639ebmr13242170637.34.1782084850514;
        Sun, 21 Jun 2026 16:34:10 -0700 (PDT)
Received: from DougS18 ([66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc2c8d8a9sm5329417a12.5.2026.06.21.16.34.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2026 16:34:08 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Linux PM'" <linux-pm@vger.kernel.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
References: <6005456.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6005456.DvuYhMxLoT@rafael.j.wysocki>
Subject: RE: [PATCH v2 0/6] cpufreq: intel_pstate: Set cpuinfo_min_freq to a lower value with HWP enabled plus cleanups
Date: Sun, 21 Jun 2026 16:34:10 -0700
Message-ID: <001a01dd01d6$762c8080$62858180$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIyp08cKTylY+VlaYK0/jOjoMWz/LWeXgkQ

On 2026.06.19 10:32 Rafael wrote:

> This is in v2 because technically it is an update of
>
> https://lore.kernel.org/linux-pm/2381464.iZASKD2KPV@rafael.j.wysocki/
>
> but it contains new patches.
>
> This series updates the intel_pstate driver to set cpuinfo_min_freq to =
a lower
> value when HWP is enabled to support systems in which CPUs can =
actually run
> at performance levels below the current minimum level.
>
> It also carries out some code cleanups, mostly related to HWP, either =
in
> preparation for the functional changes or top of them.
>
> Thanks!

Hi Rafael,

Is there a way to test this? I have tried everything I can think of and =
have
been unable to get the processor frequency below the old minimum of 800 =
MHz.
No matter what I do, I always see greater or equal to 8 for each CPU in =
the
IA32_PERF_STATUS register, or by looking at non stale entries in:

grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

Example:
doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:100000
/sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:100000
/sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:100000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:800013
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:800014
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:799996
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:800023
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:800053
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:100000
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:100000
/sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:100000
/sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:100000

Readers note:
Stale entries are just "scaling_min_freq".
Non-stale entries tend to be not nice round numbers.

For me this patch set introduces confusion between min and max
frequency settings and what I actually get. I can set " =
scaling_min_freq"
to 100 MHz and "scaling_max_freq" to 100MHz, but never get them.
Before this patch set, I always got what I asked for.

Other details:
Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
MSR_PLATFORM_INFO (0x0ce) 808083af1012900
Other stuff from my msr0decoder program:
doug@s19:~$ sudo c/msr-decoder
How many CPUs?: 12
8.) 0x198: IA32_PERF_STATUS     : CPU 11-0 :   8 :   8 :   8 :   8 :   8 =
:   8 :   8 :   8 :   8 :   8 :   8 :   8 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 88470000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled =
OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88450000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 200000 RATLL
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO =
disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B2930 : high 48 : =
guaranteed 41 : efficient 11 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 11-0 :
    raw: 80010101 : 80010101 : 80010101 : 80010101 : 80010101 : 80010101 =
: 80010101 : 80010101 : 80010101 : 80010101 : 80010101 : 80010101 :
    min:        1 :        1 :        1 :        1 :        1 :        1 =
:        1 :        1 :        1 :        1 :        1 :        1 :
    max:        1 :        1 :        1 :        1 :        1 :        1 =
:        1 :        1 :        1 :        1 :        1 :        1 :
    des:        1 :        1 :        1 :        1 :        1 :        1 =
:        1 :        1 :        1 :        1 :        1 :        1 :
    epp:      128 :      128 :      128 :      128 :      128 :      128 =
:      128 :      128 :      128 :      128 :      128 :      128 :
    act:        0 :        0 :        0 :        0 :        0 :        0 =
:        0 :        0 :        0 :        0 :        0 :        0 :
7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient 0 : =
lowest 0

The driver was intel_cpufreq, governor conservative (but I tried them =
all). I also tried epp =3D 255 so as to slow down the processor response =
time.

... Doug

