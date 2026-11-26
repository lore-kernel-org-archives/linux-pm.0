Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669855;
	b=M4VXH06va/CGc/V6lQUadP9lBvevaUO2coE1IN/h8twXwF3devMzmc/2bqBIPGc9MZrr
	 siCrZrHbl0Z3CyaAVlsuBKtMV6AZuNbmysrmiCJCu1dQfHIXAFDhJ0NXgqBA9Ecjkssv6
	 z/Wqlg+U9jjBgHfYvsJDneW2XIXAjgdRAu8+ViT0T4aed7TXJz1fnuHnyJQ/PaPKTZxTl
	 QZ2+FxvkvN/SooVzNfnzUAXLkH6QLrovEFcFr/G2uLmoqiE7XU8vk6ycPTa12jJ6uMYz0
	 1SR/cKNGj1KeBE4djsBqIJueUyRB4uGmYDHsoh8lHB0zIpqdVvYl2n5Orx0kVj0FsVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=snVo1HNElaQNXOPEvwHsx/ZOqgseUpxA8o54IYlLJqs=;
	b=QOQEDYNqzJHOdBTe2WkV55remxTQBbg6Q/q2Wd8HX0EnXjeMiD+B6AF7DL3Q/0VEWIm5
	 qBPcrQRKVkKhBp98GOP6fVCCoeRat1S9O3mbl/NyKEwHaQ/QG3DOhi58YSPS5TSitXZAT
	 c+s7bCiRcxjjnULWyX/SVyrWnhpYDfa3SmWsdPQVqUAKEobowGq5++AzoImzRCdK3MIgX
	 PQ57F9sRJjh/YKI/k/og8PankNmX+1vibQMCN35t30zeRFW3/5LVc6SuJceNPK+NF+N5R
	 2WtGWJgVqPbeBpLSXO3b1h9w+0Z8cMHcMBHHnUCOjUayl0X5Me12ZMR4wDphvjiZnVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=koo80xtt;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62115606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62115606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=koo80xtt
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3b4944a0eso5005865c88.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 21:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795669854; x=1796274654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=snVo1HNElaQNXOPEvwHsx/ZOqgseUpxA8o54IYlLJqs=;
        b=koo80xttp8geMgFWEU8bag5Cp8NMbqNHiK7kwUEroiZTZ29SdBiyGGotzYoiu33bTa
         UwY/ptC145WUKHWBA3x8fQXypO5iGoJWBzrQa2siyDjf6QleJy3SlzLiFSjtpNBjWe/Z
         5w6olFcNx37XXa94u4v/C9gbqIJS10mENTxBmCudh2SAB1iuNImFNr1XQSZ8dLWcLzo5
         s7l605ESWnqrRYxZNVLgRDqQsYxX2Cxxat93m6kGhcp/Uy8bb/OB3gMKYEi5VufiL8S4
         cFavEYRuNUHr2c943YG3QEsDfSPrMUyN8QHZKiCv+91BrB/EXTtqOaUvAomAAoKij+mg
         cwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669854; x=1796274654;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snVo1HNElaQNXOPEvwHsx/ZOqgseUpxA8o54IYlLJqs=;
        b=1hysZf76XFE4ZeBD4blsc6cui1EQvRahPIqTcTlGIk1nJybgpMlapQHZ0TzJL2h7Qx
         bpmBn0dFUPJudQTB2dmV5ATNW4L/cuXOO35lED4dYWRy7rLHef3oF2m5Zb7cP0YPpqHA
         LUFanpPpnQIcUmunaElv63UPufRMNeKtBK2KybDoifBZ0Dph4e29feB3rkMMSl9FinfB
         ymV9viyU84OsJinsxzgPRijedA5VwcFW3ee8LnbOw3yVvER4ctSnUKgYVZTUmcPyjfTU
         8WmDld1pqS0zfrpXKuVO1nz1paau9YWoz4RmvUpGXzjuU1njgdhy6QwNQG5yuAufC3DT
         JMDw==
X-Forwarded-Encrypted: i=1; AL+hErEqITNW4YToBLy896pTg3Gp4aejjKeWA8BGk3U2fNwdM4yH+NLYiDwsZVgtqvd8c/0SfZFzf7wu+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8H/jCpr68HBQT9+nlbS5HRTsTDNASKeZqp5sSpMk6ecXImND9d
	EZJLZzl4EmiuS6Z7W/hCNjTuA2LM4VuGqCjsHRN7TzQLzuzvDXhTUmza/visx+nseHA=
