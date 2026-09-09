Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3321B192
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930963; cv=none; b=aiU8rfdOfew71gVUhArDp6LJPvtEJPiSshzTP9l6vecvtufnfWrEUahRAxGN0UqEgNlW3JizihQTvy2Yix1Ir1yxX9MMrZAT9B/qWpSXeCbJyZyoGjl5ei2SvxHG0LfUnErvUobKAQHfeHgIps2APTaSKXu2gj19LWhiDF+1cYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930963; c=relaxed/simple;
	bh=Y5VD61VcseLUj3Wx2/Pgy8b5mzwV7DglW1NF+OC3BJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiVSNqOrnctfZdv9Ohfrlb8E6u5+K02rtENgV8t1n9vqDpFw08F/VkpNJ6EQxTH6aZWeVwoCTIejo/1A5CXgKwACikax2TkaW77DvPHFlVw6Ya3LftEhV1x8eoFUvHcIR8kExTA/GlAZHyZ+DhZjiZHLmq5bMEJEja7YjjlA/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mFPfG2jh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFPfG2jh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2dd020a2e44so896595ad.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 22:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788930962; x=1789535762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Dizj3C/uiB0OjdqiLkkdhcvIiLwfs6+aR2Rr8Cl6Hw=;
        b=mFPfG2jhclkuDmyJGs7CoKviSqc4YDm/rjsxh1TsgFV/t2L0o/kE3C9NuGFbAEXI0c
         WrFy/RTDPr/J5kpeDtSfAiLu8wyoUZ2Qm4904yKQ1hRCLFZ4a23k4yv+DpEpgygRIFdu
         UW5L60iAVdwq8XYsRzhiQyZXZTJIrlP/XsRdFG4mwKaQReAP2/KZJcvuJ+JMgFklot4K
         M3DjcOa42AARVGTxcxP8DK3eNbpnUk9nJCLd/0wRlz/RG1m4qINw6qkOk9IlH9FMR/h6
         XEbcil5QLWrARYO9aZRwkCgYKtVeh23vhOwoML51UMuVfmbgWQUXVlcpej5jBqZlvdoE
         kSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788930962; x=1789535762;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Dizj3C/uiB0OjdqiLkkdhcvIiLwfs6+aR2Rr8Cl6Hw=;
        b=N1k1pebxLw1CgaBS2uJNd2/YWyxZ67EAoC1ayiBsMveqUMq/SHLFTBw2Ob5sPp5tyC
         0voorInmEeis/L+jdUgLlcYl+m0CPRUzDXcymh6Nna+1I/8WFnQ3Nr36Dv8eHW4xVETL
         i4pFFAxKKMaShX77X7MdKxdZjy1itZvqkWdb4nVBjEcfIuNKRMTIYSfbzrjqoTyH60T7
         yNgN7i6r1TbABuvUuTW9TVfGdFknZkAQEJ+areZq1DgZf5PxQhEqsx+q+/Mzsiwi40nl
         WyFziGYTm3MBbjskWtSquEZTvLBSu/RIQWlHPssfZmLpGW4BPjaphYNNW1Pd8DSdSNZt
         DXcA==
X-Forwarded-Encrypted: i=1; AKwUvBxS1rZl1gHI0+0fi64jc9kTWk94oZ+wH80AMHU8x2IKt5+9B6ZQj5EiqNWvxufXsPnr/nnpVdZxMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kqyDgk9VIoQ/AgiKCdFLfc9jJUy6RXhLwOklfy0DM4tEeFvPvB
	gYQZPuwIublQL1HJRbgHyEmwdOTN2oDokhQ32/uPEccUzdMPHopl02cN9JihFikzEyc=
