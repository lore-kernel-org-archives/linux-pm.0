Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704062;
	b=ZqnNNmmswYg10UzeBkw46yQVczVQj1g2BclDDiijOjc6Psd3WrFocDl9oEj5Y6NAtZEH
	 lvlzV5NgYRjb9Di7EhAKWUZBO9oOSEDAlrydOYxhsHeK2vdlmNykWjktvly5Zzf7LRrqG
	 4hbu9I4xjVubhBBjxtPhLtB/d61LZs5Q06hJoYjlowOHR+VFqdZk4A4b7zSTvPTKO1BW3
	 Zg1U8P4J6WoQPMJ2F8VGAowyA6QnXK4D+yYngJQDqw+R+21ZaH73fCEeYLl63Jub7nXvQ
	 Wbe1NJrLkUdrqJHoUF25j7X2dsvIjEtkEuyQ5NB6CsScO7vpYcqgAyQQDwv9Or0FAow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wom25+2wqiUds1POyI+eHp228E/IXzic3h0qgPh6IYw=;
	b=T6IzAN4OZFiCqf4BQZ4ZRe/RQIQgBJfRtYqxXphMKbeITd+oL4YV+QwUllSCmQ6HVIam
	 ls8Et3gf3swpMJVwjfjZpwavdR6unVE9sJQzL9PlkD6uJzTFQhkOHEMlSKEgu5gn9Si5X
	 W7OW4NjRODBZvLrSqHmssT4wb1WReT3amS2pWvd0vfvFJoC/SBj8IJ0gPSnm2U2b35AqH
	 GY8qXHNDujYcjfrcw1//xsbhI2oMe9wF7T9RrzPBDomeBD+tjqYoP4tmZUjfUiX63D3ke
	 MoRlmz322xsDnJdKgHVugdj5t/qcu6eYDt9eJ1mPBHn+b35Kb2WPHdLgsFrHNdY5keg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JecE9e1b;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F4606A32C
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD3F4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JecE9e1b
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so3035033c88.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794704061; x=1795308861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wom25+2wqiUds1POyI+eHp228E/IXzic3h0qgPh6IYw=;
        b=JecE9e1be6XXuDyJ7bsgq/w6HNy3eTpyXi1AnZBs/ei9qYWQUmrKztlbQdKX0HcKqb
         4pgIkEA8JoEfTgZWYZgcyyZQwbzGqa1gKXYfeU2pAlHETUAUohb3vCfaYlgmuSgitCgA
         RULyMt+x/Bt2iWu2zJdswd3YMeqTdKOZni+eTnFEgD42p9ze+wPrzfs8wqG6lIhd/9xC
         oBZX0inwvbqy1FyaQFAqtaAkPfp/WjqDbKQD4eZ/zlYAwLJs4UOdXYv1Wb/dtLGUdlQy
         Dz4UFFvuQ7VGcgqkpyQ24FzjW+k4VXyWNs9/Xvn9UcaUg/F9U3TUFT51OEwBoOKqAJrP
         sMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794704061; x=1795308861;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wom25+2wqiUds1POyI+eHp228E/IXzic3h0qgPh6IYw=;
        b=HcRhH2VMWOHNa9Cg3fEK1ShkyBJlA02jO1FCEcwkCfzx1CEOxlaZik7Z9w8tTyV6/d
         9ASz9Qz3hwh92Ve8z9x2uUGtz8ilD1HXTbZK3ZU3ZASBPqn2qpHMY8p8bAlnwunzhhaX
         QJPtYYhRRGopoS7k90nr6VDfxAzjsbASbUIby2q4/x9A8nauds8WQnnWZxW8zglIAGYw
         bmE1wmSRVAWp86n39e9u7AUo5PP9Ow2TXBBKdDIAbbx79AMdUKEVo7rS7zgxh35cWMxH
         LrthO9LE79c0G53EVj1qIciW8TJIGpjum6lmrgns7gFloi9C3i/wveMPckkuOcZntcQX
         TSqQ==
