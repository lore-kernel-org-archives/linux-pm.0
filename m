Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792751714;
	b=nMTZv0D8Sca39kjqxZ96V8Ue5ECcs6Nj41eyNvoonU2XVBqHQcZ0BRaXc2jwv8E/6cAd
	 mR3cX7bQIub2wxepPumZgFy2hPuUKQCZmWTUJtiO7JlStKVykTmgkEqNI+BQr5mOP7b+D
	 bYdkwwi1Z6dbXowy0hQDVRFPg6enz4lFltOGPS8FaX6zbPl4I7Ve/QUZzPfoM8IQKlGgo
	 XFZj9uUJK5bY8670Frxr08Q2+HBfqpOqiRA6UlskWJRYOSU7DI+4Ams13C1FdrCbFGGdm
	 M7wyEsRXs7a3c1rFoaPhYlpkW5FYWcuEj8UHxy5wQmpdaApb/v4eHZwP4MsCZQxBWQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792751714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=OAwUO3xw9jddafsCMcqvt+DK/SLIQKUYqgCB0JnxYDw=;
	b=HUH+h+ixeRNa/BGQMqx260A7dW+gPFkQKGhIGkouIZcMDgd+wE3S7sbnpQ+5hTSEQZeK
	 jTLW+eyJybGC+gDIODLvx3BUOBuEzTB4/ksOq2Jnj0dtuKqzwk4NlO1ujmbU9WhNLBP56
	 JQx0RT2YXUkuHw+x0Oh/YCH1ybKrtYkZAW08+RyVDPhtX47RqU4orqiYPGTnga8KcpYm1
	 ar8tjcadN2Ih2OvbIqjkw8VqrMbnqagoteMt0OSNOzqfYw0TZ5v9Go3u5Osv7lWTwbhsp
	 i+XyTin5+LOdmX3TImF/tTjmfgqUpMxwx4SmhhYA2yYx4QhYh6GDKl2rNIPAwfU4fPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YvPzcphU;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBF60A2610
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 10:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83FBF60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YvPzcphU
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c45111bebso379423f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792751712; x=1793356512; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OAwUO3xw9jddafsCMcqvt+DK/SLIQKUYqgCB0JnxYDw=;
        b=YvPzcphUeUm9ntiRTjXKfvXX0Bscbb5UYsaP12qKD0C8ZUDh/CjG5GhOd30VyS901B
         I7injMmS92W+KzSmo5Vnk04EdkGjUDDKA5Sx1u+znNMjnHEAmhw0cA9hDBYeNCPIBk/3
         lalZ5NSjW2bDjo8ape9ruRipgTlQQFHtMidGrqzr++5bd8PeNjVTLlUyrNwpy0sO1wPb
         PHPBODmv+H43y/gEzChKYND4BmwfNpF11Y210c3H9oTaqc+W1+1wbP2A1W6iggjqkLf4
         mQ+5PXQ/1OTr8o/M5/RM/JwJbaLtIPPEBRbilXubhnYK09dJX8xEpS1zm3r72ZNl7Yuw
         G4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792751712; x=1793356512;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAwUO3xw9jddafsCMcqvt+DK/SLIQKUYqgCB0JnxYDw=;
        b=2MGuC9fl8jtqNKtSoZ/EgWmkqZH4wOhFeK2An/sOYWdiQ6HnSQ+cvo0nIAw9+WIBjk
         pT7q0IsbXJRMvCeCBBlfABD7vYOXZZqp/O8gW0iPukgg5hzFcoRa6Y02abkpwQOm1U9L
         IgfwOBwA2z4fnQY/ZPd8797a9UAUg/YyXwLY/i1MMzi4YNmxMbhgfQg6hqv0X0iVUdgu
         u5tA6JHMcK7O2Irl1OtCwigTq3cZK1aIV6/OT3K/vqfjvS+ib+dwppkuoSE3YeuG2VYM
         vNUd7DcuSomQCdZwPYpevq88GACDzhQTTQOjs0qHrUgdglNaM6a9siYugBi5225+4F43
         7JIA==
X-Forwarded-Encrypted: i=1; AKwUvBw/3VzWP/fOqNfr00ZVVjVohwE/1JhnU+X70JGpKziKqrO0TV5pZViv0a4McgSfsIrSg6nQu+mdcw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJub5kLujCYuf7ZeiiOSaNPmvIbTAwLg8jWmao+Kko1ce0UD40f
	3iNIW6ktLiBip/cztSZHkQTIyNQir1s3n4ctp2xGK2KzTmrqA8OXs0jkQWH0dY3EQ2I=
