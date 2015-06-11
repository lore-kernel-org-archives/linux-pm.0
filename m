From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: thermal: cpu_cooling: Use cpufreq_dev->freq_table for finding
 level/freq
Date: Thu, 11 Jun 2015 08:35:42 +0530
Message-ID: <20150611030542.GM24662@linux>
References: <20150610150211.GA30208@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36645 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbbFKDFr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 23:05:47 -0400
Received: by pdjm12 with SMTP id m12so49014882pdj.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 20:05:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150610150211.GA30208@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org

Hi Dan,

On 10-06-15, 18:02, Dan Carpenter wrote:
> The documentation is very clear that this loop is correct.  It also
> turns out that it used consistently almost throughout.

Right.

> But when I see
> these unusual limits, I know it is often difficult to be 100%
> consistent so I kept looking.  It turns out there is off by one mistake
> when we allocate the buffer.
> 
>         cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
>                                           cpufreq_dev->max_level, GFP_KERNEL);
> 
> It should be allocating:
> 
> 	sizeof(*cpufreq_dev->freq_table) * (cpufreq_dev->max_level + 1)

Not really. This is how the code looks:

	/* Find max levels */
	cpufreq_for_each_valid_entry(pos, table)
		cpufreq_dev->max_level++;

	cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
					  cpufreq_dev->max_level, GFP_KERNEL);
	if (!cpufreq_dev->freq_table) {
		cool_dev = ERR_PTR(-ENOMEM);
		goto free_cdev;
	}

	/* max_level is an index, not a counter */
	cpufreq_dev->max_level--;


So when the block was allocated, max_level was total number of levels
and was reduced later only.

> We could just change the allocation, but really this kind of unusual
> limit is just going to cause more headaches in the future...

I understand your concern, but it all happened because of the way
thermal layer expects the state. It wants state to be the index or
level of the cooling state. And that corresponds to the index in
cpufreq table. And so was kept this way.

-- 
viresh
