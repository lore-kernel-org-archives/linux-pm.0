Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486960;
	b=nE8NpCTnPnvaaQzuIsKfhDvSkyuLo3MIn1KGOM3RCKLaqq6C0cSDB1IyY2L0YlOBt2ad
	 w5pMl1rJ2G3IgMrFijzmpDrrWnGCaL5YynqERWUl99qGWnIUI7gnC0U7IPLXujcjtTm0V
	 DNispVJcy/ZQGgn6gbUDXdhdW7lmNVLMUFtscQnPl+rnU5bJsB4NrSHlMz8IDsEs5erCG
	 2Ukf8JZD8BOOAafXs1rM41jsomEpFkmTLWevjUmxnvvIlpfThdTwms7CpVP0xynbtjHha
	 mPi1OS+QiVc87/ehdOuAeIvbYqns6HnNz91WbCNdBDxWGnoYDGNPku6Cl5aT2tyfgFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Al/HgAlWfQ6iceuFxEpzqibnoieoIm43yof5XL41sFg=;
	b=R436oVthjYQKKMxWRf1E+bxNxJljWOG0rPPREVOK1CAavdPeR/RvlTWx2Sl//Q5m9Ev+
	 UQ3Tmu6PvAeCsC1dkEwni0axBRgiiro3TRtEnAF6ncY0I5CcN/uouvyNSFD3nSrMhSxv4
	 ufD32/pEEpq3SiW26MOsb6QqL+k15LuHy9GvRvNBo/PBlyIvmFsMBbUqvX81d4+MtyE68
	 Cob2j11VYBfpyNuMiNy1+AlNl0Y00vREERwBLe46295MWMPFG256+21f6CAP0v8aeQUuj
	 hgolmJVEtCuuEa3j3n3v5lG0s3ZEjE6+v/VZl/tkHbzIo2kHsreybQMiABeUNUelo+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WevY/F63";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B6606A31E
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 02:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92B6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WevY/F63
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso1656560a91.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 18:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795486959; x=1796091759; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Al/HgAlWfQ6iceuFxEpzqibnoieoIm43yof5XL41sFg=;
        b=WevY/F63WgcrmmjbcFRa0wU3f79Y++u2Ms6yFCScdMmM3rFtSjM15hePh42gU2Avph
         xJ5Mz1CVB0BGai1lMtqC6gRZV4JEt+dDqS11BQBys5KQUPH6Up+/mRAZnQ6au55fd/iT
         uEDLwUJmYPXXLxnO0OPF+UKd6OXxunLK6kmj/YiQf0u//WJgwjd78uMDME2hZjjJUL8Y
         gxKqgqlrpv7aoN2JgLa4V7KyM0FZviXfW3B+gzhkLTvcUHwSjRLKsPHcaQtpIlYBwO7G
         PkpxGDFWGDZ5ux9WV7vK7FfbLHN5gGbucVGahYfKpdVU9CEhSNKBNT9cr3CbCa/ir0N1
         WFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486959; x=1796091759;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Al/HgAlWfQ6iceuFxEpzqibnoieoIm43yof5XL41sFg=;
        b=UBQdRwPmxZrZTY/c68rogFBXCk65QOI3lErq7ihtKWisjIH702CGxK2oN+kngKHpUk
         MMJ9rrmV1EY0QnHYBHyS9amT6/rUFxfLQx6Eu0ptsHSszZ6Bqc3mjTiKPhqi8pEDxUHV
         s3AqE3d2erV5WFOEbpgFWCm2X7+VxWDFeCSxDrV8kw3YRRO0GlQu3OuNceXEi7ifjJI7
         QQ4Gp6QMpMG2FYm7492mGkZfGZa0HKtQnMLhJN4Bro66Au4Vdt+XwuHsKquNXzhvi835
         xL0ngYhb4xBtshgMu9wBIxcpbIJJsBpcv0BChQ8u6weLE3JStqREC7oKmlK9iJgoF+ZE
         PGIA==