X-Gm-Gg: AYBFou1zitG/c8djfe/wNwe05wi0jgpLDm/z8Gp7MOTBBQ+zn8yd4OODmq7p5JVwtGC
	LsaFDktBcqPbhMEEz2Nf5f4g2NmgvlsIOLyNCd0fL5kUB5nst4jzfetjhwW48nIZiHeUWD7YpaI
	XWSwBz2Xx4IN1HcmCrPb0wGjmEOzortshH8h7KPrlFY69UI28JtU0qt9+FghOwZb4MVfV9NZqFR
	x4OGd7y6CXFa2s0RsuxnLG14wy03snGqhhsHwXgvkm+tdDfZcmXqmXW7wOU+nMR7VGclHHJZ7ct
	Rj5vStahyCII/VjMBEjz7jhnQB7jWSC4+wApC1KN7E1yX+LfDdG1rIDU+2s0HwsqjniadQWkC4o
	fiTh65SznkeqoTVr5ZpWSt66qP4bKomIrpBs9lSrypoGSxJklzjrKAUpuF43KzDdxJoOdh2TzLT
	CURkuS/f5Oymhs37VauPzN8Qbh4qiAihxAtGD38CjyQk8a30Mdr8FsRafycJNm/OpuJWmg3Wmym
	QpZDgCFu3nMlJGyr7XLqNQBCO5hENN5+QiPPDfVO+q/WBxoAOMCA+XQJ8JQOpSHM66RW4lWSQw=
X-Received: by 2002:a05:6000:4916:b0:487:a15:b4cc with SMTP id ffacd0b85a97d-48e38595e5bmr2679426f8f.23.1792751711919;
        Fri, 23 Oct 2026 03:35:11 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edfb3fsm4713525f8f.8.2026.10.23.03.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:35:11 -0700 (PDT)
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
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
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
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-2-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-2-3041b788e9f7@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:35:03 +0200
Message-Id: <179275170360.4070168.11650113664838519061.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=dNgQAFqyGnVxmM7oecHvQ23reWhdI9mPMjanH5L2B3M=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFm3LaJkUwN+3WXTmhS0Wn1LV8+H60VT70se+bvq/c/mj
 X9XzNSO6yhlYRDjYpAVU2Sp4a4Wfyep9WXWdJ3bMHNYmUCGMHBxCsBE8tYxMpwu5GVlv+ARel/H
 l4mrmS0wQetMf0lT0c80eYtlV0OENRgZLlT8mjPF1ViKdcu9H62FN3cvnnFj228+iQvsp3ccXsR
 nxw8A
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> Preparing a clock protects its current requirements, not the resources
> needed while changing its rate or parent. A transition can temporarily
> use both parents or access an unprepared clock, and a parent rate change
> can cause other clocks to be programmed too. Raising resources one clock
> at a time leaves those operations exposed to insufficient power.
> 
> Failures make this worse: hardware may already have changed when the
> operation returns an error. A matching cached rate is then not proof
> that resource reconciliation finished. Retaining a temporary enable
> reference without a corresponding prepare reference also breaks a
> consumer's normal disable/unprepare sequence after a failed reparent.
> 
> Make CCF acquire the affected tree's and parent paths' resources before
> notifiers or programming, and reconcile them only when the walk stops.
> Keep fault recovery independent of rate shortcuts and subsequent
> consumer reference-count changes. Require explicit recovery of an
> ancestor's uncertain parent selection rather than reporting success
> from a descendant request.

I don't think all this is necessary to address the problem described
here and in the cover letter.

IMO a new provider API is the wrong layer. The framework already has
the hook a provider needs: the rate change notifiers. What the core
should do instead is fix those notifiers, which do have a few issues.
You are fixing one in patch 1. Another fix, about setting the parent,
was sent recently:

https://patchwork.kernel.org/project/linux-clk/patch/20261021-submit-clk-parent-abort-v1-v1-1-2936181822fc@gmail.com/

You want to act on some changes before anything is programmed. PRE
notifiers are the right tool for this. The user of this change in
patch 7 could use them AFAICT: PRE sets a temporary vote, POST settles
it, ABORT drops it.

Also, what is acquired here follows the requested clock. When an
ancestor switches parent, the chain of its new parent is not acquired,
although it feeds the whole subtree after the switch.

With notifiers, the parent fault state is not needed either. As it is,
it blocks every request on or below the clock until the same switch is
retried.

Could you tell me what you need from this approach that cannot be done
with (fixed) notifiers?

-- 
Jerome

