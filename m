Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608266;
	b=ojM2uzSPK9jjuSSg9YU3BEkwrAkpXi44oqSDFhsfuZFSwR30XycUdqm89CXQZfqGt2Iq
	 lUe4U2vZ9XZUjWhypGOWRdM6YqwcCYO6F6xNPsgSoIo+bTxo7cU4YG7GtUYsb8zVAM6tY
	 KDF1uI18b2cKoOrZX7rTkj88Fo1jJDwXc73IOTizSdbG6WERTKFP9BN1+/iGq4Sy4D1LK
	 Yf8GFqiKm8Y/naa7umnzvhljBzUREAaj7T7htdsuZmvYayu5YV6JO1AsaUjxZ/iPfNR0k
	 umDuQLCNXBYCfJYdSImCulCRZeFDtiKWCNUN+w3T0f6DP7v0MrfDzPWpNzFNh1r8Kiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=z+UkoMvvEaVTNil18OTBJI75hEZ+FMKT77tUTvdlmZY=;
	b=an55E0WEHO8RxRPDMqYd30SEAMYlYXJ/P5Nygbs/IpV9+Fqo2XzKZ+pZW4+Xkjkc2JI2
	 aB6Bcp4JR/HESC47iQJoubA4v8RTRS/M682RAoTYtlmZNBv3HvBsVY+UAv+mLeQ/1lRIh
	 y9mc6HYoPLBQ3kKQFB6gYmN9WyKWTr1hYY0YZcT5Zi0w+YR/B0/q79N5tIgrBdijO8Wsr
	 k8AYzLAy3Zaxca0kd9qBkgdBKcOkH1YYBV6BaAfc1m1xZtcQe36pctqURB0KUexsEEkQG
	 PJ3uOKIVdGodB7rrnfZ6n4uw8IcpwXEBgdW7RnM40kdst5G/jSAlQE+ONQuJDGCxcPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v/lRLI/6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C91606A338
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C91606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v/lRLI/6
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b335eeb340so49703917b3.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 04:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795608264; cv=none;
        d=google.com; s=arc-20260327;
        b=OOhuaxaWVDA6b/vIVUy4bIMYhMtCIr6lZ9Mfc+OdbjlIVtETxGSkufJmFZoQpHgJ/8
         rDYUAE5aAVQRilzCtlNzw7vLA5S/jOtyvupBnrt3r3KIpPsPAH2kytoU350HBP5Nlvl8
         gc1H2LjgLq5oBEoYQq7b9jHFH6QLZ2RjofqFHb6JNCdXKDv2916nBFh5KTftnw4dx3j5
         BdNDM+7wMybahM6XvgC4OJZI4eHXao9oOrliabIAkjmfHFweb2D9PMxft4AnMUZqdlti
         2gdkRl3oPfKqBCmNF/UNHLPuqsJjn+VMEvQJrYk4Mx277YcbPGxf5ROqWP2qOPvd1aY4
         Xp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=z+UkoMvvEaVTNil18OTBJI75hEZ+FMKT77tUTvdlmZY=;
        fh=TPPgEEftTLKIqL3IGY5CS1oYyVVkpcQkbLQe+KceSJQ=;
        b=gcFY1bBmlyiXM7ioA2eCQfmSAT3yWTOGO7QxFOuZ4HGcZgosBrmeKiXni1SHRY8J38
         1jBKDAUdvbioM9DFHpJXXjptvWsi4yIHyVN0yCjzAYgvMOEbieuS5sstLN3hs9WPGT2j
         jMv2CVall6gQsWZ76ytm5mLNBrav94cFaidHVDmqkQqnUlQIUfDWaEIqKPHn+6Tq33lS
         /hEslAhV/7W/67NHNlt8EyYMRvjkCTllOh+knR7hh5TbVrh2hMzMiyncqPH51/F+sY/D
         qLkfS720BX0bOMX/oaF45FfFoEN/HTebN3iylL4n0kniSlyslg7Erw+i6ndTBNI7XwRi
         AjVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608264; x=1796213064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z+UkoMvvEaVTNil18OTBJI75hEZ+FMKT77tUTvdlmZY=;
        b=v/lRLI/6A8OQzRxCu/iTwg1iJgBq/xMj1Kawkk6QIgnAh6avbVuDxItK2xWpSTX6Ym
         RW9+u8YoSgQtE0VKjwoo6jIevKDdLE67PlKdX+/eLOlh1FEzINMW1YQcJPSEjRwmNYoQ
         DzXfPRO2b/F6SIsY1G+z57UPAOx2nm407QQagbJ0CbiD+WEhdOEnR9FHRmBuXqSHie3R
         c92vMDkgOIBj0PArFc6b/i5dXsl05Ksfsx6an6qMFcIxg4ft7L8+3QB9jFlZgxo5rJh2
         AyTPIRtdglgfvcJNDtWk7wXreSuWSPtzKCPFgNiqL6s7CTwyZX3lTxnlIfd2N/gmNLxZ
         6Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608264; x=1796213064;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z+UkoMvvEaVTNil18OTBJI75hEZ+FMKT77tUTvdlmZY=;
        b=c1BiGFvbMNwfA+TxDq5S+TWNkwi3n8lADEKHOc5cMWsRsNH+GG8QKJZDuDYDSVZgqS
         dk0pXsXgFsR6IdGNBG8UjdZgU6+9GgQWza0ueubYZDnL7SSVcTjGVrpqm9LLI9V0sFbA
         HCXtg6vsiSi9hsOPyPDoPTcnsMh0u8x2iuXI3Rd1vgg093fkhk2DrK2j7AQGRlLeDgcc
         tFMJrJ9j51YMwEK/hQd1MclINp74Nz8EwF70fYFMNECzBNoi8GMMyvKqtW4ADJRwyjYZ
         R5c4i0rgSxiRRzu8EWjiSM2Yf9JY9LQzZts0EV5zP4qYGzmQl6jEjdTH2BSmD3fPBAww
         NB7Q==
