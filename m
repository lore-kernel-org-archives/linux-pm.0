From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/10] cpufreq: governor: Use common mutex for dbs_data
 protection
Date: Sun, 7 Feb 2016 15:01:12 +0530
Message-ID: <20160207093112.GB19059@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <76588769.1gWBaNHTiQ@vostro.rjw.lan>
 <20160205065341.GE21792@vireshk>
 <4787292.dQnn9ZTm9B@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33595 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbcBGJbQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 04:31:16 -0500
Received: by mail-pf0-f177.google.com with SMTP id w123so93773448pfb.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 01:31:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4787292.dQnn9ZTm9B@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 05-02-16, 23:59, Rafael J. Wysocki wrote:
> One more observation here.
> 
> If we are able to eliminate dbs_data_mutex from update_sampling_rate(),
> then cpufreq_governor_dbs() becomes the only user of that lock.  Further,
> if we can guarantee that the governor's ->governor callback will always
> be invoked under policy->rwsem, dbs_data_mutex becomes unnecessary and
> may be dropped.

That will be guaranteed with my 7 patches, which I will rebase and send again.

But there are cases where a single dbs_data is going to be used for multiple
policies and so relying on policy->rwsem isn't going to be sufficient.

But, yeah, we should be able to narrow down the locked area I believe.

-- 
viresh
