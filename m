Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005188;
	b=TM2xE+6TCk0L7YJJ25Oxq3w10ZaSXru9z6SLLo0Uq1o3DXEDLV/7wlPAwZOdPwYBAijm
	 HxSo9JrsBUGfzhX+RHDe3lztxgBdzyd/tl0Gos4rQZvb8MFtWKe/cZvkchLkjP22NVhVx
	 XnDjj8QgVfSEIiZlWo1abhBIEWG+KLvNkZds3sT+uXPyx8BjRpzIV4kMUGnZ5iHFjbQjD
	 8sSSoN2RDSZJaTX/CwaPxu7u8akXJ4qhx91FsL5k8ylUTThJcUMr9x4oufWGeQDfzGTaV
	 NpNUCvb6RsG8wNYVRM4xvgB1nBp8VWE+EwFJKP2QIIabvCYCezMSDOMwihT/nre4CmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=49/7WOJdVSLVzoq5oWG2Xe+wRQoxoxRWiSnOqn8O/K4=;
	b=rWbWSxpbI5m6RG6Tvs7yYzm/RZqGeGihlqTFgqjUqq8rm8slsuBnyYvZiBP6orKoCM5K
	 /9J6cq5aQepnv0M/ifbLnN9TYUUIZf6924An6czf49TVil/9WaDz9zE6JdYWMvhvjjzZf
	 vklLb14PyU1VONfu2VkBSo82nztbXXZCzCyM+2SeSmND1UAa2rGl2ccKYMvwE+4UA64Pd
	 Ldt6EzVlloRaGe7xDi887af4usMpQKykQGiXH7UjCilO11i7NlreGX4rLl8JDnmUjg8n7
	 xtG4uZ3lkTEoEfuS3rO5Jhe/Vs47t5kYTQNq6vvKBhkKZOeuIRoMPVS2PSdlq3jFsbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w0PcWQ7s;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0003606A31B
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 08:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0003606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w0PcWQ7s
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so5433352eec.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793005187; x=1793609987; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=49/7WOJdVSLVzoq5oWG2Xe+wRQoxoxRWiSnOqn8O/K4=;
        b=w0PcWQ7s1jwKnNUWE5T/YOshA42iaUDUUhGpDVV/1vK6RT9R1FUequz5lDy708udX6
         XQ2CnxkMcFfd0QMdOLg791j212YiRJl1MqaUIm9FYOP4i82jHT14cg9eWj/f3JIHdbFw
         ozqjcvK9xbUHL8sC/Te9aw7gwRzSCJQSglC44zBUvT74xxDkm7Uahb8MTZffFSaJEk9B
         Ziz4jO9I0BbWb5DvKCz3n9NN/51UaFAuvppNPSCMbEYMLJpXoQ3CQfZA/FjpEz+yNRz8
         THOHu1MVSkPKmIcLqxws1SuWjsSkZ2CihN1soh5iSuzcYy1g9h2P1FMFfLFHXw6t9vvV
         fkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005187; x=1793609987;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=49/7WOJdVSLVzoq5oWG2Xe+wRQoxoxRWiSnOqn8O/K4=;
        b=Uc5GjVNo6BDTX3zgw2yy5crSJsegRep8KPyWEXZz92hrSNYsLm4SalR5Xi0O8oQUBX
         7Y0obWpSBef8h6s/MHOPvbvxHilzlkqGixRq3UX6mn6h9iEV7loTV+n0Y5o7if6UxTpJ
         1/D9qNMOWzCV8ZG2sEQHTOVrpeXMQBZgaSRfQdzK8PcLwJRYKpqxwaxNSVCVyYY0IW9R
         YQfUMQkWiOeKeFDIk8xqZQ38t4HpzprIP4emby6/WsL/9rX+mJuY+ySc1/lgCI4ghbON
         RAc+jZyLWhTP3Pk2dimrnFX8O40Plgj/5aPgYR6osRWqvtlPj+HzDayPrUiVpInRsGCc
         W4XQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLFC03Yl/5qsKXPZR1MXSNkec+H7LqC9gWD71NQTbGzKPmq3q4N7aSRq83l4F+Df/Fo+ApEaC3LA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ24nb+r2bx0i2N/BCsxiaFngMpBaNFgBVrEKWue0p86sr28Pat
	2JnhU2ozX1mMzRnWIxP9Ljj6D4KLGCG92Cg0vFACT2VCiOiXMcs/B9uCBmC54LS3l/M=