X-Forwarded-Encrypted: i=1; AL+hErGxAtDOqlu8yWCvXLW2PaWGxPZEAe1uyOKknPVGQdbLDpSd+QDe1lh9v4Wt+ICSrEf5/00HzQcwQA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/yY/hRkFlIPLHWx0h1hcG5INOYYPmnu6ZRgULSc8Q/GNbKGy1M
	75Qlzia0z13G0gbKxGD5C287oe68YCDw2k7CAsdonq+rpa+yGcLMDBH6BaY3NyeRfISCsrJmZf8
	8lYGUYjF7xoIKUetr7Zk6NmuMA3PeBq4=
X-Gm-Gg: AZFdTZftZXtyj57wYtZz+y8DJTkaWKefYBAHrwaiV8bfpBM+2HTKu3vbSwsKq74mEhS
	aD19dxI47lTSOy0rLlQDIL18fSxYGXlifIMwbMFzy3iqX8Gk0DSR+l85JJPJ4zJ9LNxzJQ7bzEZ
	KLhVjkqAIcTAuxgOkFf7UxgU1tmJnZZHMWAzwNFWRLZrtjxtFiQ8iOopS+B86NlYFbkvFAstFCN
	Ee3UxsU+IlsTbrwMwjlcfQ8vN0x0T4lqtQkFgXK/dA8CVnF6NdZqZqIVuLE1s9Gk2s640M14nYT
	hNbOsKsPMLXcbny71OTbMxrp9qv+7O7j2PZCd2ASTR/xGHzW82lYBKEdAPcu4bZsn8+m/65ui3w
	oQB547FmpC5lw/1h+UkSPqGn6woEbaxrONMfPcHkynWxPV65fN/MoyqA6G2jMJL/IcDwRCMQ6pz
	nTPM7xCUJiNXhzmmOcl2u8NFVTSsgu0tUT3O71QWn/
