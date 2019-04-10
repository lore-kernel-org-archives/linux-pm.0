Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1952C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 05:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6730A2084B
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 05:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nRfrAlRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfDJFox (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:44:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33879 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfDJFox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 01:44:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so854000pgq.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2019 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7MxHhKmonGaKJ09XyLO+r+flNmHvbw8fazpe3XvA4IU=;
        b=nRfrAlRUKoWeXfiOHLT/5gmYar2X7MosuoRm4Z6nSLvrGtoHJlWBOAkwvpX3t6U9wV
         KA5p0bPA0qnm5xgAcA7y6zwTIw+oqMnN2bcPqZ3k+HSwwv4BaGRWMXu9IRUwlh4JtYxQ
         IY5azFjlMyjm5nvgEuMGvnsgGG6dl4Mk6wcuBTonapx/0kJsmszX+ZVi0GAt4A0fFFmh
         zLycnR2rJ9MB6LYpmoGK3H6x+e5jpQH8F3o5EU4BZRRtwDicnCavqRzE6s4RzijU9Km1
         pH/9xPh7LD566aIxos/zP4XO3urfk7oWoabhpHBVsS257FSsbi+MnibafP4XgylHAYjQ
         YR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7MxHhKmonGaKJ09XyLO+r+flNmHvbw8fazpe3XvA4IU=;
        b=NqJygNOmhhDmlTacBDQV1gf7aYDZk/8AwY499lNJ4HJTD0cWJtQwgRQrT9VxKoH0tC
         VGb33MRdbM3AzzmFzyXlA2DhWMOQvH969ymGFb3W3uTAvvC9EECL+KDTPs4HeM2XFsvK
         +hmJGZi2vi4i0sPHfu+HBHJ/15hH3f2Mxy2LjaSzaF7XLSOA+zsQ1yuIXvv6ncXSDZOj
         eDcLNE1qZBQ5jgQ7MIYv3NZgH7NAXueD4sw0/CqWfD+sPeqf2W7BTNwIRuNALlXIe7nQ
         IuxfsAmw7gP3yegFTZfkCxCLOESiDqYqO+Is2B9D/nEqJpDq8tPLst7ogkBSKPtzyN7u
         dsXA==
X-Gm-Message-State: APjAAAWAjawvMroqXaAMGy7me5bm7oB9qrVZiCgOzWL8iLN3671Y5Jgs
        UNWS9O9izluzmMmP46DF4Ih8tA==
X-Google-Smtp-Source: APXvYqyndp/71VG+LGRqwEyk+HJJYgfBrO992H+vy0dmC/lW/kaTlFij2ClbXHYtVs9wCDf+XLXt0w==
X-Received: by 2002:a63:fd06:: with SMTP id d6mr39118168pgh.183.1554875092719;
        Tue, 09 Apr 2019 22:44:52 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id m2sm54221315pgr.74.2019.04.09.22.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 22:44:51 -0700 (PDT)
Date:   Wed, 10 Apr 2019 11:14:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190410054449.zwmemg7vza557gue@vireshk-i7>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190328101352.25657-4-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190410054449.QiSUct6IpMvHT23fNR64Ce2ZU8LYFz8XiIe3TaZAk70@z>

On 28-03-19, 10:13, Quentin Perret wrote:
> +static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
> +			      unsigned long state)
> +{
> +	struct cpufreq_policy *policy;
> +	unsigned long idx;
> +
> +	/* Use the Energy Model table if available */
> +	if (cpufreq_cdev->em) {
> +		idx = cpufreq_cdev->max_level - state;
> +		return cpufreq_cdev->em->table[idx].frequency;
> +	}
> +
> +	/* Otherwise, fallback on the CPUFreq table */
> +	policy = cpufreq_cdev->policy;
> +	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)

It is not guaranteed that the frequency table is sorted in any order, isn't it ?

> +		idx = cpufreq_cdev->max_level - state;
> +	else
> +		idx = state;

-- 
viresh
