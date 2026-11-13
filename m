Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583380;
	b=fUUNOytlGKJuvBNr4IQEVI/fOSIJxWKdU19rzmGIspa+bdMqCEfYnbBI215GNs51dBIT
	 GKpQ6Zta2di6wji6Y6mkO5eNaKrD2cg0g4ELWbyqCI/yciTqnFLpAQTZdZzrV6yqx7YYI
	 XgP9m5VNfEnwLLaKe10fe+Z2R4m5U4/pyqfSgmLWuaXOJgtCg5Odj/2lD7M/lJHx485+j
	 +w6U3tfPohYNKunfAMRoFSz8w7vf/aAitrheeO/Tt0sgOe6tGMBfv7iEREZM5/nVwp0LU
	 L/T7kf5nTJ0fc0eLpCSto7g5uFPhhbWafqA4G8pg+xHymI6/H9B8wceYfp1XMQoanmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bIqcVrxwFlf/MOw6E2I1r/DVGSQU9l7E6EGdUXXdXtE=;
	b=pr/5oQBvwvFQlaYinR3cvYgj4nft9hNg/Mh4PgXjizygHBnCgjNrHKeMOwA146ASaU02
	 7ezX52/GY6IocF+cG9Ba5mjmPB29cGa4QCmjarIZdHBZgIZmPuCyP7fsG0SvaaUYUP6HB
	 MpSo3X/XNjIZ2aBFavLwzfOU80THzAf4o+L/1lz3Hq51ssN8mVe/dtnfoegluMzbCCTnk
	 hSepXd1XqV5W3C6F3Ba7eYYYmU/NrYoRWlqSKLXOUYTnsTg/OkbIOUrfvluaDA/v1AcDS
	 eCLan9ROwTd/6Akl8Rzn5eJ/t/E3Lp48SgnBbHKLK2fNCNvX6AMMHDZ9IWJavji9oVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="Z4j/Mghi";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7932606A331
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7932606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Z4j/Mghi
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so16537415e9.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794583378; x=1795188178; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bIqcVrxwFlf/MOw6E2I1r/DVGSQU9l7E6EGdUXXdXtE=;
        b=Z4j/MghiCfLl4geHxV/1zp0iqZFNnntdJLs/GhAqDGduqb9DsAilkkq7STQnBeZ0um
         RhRvKy/5eCZ7/YOf4I6ESuLz+SNm9tkajr2e8phIKwLpPUNrxEs8ow/NIQakyHXKpUNB
         wPRM4oSCycrLGiF2jbCbowm/BJ1BtJIjJDTObxah1B0fXda8R77uAxdV6HE+5EK+QdF0
         ZQ/ACHOwMrY+sj8numw/aMHMwEY/vMqvifjApBhJUHkH1EPJavyUdNHLq4MyAxwPC7SK
         kmDg9bJ14RbAv6hk4/IhmI1flTTg7vsqzz+2ixhoxgveX2xQhoYUeoYm2BbSsiArcb0j
         7a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583378; x=1795188178;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIqcVrxwFlf/MOw6E2I1r/DVGSQU9l7E6EGdUXXdXtE=;
        b=NKlZ1a0kP5h2wLA9aitqPZsF5ksUClzF165S8QhzMkGn7UNxyOkc3X1F5igNxV6G9H
         Ph9XCtUZC/mJ0DJEf/yhtST7HLEuJn3tl47ZFFxW8kG3l16uOgYw/FyD/WdEqs5mDJwM
         257zR9vYVtjkkfLDbquRROFFuMNWrbGmAsgxMfsJrlkDl06OFgf3ilW+CoVu+DYIwzWA
         oO7CC0KYYtWE1Jb7Ktm0wycfCymwnH/4gcB9yvZRiPl/nt07kuQm/RiLq/fiDaZ0ijTv
         XAh0eWzanwYgzUGjvUF6iUdx2KHdaIx+gjqr6H2Q6ojjT6MmCGwXnNVSAZ2puKpEoZRZ
         fTDQ==
X-Forwarded-Encrypted: i=1; AL+hErHCz5OZIUPSIRsEbe6ozYret+Wst4l4m+DZNZd5M4/1MaE6S1lT8QWgDf6t+px80bsJfoCK2xROsA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DhOEasAc4rlMjbVnzeviRXbDswACqt0+GDOs/DnrCx9EDlxha
	c9Ej5gPRO/3C/cO3gyg8vyIKW8rWpts7oyEN20kE2rl0ruQjuzYTixnJAbS5pUNi4Io=