X-Received: by 2002:a05:690c:b19:b0:8b3:47ec:b20a with SMTP id
 00721157ae682-8b520475e0cmr66201927b3.43.1795608264600; Wed, 25 Nov 2026
 04:04:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Marcel Moosbrugger <marcelmoosbrugger@gmail.com>
Date: Wed, 25 Nov 2026 13:04:13 +0100
X-Gm-Features: Aa3M54r2ba5mZUdoWmYri7uZbuEx-lFWMUQY_KR4UYOrncn3hD6_3rK1rzheKEQ
Message-ID: <CABtUotOE+6AJpp9ewj3rDWRM=MdHOtcvqAhVmaZ+QAbZK4fSRg@mail.gmail.com>
Subject: [BUG] intel_idle: Arrow Lake-H hard freezes, stopped by max_cstate=1
 but not =2
To: "Rafael J. Wysocki" <rafael@kernel.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Two Arrow Lake-H laptops (06-c5-02) from different vendors freeze hard;
only the power button recovers them. On both, intel_idle.max_cstate=1
stops it and =2 does not. Crashlogs, oopses, dmesg and config are in
https://bugzilla.kernel.org/show_bug.cgi?id=221923. I am mailing because
the evidence now points at C6.

                 ASUS GU605CW (285H)          ThinkPad E14 Gen 7 (255H)
  no cap         5 freezes in 34 h * (7.2.8)  9 freezes in about 51 h
  max_cstate=2   froze after 79 h (7.1.9)     froze after 63 s
  max_cstate=1   0 in 510 h awake             0 in 671 h uptime,
                 (281 h of it *)              s2idle included

  * on a Thunderbolt dock, where the ASUS freezes most. The ThinkPad
    numbers are its owner's (comments 9 and 11 in the bug).

intel_idle has no table for INTEL_ARROWLAKE_H, so both use _CST: C1_ACPI
(MWAIT 0x00), C2_ACPI (0x21, a C6 substate) and C3_ACPI. =2 removes only
C3_ACPI. So the freeze needs C6, or a package state reached through it,
but not the deepest state. The freezes that left a CPU-side trace died on
idle exit: corrupted per-CPU data on the ASUS (all 16 CPUs within 65 ms),
a misread instruction byte and a misread exception target on the ThinkPad.

Specification update 834774 rev 025 lists ARL036 ("Unpredictable System
Behavior May Occur When C6 or Deeper Sleep States Are Used") and ARL037
("A Core May Hang When Entering or Exiting C6 or Deeper Sleep States").
Both are Fixed for H, seen by Intel only in synthetic tests, and may have
a BIOS workaround. Both laptops froze on microcode 0x122, the latest.

1. Are we hitting one of these? Which component and version has the fix,
   so that owners can check their BIOS?

2. If firmware with the fix is not out yet, would a quirk be acceptable,
   like the Skylake-H one for C8/C9 (d70e28f57e14)? A narrower one than
   all of C6 would be better. I can test C6 off on E-cores or P-cores
   only, or any patch. On the dock a few days give an answer. The ThinkPad
   owner offered to test too.

Caveats: no reproducer, only rates, and no known good kernel. Neither
kernel is vanilla: the ASUS runs Omarchy's (Arch) 7.2.15 with nvidia-open,
the ThinkPad Ubuntu 7.0 with VirtualBox and no NVIDIA GPU. During the =1
run I also moved from 7.2.8 and from BIOS 311 to 314, and kept the i915
render GT out of RC6. Before any of that, the cap alone gave 116 h awake
without a freeze.

A correction: in September I wrote to platform-driver-x86 that the
intel_idle angle was refuted [1]. That rested on =2 only and was wrong.

Thanks,
Marcel Moosbrugger

[1] https://www.spinics.net/lists/platform-driver-x86/msg65594.html