X-Gm-Gg: AYBFou0BUc/AHVxe2VhW5YNRRl7x+pe6TBht8zwiy5hD5hto0MzwEZl5f6Ub6K5xAgz
	cAYOFYiQRmcOOAFsAXkAANUeyAW3PaFObzLj0Rp0IMDTj9iukpnrikYFlhOtw1LxCxxNnYGpMoS
	qppmrW2+wUunf1pqL3PsG6sdmZdOFiNL2Vf6SrXYbciI6T261U7urxLHrJFyybt4eSVCgJ1lxaE
	8uPr/z2KLd+fs4AUjd9npgmbV20BOtAY5iPSogBsPYuKv8rJN0iDcvZq1ugulf4b69g53DpMSuc
	GcjnPrQ+vJsZBN188fSA+VQ8hZ8wmR/iyKf1yokA/b0wNC1MqnbU63jmCHr6Qv4uO4QrLLhXE7R
	z/cjv3Fbhche8bTgLtYEulg0LfquR9n/QSfA3VDHGY230oNTTJJMAgr0HKX/wpFPdwH7zAPMOe2
	4BFmSeyEt2WQe6ma7vPDJf/sYW2uBdueH2qhQmvLKs+vy2SV8+PjiosOJevO1DXMInuOkIJkpBP
	yG4c/Bvo+iE7uH2WL7Kh0r7inHpe59uvFK549KBABsFM8d0JKrS2fKTLw==
X-Received: by 2002:a05:693c:6017:b0:369:21a:dcca with SMTP id 5a478bee46e88-369e848a2d5mr8835197eec.10.1793005186447;
        Mon, 26 Oct 2026 01:59:46 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a03bea5d4sm4608834eec.6.2026.10.26.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:59:44 -0700 (PDT)
Date: Mon, 26 Oct 2026 14:29:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: christian.koever-draxl@student.uibk.ac.at, neil.armstrong@linaro.org,
	sboyd@kernel.org, bmasney+clk@redhat.com, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, rafael@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	Christian Stefan =?iso-8859-1?Q?K=F6v=E9r-Draxl?= <ckoever@outlook.de>
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
Message-ID: <at8WfX_G0tfTlFrm@vireshk-B250M-D3H>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
 <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
 <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>

On 26-10-26, 09:57, Jerome Brunet wrote:
> On lun. 26 oct. 2026 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > On 25-10-26, 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
> >> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> >> 
> >> Every S4 speed bin runs the same CPU frequencies but needs its own
> >> voltage curve, and the bin can only be read through the secure monitor.
> >> 
> >> Read the bin from the firmware, select the matching
> >> "opp-microvolt-speed<bin>" property for all CPUs, then register
> >> cpufreq-dt. Bins outside the known range fall back to bin 0, which
> >> has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
> >> on the SoC compatible and needs no node of its own, and S4 is added to
> >> the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
> >> the bin has been applied.
> >> 
> >> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> >> ---
> >>  MAINTAINERS                          |   1 +
> >>  drivers/cpufreq/Kconfig.arm          |  14 ++
> >>  drivers/cpufreq/Makefile             |   1 +
> >>  drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
> >>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
> >>  5 files changed, 202 insertions(+)
> >>  create mode 100644 drivers/cpufreq/amlogic-cpufreq.c
> >
> > Is it safe to apply just this one ? I can take this via the PM tree then.
> 
> I would advise to wait a little for Amlogic to chime in.

Sure, I wasn't going to wait for the maintainers to respond anyway.

-- 
viresh