X-Gm-Gg: AZFdTZcqfmMjj2pv/7xHqQ71mhtG4d9P+/5L8NEZsuUjhv+OluggtefltswEo1gwoZ4
	/xeF2O504VbuntVti/p9PIWP9U08w2nNiHGA88DLYg80bnNy4ibf3XfynXPD6gW+FwO4W69kxrG
	ezWoC/QRCYHfNnoZaApXqHu/9ZtG2mlnQAoaqXp0pcmqstHmfpXWj9DTa3vCuFNW0g5UChJ4ks9
	38ApnLr9or2m349xck+AhcsM5hyPbbbecJebe3iNi9THH5FWOYbjUIK8vJgy8EQSyR6XgM+W5P2
	VtumBVTwZY94gxFFLRcX3+keDbB0ZOvO6HIynz2xiKh3XXiCcofTxA8WKKFvh7sf3Hi+5XJkV7s
	IKZeRFSKPshDFgZoc/sxy66+SML9WqONWAK+D/zxKM39d5nx86P3CPo9JCKTLPGMZrR5sDOU93k
	szDhAOGR1HBOtFNO+ijOogC6oztwzqEmg94PwtArq52YdqFeGAvo4mIbRUTtNdf6QQIFWJRkgxW
	IBoZ/H2yXzlzSifnwqzHCzWvryNDOGXiHdWs7cj66RzDEhoPDWjd8i9avuUtl1Uubv8ZYtzacfk
	i3WPWDrSdW9ZgweEGiEkIBdngkmrBQ==
X-Received: by 2002:a05:7022:3f07:b0:138:30b1:4c00 with SMTP id a92af1059eb24-1b5567b5685mr22918571c88.3.1795669853936;
        Wed, 25 Nov 2026 21:10:53 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm38643650c88.11.2026.11.25.21.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:10:53 -0800 (PST)
Date: Thu, 26 Nov 2026 10:40:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	christian.koever-draxl@student.uibk.ac.at,
	neil.armstrong@linaro.org, sboyd@kernel.org, bmasney+clk@redhat.com,
	khilman@baylibre.com, rafael@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	Christian Stefan =?iso-8859-1?Q?K=F6v=E9r-Draxl?= <ckoever@outlook.de>
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
Message-ID: <awe_Wur5fVbeqV2d@vireshk-B250M-D3H>
References: <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
 <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
 <at8WfX_G0tfTlFrm@vireshk-B250M-D3H>
 <9556e959-daf3-4c85-8794-9613e7e7a9ae@gmail.com>
 <A45EC676-5B14-4932-A4CF-87ED3B71108D@gmail.com>
 <4a51e879-708c-49dc-a08a-3f64eeec8bbf@amlogic.com>
 <CAFBinCBkJJeRPKLFBA9KYjwXMxFjow_NOtvFoKRQdxD=rOPW3w@mail.gmail.com>
 <48b333a3-ef88-4739-a087-3ed9d8ec60a4@amlogic.com>
 <CAFBinCCgmRmk--W53wqdJhF-SzJbai--s7wyzDNt3LpfN00spw@mail.gmail.com>
 <b606819a-661e-4488-b5fb-9e786de463c6@amlogic.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b606819a-661e-4488-b5fb-9e786de463c6@amlogic.com>

On 23-11-26, 20:23, Chuan Liu wrote:
> I have already completed the support on A9, but cpufreq-dt currently only
> supports the single-clock case, for example:
> dt_cpufreq_early_init()
>   ->dev_pm_opp_init_cpufreq_table()
>     ->dev_pm_opp_find_freq_ceil()
>       ->_find_key_ceil()
>         ->assert_single_clk()
> 
> set_target()
>   ->dev_pm_opp_set_rate()
>     ->_find_freq_ceil()
>       ->assert_single_clk()
> 
> Both of the interfaces above are limited to "single_clk", so SoCs that need
> to adjust the DSU clock in coordination with the CPU clock (such as SM1, S7,
> A9, etc. mentioned above) cannot directly work on top of cpufreq-dt.

Have you tried something like this ?

drivers/ufs/core/ufshcd.c:int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,

Finding the right OPP should be done based on the primary clock only (right ?),
but configuring multiple clocks is possible via the OPP core.

-- 
viresh