X-Gm-Gg: AYBFou0lD78bcGCBaCUTdoOyJjtY9Fitfa98gIFFKtDjikQOUT3tPhEicHLAi/2xAq0
	xPbBsO1ziRqtw6lbT7VIKVlgxjjcyoV2P24DsEvXSXniPKlRImxoTpbZqi9kmoKr6TC39KpKb2F
	gWAZhynK6rm8+vemJb6QIiSxLQieIJ/t9ss5Db8TDRRfdXLKFGpSMHiZHh0BDKablgCwQvC916f
	zuL2dCMANDHbRKIp0ZbDr5AI+4hl31L2b/AbV2aE3CisyFu7Yml1C2YQF8z521njbLZFPsKCyAK
	W6ArEV7eC7JCTL+uV/tIxx5Bwb9TamsN35yuM95Bg47KW6jn6KoRM5dHvtan7J/iqI2kbUxWXTi
	4rQfF7ryXLAEbFZES6UUiOotH3/HXBW9jq6gEV/XmX4XL7UlKQmUFAgdoUk87j2bDcDNX7J5zU6
	SOV2VvvCB/E5OW5kfES1ULLwbKxUEaV4TGRnyZyN8cFvpXW2QnTWPUCY4opJ5daiKc7jPqdzdKx
	6WMhHFqcMCInpi8tnPay7tKR2sXPG3eF7tRJTKHjjvlE6HCSwKODPJ2r9EWbzAWv6xMfTSoQwmM
	RMEqdLhGPD+wrWieZZjoy/E5UxEOB4WOrCKcqNN6qwBuhK63
X-Received: by 2002:a05:600c:470a:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4bb55a44996mr54909955e9.11.1794583378164;
        Fri, 13 Nov 2026 07:22:58 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e252f7fsm169848395e9.2.2026.11.13.07.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:22:57 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC 02/16] clk: Acquire resources for clock transitions
From: Jerome Brunet <jbrunet@baylibre.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <825fbfbe-a9a0-43e2-bb54-f9e38ce779f4@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-2-3041b788e9f7@oss.qualcomm.com>
 <179275170360.4070168.11650113664838519061.b4-review@b4>
 <f0ca2bd4-851e-473d-bf21-678cf964f854@oss.qualcomm.com>
 <825fbfbe-a9a0-43e2-bb54-f9e38ce779f4@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:22:56 +0100
Message-Id: <179458337623.3308909.8679910347462508471.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=n9gjeLxQD41dq62t9Q1UDoH8EzTxjE0oy5fasIAenSY=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFnftQNYFjZnu9ws4l/TOn1RRddMPbttkjGdaTOj796rf
 TLVYhFvRykLgxgXg6yYIksNd7X4O0mtL7Om69yGmcPKBDKEgYtTACZiVMDI0GWS98twnrmegNbD
 XZYWZY3fVXqXcW6esoxPSy1QcfHdMEaGC//MfS5kr/0fcIBJuSN16412sdN5/5b/Mpj7ZUnLzj5
 3PgA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On 2026-11-09 15:06 +0100, Konrad Dybcio wrote:
> On 10/26/26 2:11 PM, Konrad Dybcio wrote:
> > On 10/23/26 12:35 PM, Jerome Brunet wrote:
> >>> Preparing a clock protects its current requirements, not the resources
> >>> needed while changing its rate or parent. A transition can temporarily
> >>> use both parents or access an unprepared clock, and a parent rate change
> >>> can cause other clocks to be programmed too. Raising resources one clock
> >>> at a time leaves those operations exposed to insufficient power.
> >>>
> >>> Failures make this worse: hardware may already have changed when the
> >>> operation returns an error. A matching cached rate is then not proof
> >>> that resource reconciliation finished. Retaining a temporary enable
> >>> reference without a corresponding prepare reference also breaks a
> >>> consumer's normal disable/unprepare sequence after a failed reparent.
> >>>
> >>> Make CCF acquire the affected tree's and parent paths' resources before
> >>> notifiers or programming, and reconcile them only when the walk stops.
> >>> Keep fault recovery independent of rate shortcuts and subsequent
> >>> consumer reference-count changes. Require explicit recovery of an
> >>> ancestor's uncertain parent selection rather than reporting success
> >>> from a descendant request.
> >>
> >> I don't think all this is necessary to address the problem described
> >> here and in the cover letter.
> >>
> >> IMO a new provider API is the wrong layer. The framework already has
> >> the hook a provider needs: the rate change notifiers. What the core
> >> should do instead is fix those notifiers, which do have a few issues.
> >> You are fixing one in patch 1. Another fix, about setting the parent,
> >> was sent recently:
> >>
> >> https://patchwork.kernel.org/project/linux-clk/patch/20261021-submit-clk-parent-abort-v1-v1-1-2936181822fc@gmail.com/
> >>
> >> You want to act on some changes before anything is programmed. PRE
> >> notifiers are the right tool for this. The user of this change in
> >> patch 7 could use them AFAICT: PRE sets a temporary vote, POST settles
> >> it, ABORT drops it.
> >>
> >> Also, what is acquired here follows the requested clock. When an
> >> ancestor switches parent, the chain of its new parent is not acquired,
> >> although it feeds the whole subtree after the switch.
> >>
> >> With notifiers, the parent fault state is not needed either. As it is,
> >> it blocks every request on or below the clock until the same switch is
> >> retried.
> >>
> >> Could you tell me what you need from this approach that cannot be done
> >> with (fixed) notifiers?
> > 
> > I'm a little worried about the ordering there, since some device
> > drivers may also be registering listeners in parallel, so we don't
> > get a clean split of what PRE means ("has power for sure " or "may
> > not have power")
> 
> Do you have any thoughts on this? I'd like to proceed with this
> series in one way or another.

As I have replied before, if there are things to fix in notifiers, we surely
can discuss it but, at the moment, I don't think the complexity of what you
are proposing here is justified.

Please allow some time for Brian to have a look.

-- 
Jerome