X-Forwarded-Encrypted: i=1; AL+hErEaXUvNiSFlpMnr073ixNmbEtVEtfaR2Y1yf1F6mV/XX9JUXcwVaE9mcVDlzbWRP+cypnSCtOrN1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9UqT0NH+2hQwe9JxYGq7CNZFZavmrhjHTbaOfmL0EESW8eRRxG
	LGCwAbsmoX85oA9goEuFIDngdhM1haeQFSQLXht8+0Xkl8dodWASoj92
X-Gm-Gg: AYBFou0NLdVcevs53St+6d791EP1Ev87P3cH/7vm7Bz0Bgm5nWZg3j/ObXafkrZXq3W
	preSeUfjj9kTuB1OZRASIt9ycXqPTmIO3ylh9tpoCY5ueqHuD+NVLKlnwK047DzELT63A+VBWSJ
	8bxQEFhvesugDm9dT0fm8IKiorBTd22c9nnPBA27HOJTaSvpKJOj0pN0RBgSrfAVrJ2qSmpNCx2
	ex5Qo7A3yQD5MRhVJTXPECq9T3yqFmJuK70HjtBddotObIQt9yF3nJP3uRJcAz7nH3bspTGIkEK
	57HmehCyn4LXfMu4Z5TYpwA0u9t+wIplVoxKNezhIF754QOkFrp5Mqejd215NLTstlKMmTsFTXV
	ErJsyNgkI7r35fWo26qkjwGW1rdEqxtERR8cbm/1OHXeVzy/sSZ0CBCDwk+oJ/Tbx1XF6YjkhDJ
	QMZBgj9y6sWFIAWIt5H43bHJfYvHOtVW9/uLAjn7nyOdga1lLuMejqACfAMlW+ALN0CN8mGmu5F
	/nDdGAXgEhXd1MpjtjydbJ3pWNiUe7En+kho0c1ttWCKGPAiVaLxrki41Ljncm51GAKZN3fCb0H
	l+MFDDkVb3MNkBvATrInU4+f0iLTBe1NsMOFR4SWjIqw+WU6k9k6Ndrz5PWTMg3Xph8=
X-Received: by 2002:a05:701b:2706:b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1b503120981mr6267107c88.46.1794704060898;
        Sat, 14 Nov 2026 16:54:20 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm29598546c88.3.2026.11.14.16.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 16:54:20 -0800 (PST)
Message-ID: <9c1a915b-dbf5-44d9-88eb-680449348dcd@gmail.com>
Date: Sun, 15 Nov 2026 09:54:15 +0900
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v2 4/8] PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf
 capability
Content-Language: ko
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
 <20260921-rockchip-dfi-cleanup-v2-4-43ff34ac8599@collabora.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-4-43ff34ac8599@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 5:32 AM, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> The perf subsystem's PERF_PMU_CAP_NO_INTERRUPT is a bit of a
> misnomer.[1] Instead of meaning that the PMU has no interrupt, it
> actually means that the PMU does support sampling. On CPU PMUs, this is
> equivalent to not having an interrupt, but for uncore PMUs like the
> rockchip-dfi PMU is, no meaningful sample data could ever be generated
> regardless of whether or not there is an interrupt, as it is not a CPU.
> 
> Since rockchip-dfi doesn't seem to make use of the interrupt the DT
> provides it with anyway, this was probably never a confusion that
> existed in this case; the capability flag was likely just forgotten.
> 
> Add PERF_PMU_CAP_NO_INTERRUPT to the set flags for the pmu struct's
> capabilities member, so that the perf core knows about this limitation.
> 
> Fixes: 4d586b5724d3 ("PM / devfreq: rockchip-dfi: Add perf support")
> Link: https://lore.kernel.org/all/20250619140442.GH1613376@noisy.programming.kicks-ass.net/ [1]
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 5339616f7ca6..dd9edfd6a674 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -646,7 +646,7 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
>  	seqlock_init(&dfi->count_seqlock);
>  
>  	pmu->module = THIS_MODULE;
> -	pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE;
> +	pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT;
>  	pmu->task_ctx_nr = perf_invalid_context;
>  	pmu->attr_groups = attr_groups;
>  	pmu->event_init  = rockchip_ddr_perf_event_init;
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
