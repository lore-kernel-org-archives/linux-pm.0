Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F48BC10F14
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B85520645
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 08:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARPMzTFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfDWIf3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:35:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37854 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfDWIf2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2019 04:35:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so7118648pfr.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2019 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3KjmHO7ChLmrfdNk+KNRkPAthyrRoIrvcfMb8DQ1Jps=;
        b=ARPMzTFPN9GUX5Gr7TH7BI5yYbk+JcOIeYpVExOq6QxF0rOE/D5+K2T9PyxRrGyNyZ
         Da3U6pQfFbg8/fS+9vJ7svZAS/tcuSBv0RHs+jduU0Va783pigWPzt/wrZgjeiO+4Ibg
         SN2WsAZy6+N+xQCZesklYhDNRFr+REs6rT2HuHMHDfOj/bn4S9CW+Mm33BlojqxzlloI
         +FwPa/GILkv4w+e0uIrTe7gFCaRvItzpfdLfTmfhOXC8ZMnS5Gx+gXFHIdilZqo/itsZ
         zuNqmvqGwpBSvCxp2BQ6pNhRjSdujsX6WuD8hMToLAKvPWqGZ+C14n63xPnzSxA5J0c+
         XpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3KjmHO7ChLmrfdNk+KNRkPAthyrRoIrvcfMb8DQ1Jps=;
        b=qhC/fo6m9J6EXBNPy2mg6fNmYew64XmwGxa6BgxuQXo7iaTRqMlja4kHBvOg7tUAJg
         lbheZz62gNdWc/Tz3MSo8dKT2O8GVa9gYYEgV7kPT1cBXOSTnU0yLn40BY4ouYJ3l023
         8xmkb93031hj/WMGxGqfkJxW41WPQWH07+RG08Bm+vH4VRGAP7qjPxqRNSOYS9t36P7V
         g1Q2YH1eM/cQ4/us3Z6X5PtjFpuQONtW5NXza1d8qCIVm/p9CVaI+qck4GpNxk1yI+fb
         ZbYcmAueo0iAtNOw2ubQB54VasirUj2ptV4PxGAJQPZDwVb5mdRTCRwTcIRJGTaDE2RU
         lB4A==
X-Gm-Message-State: APjAAAWgvNwFpmcwyRTTINbECarif2d/KqvRMT6XrTaufNRrA24wgvr/
        XgPtiuRWu53Hny8Fe69LGNS3Eg==
X-Google-Smtp-Source: APXvYqx8ncasLWzG4WxlGjRpytbUf6yevxYeFMJvGJ8JRusKwyfi3Ja2LfMMoaND9uU1CvmpioWmlQ==
X-Received: by 2002:a63:fb01:: with SMTP id o1mr13245860pgh.135.1556008527989;
        Tue, 23 Apr 2019 01:35:27 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id s19sm19448206pfe.74.2019.04.23.01.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 01:35:26 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:05:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mka@chromium.org
Subject: Re: [PATCH v2 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190423083524.io3n64i3orkclw5o@vireshk-i7>
References: <20190417094301.17622-1-quentin.perret@arm.com>
 <20190417094301.17622-4-quentin.perret@arm.com>
 <20190418035323.onyfxo4kprwqz2wl@vireshk-mac-ubuntu>
 <20190418080429.pn4r6lnftlfsf4c4@queper01-lin>
 <20190422082518.jenl4x7rkmv3j67x@vireshk-i7>
 <20190423080732.rmwxjh67re57sayk@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423080732.rmwxjh67re57sayk@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190423083524.2-cL6iv0OmQ6X-2xotXubwY86JzeoSEbo8lI3Msgq9Y@z>

On 23-04-19, 09:07, Quentin Perret wrote:
> On Monday 22 Apr 2019 at 13:55:18 (+0530), Viresh Kumar wrote:
> > On 18-04-19, 09:04, Quentin Perret wrote:
> > > On Thursday 18 Apr 2019 at 09:23:23 (+0530), Viresh Kumar wrote:
> > > > On 17-04-19, 10:43, Quentin Perret wrote:
> > > > >  static struct thermal_cooling_device *
> > > > >  __cpufreq_cooling_register(struct device_node *np,
> > > > > -			struct cpufreq_policy *policy, u32 capacitance)
> > > > > +			struct cpufreq_policy *policy,
> > > > > +			struct em_perf_domain *em)
> > > > >  {
> > > > 
> > > > > +	if (em_is_sane(cpufreq_cdev, em)) {
> > > > > +		cpufreq_cdev->em = em;
> > > > >  		cooling_ops = &cpufreq_power_cooling_ops;
> > > > > -	} else {
> > > > > +	} else if (policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) {
> > > > >  		cooling_ops = &cpufreq_cooling_ops;
> > > > > +	} else {
> > > > > +		WARN(1, "cpu_cooling: no valid frequency table found\n");
> > > > 
> > > > Well the frequency table is valid, isn't it ?
> > > 
> > > True ...
> > > 
> > > > Maybe something like: "cpu_cooling doesn't support unsorted frequency tables" ?
> > > 
> > > Right, otherwise I guess that could be confused with the check on
> > > cpu_table_count_valid_entries() above. And while I'm thinking about it
> > > perhaps WARN is a bit too much here ? We can handle the error safely so
> > > pr_err() should be enough ?
> > 
> > Hmm, I would keep the WARN as it is hard to miss it compared to a
> > simple pr_err.
> 
> Right, I don't really mind either way TBH. But is this worse than having
> a NULL policy for example ? We have a standard pr_err() in this case.
> And same thing if the cooling device registration failed actually. Do
> you see a good reason to deal with EM stuff differently ?

Okay, that should be fine then. Use pr_err().

-- 
viresh