X-Gm-Gg: AYBFou06sSKmMVoSivOI8UXeWWNEdE2YLGZrCVIIEdVxPaVWXlrprA56himCn5R+v7w
	5pU2ZHrsMtlEasNY0C8r+nv7gr22BaVFQdXCFUE8uttmfLyrETeeVGsnEN9sIf6WxbJ8Jmyzx8I
	s4hFppUUXNZLxK+v8iPJbc/l+88RuQIQhQCMbELMobyWeZ2c1Bcddu2eN1aPMZ5PozhVA7vnC/7
	X4Wyve+C83APy70iqOKxOlzxxXE+7g5v1bzzX6I7pTuDqUTbrwFCjXNmSJQcdIaJkOkg+1H6/oh
	UqShk37D/awWzbeFRUZxYuF814heO4zINZfyk4fGeCr8cRlreUAV9HrtyjbCb8+evmuc22Yp3Jc
	UnQcR9W+lZ3W2Hap140tf2a3OYHlpEJWfeV2uFTyTJD+UfzyaXOQXC4kgWtjWt0reJ1JmU5SvOO
	QysK15E1NaidZZRVG6fcSfVpyk+oRTX36DEb7wSlU6JvAP1vuMfwaoruwh+SoYz9BS2TpEKP0DG
	Q==
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39b26273a40mr51002778a91.21.1788930961625;
        Tue, 08 Sep 2026 22:16:01 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1becsm2904831eec.22.2026.09.08.22.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 22:16:00 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:45:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, alim.akhtar@samsung.com, krzk@kernel.org,
	kernel-team@android.com, jyescas@google.com
Subject: Re: [PATCH] opp: fix use after free in _update_opp_table_clk()
Message-ID: <aqDrjQVCy9VkjleX@vireshk-B250M-D3H>
References: <20260908-opp-core-uaf-update-opp-table-v1-1-93d3fc928c5c@linaro.org>
 <dd704898-c51d-46e4-bef2-28d863cdee22@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd704898-c51d-46e4-bef2-28d863cdee22@linaro.org>

On 08-09-26, 16:41, Tudor Ambarus wrote:
> 
> 
> On 9/8/26 3:37 PM, Peter Griffin wrote:
> > dev_pm_opp_put_opp_table() frees the opp_table which is subsquently used
> > by dev_err_probe(). This causes an Oops during boot on gs101-oriole.
> > 
> > cpu cpu0: error 000000006b6b6b6b: Couldn't find clock
> > Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cd3
> > ...
> > Hardware name: Oriole (DT)
> > pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : _of_add_table_indexed+0x80/0xbb0
> > lr : _of_add_table_indexed+0x6c/0xbb0
> > ...
> > Call trace:
> >  _of_add_table_indexed+0x80/0xbb0 (P)
> >  dev_pm_opp_of_cpumask_add_table+0x70/0x120
> >  dt_cpufreq_probe+0x23c/0x480
> >  platform_probe+0x64/0xb8
> > 
> > Fixes: 84f05af0975c9 ("opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error pointer")
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> > This UAF regression was introduced in v7.3-rc1, and causes an Oops on
> > boot for gs101-oriole (in part due to our default upstream kernel dev
> > config having memory poisoning enabled, hence the 0x6b6b6b6b
> > pattern). It is intended that this patch should get picked for the
> > next -rc.
> > 
> > Peter
> > ---
> > ---
> >  drivers/opp/core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 2fafd983de8f5..c8b941cb81b44 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1581,6 +1581,7 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
> >  					       struct opp_table *opp_table,
> >  					       bool getclk)
> >  {
> > +	int ret;
> >  	/*
> >  	 * Return early if we don't need to get clk or we have already done it
> >  	 * earlier.
> > @@ -1607,9 +1608,10 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
> >  	opp_table->clk = clk_get_optional(dev, NULL);
> >  
> >  	if (IS_ERR(opp_table->clk)) {
> > -		dev_pm_opp_put_opp_table(opp_table);
> >  		dev_err_probe(dev, PTR_ERR(opp_table->clk), "Couldn't find clock\n");
> 
> you can do ret = dev_err_probe(dev, PTR_ERR(opp_table->clk), "Couldn't find clock\n");
> > -		return ERR_CAST(opp_table->clk);
> > +		ret = PTR_ERR(opp_table->clk);
> 
> and you won't need this duplicated line.
> 
> with this addressed:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Applied with the fix. Thanks.

-- 
viresh
