From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 2/7] cpufreq: Call __cpufreq_governor() with
 policy->rwsem held
Date: Thu, 11 Feb 2016 17:22:54 +0530
Message-ID: <20160211115254.GC28558@vireshk>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
 <2d9def751daa27c9aba57ab29a54003dd279e5e7.1454988792.git.viresh.kumar@linaro.org>
 <CAJZ5v0hVhVyDvk1Vj5NAh1w1nXEZ6eF0v9x+8CfZ6pyKSu=k9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36642 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbcBKLw5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 06:52:57 -0500
Received: by mail-pa0-f50.google.com with SMTP id yy13so27866035pab.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 03:52:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hVhVyDvk1Vj5NAh1w1nXEZ6eF0v9x+8CfZ6pyKSu=k9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11-02-16, 10:48, Rafael J. Wysocki wrote:
> On Tue, Feb 9, 2016 at 4:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Also note that cpufreq_driver->stop_cpu() and ->exit() can get called
> > while policy->rwsem is held. That shouldn't have any side effects
> > though.
> 
> The last paragraph is unclear.
> 
> Is it supposed to mean that the change will cause
> cpufreq_driver->stop_cpu() and ->exit() to be called under
> policy->rwsem sometimes?

Yeah, reworded it a bit ..

Also note that, after this patch cpufreq_driver->stop_cpu() and ->exit()
will get called while policy->rwsem is held, which wasn't the case
earlier. That shouldn't have any side effects though.

-- 
viresh