X-Forwarded-Encrypted: i=1; AL+hErGuPM3WMIL5UbseGTA4bvP0Kd5KFweeRJouuKzBIAdvVhg0WVMp8c3MulT+K8TXlDtJVSWN0asiFQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9HLLRW0efUIW1Ol0U3CBtKKPEbuGwErR1sJfaUJmdr56DO+28Z
	30SVuxzVCMKBrPdywtc5aeYgxb22azf9njIzWa0Czq5IwD7hpyy+VsGA
X-Gm-Gg: AZFdTZdBijeYJKtOCBf6no1eBTAYwDC2Sc4EYI2E4/Zmto/0+M8rT8nj8K0QFWgvCNl
	p3blYzQs5Qbg2faVKsVjP/2HvlIrLdYXPX6sgw9PK33xD+eYsvYVu6MyghUtWNm814mvWAfK+Tm
	/RJsdbMve1ahuRoCE18+tEB0QxlPz7m6fhqV8k2eFByc5DE5JUIvc7Hci5FcV7JvaHrLTig+ExG
	GzSp5vUZDJBo7hkh2P5Afc23kl5hi3rJf4sY6nfmQl1Ke0hebZqKX1iZ7ENK1SZEeXWSrO5td16
	Q2ir+eiwwlP1LfDTsGOhk40TsBezW4pKlydrkI4nTuv+5wS1trnvIL2oSeHjJb6LaVGK7Zn9Y68
	0RuFEvF/dtfM/BOqPaG25BtzyD8l0bjlosm5MbfM0w0sJySsrT2+YXK2G6K+nOvoOBRjytfMl+k
	XiBgdZyoyzUVKvEqe0mjNWx+XZNpPrgA4BTGIVoIwU6WSnhuaajjN1lPFQvBL9slxMp5FRmQnz1
	Ut1omsHWAbnx7gtI5F+Q4RbzPMjo9qEfzL+I9OVSE7Q1RSCJCsv0Qm6JwnhHN+R4CW08FKmEwXS
	JufcJj27qQnvxcFJYscPoq9GTPHBkpGKOavvUXE8tncHlPpx64kqtaukDB0RxSXkMLDgFdMQexr
	Cqd+PFMVtPRx6hv+f2u5n1wvP
X-Received: by 2002:a17:90b:1c08:b0:3b3:b632:7f2b with SMTP id 98e67ed59e1d1-3b41c98a3fdmr10861646a91.51.1795486959115;
        Mon, 23 Nov 2026 18:22:39 -0800 (PST)
Received: from [127.0.1.1] ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fe711sm8425496a91.1.2026.11.23.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:22:37 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Rafael J. Wysocki <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: rcar_gen3: release the IRQ handlers before
 the zones are freed
Date: Tue, 24 Nov 2026 10:22:31 +0800
Message-ID: <179548695107.1834709.12105107414276177799@gmail.com>
In-Reply-To: <20261123064745.GD3898744@ragnatech.se>
References: <20261117145348.1092528-1-shunsheng1218@gmail.com>
 <20261119022926.1493582-1-shunsheng1218@gmail.com>
 <20261122144813.GB3898744@ragnatech.se>
 <20261123064745.GD3898744@ragnatech.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Niklas,

Yes, I agree.  I have reworked the probe to look up the IRQs first,
initialize the sensors with IRQEN cleared, and request the handlers after
all the thermal zones have been registered.  A devres action disables the
interrupt sources before the handlers are freed, so ->remove() is no
longer needed.

Since the thermal core copies the zone operations during registration,
set_trips() still has to be selected beforehand.

The current version retains the no-IRQ fallback for -ENXIO and propagates
-EPROBE_DEFER and other lookup errors.  However, if IRQ lookup succeeds
but requesting a handler fails, probe now fails instead of falling back
to polling.

Would you be happy with that change, or would you prefer to retain the
original fallback on IRQ request failure as well?

The reworked patch builds on arm64, but I have not tested it on hardware.

Thanks,
Yaohan
