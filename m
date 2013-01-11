From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: drivers/cpufreq/cpufreq.c:51:17: sparse: symbol 'cpufreq_online_mask' was not declared. Should it be static?
Date: Fri, 11 Jan 2013 23:47:15 +0100
Message-ID: <4518630.CgYC5fVtRj@vostro.rjw.lan>
References: <50f017f7.SoVcNexmm6uNvfQX%yuanhan.liu@linux.intel.com> <20130111140301.GA25489@localhost> <CAKohponzGnFdzAk0PzTsvrt9PA2OH1Aaa9VQh4+En3KdGbJwFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38244 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756049Ab3AKWl1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Jan 2013 17:41:27 -0500
In-Reply-To: <CAKohponzGnFdzAk0PzTsvrt9PA2OH1Aaa9VQh4+En3KdGbJwFA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On Friday, January 11, 2013 07:38:26 PM Viresh Kumar wrote:
> On 11 January 2013 19:33, Fengguang Wu <fengguang.wu@intel.com> wrote:
> > FYI, there are new sparse warnings show up in
> >
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> > head:   f3bb59ab652c781155b1c5e42ef7e29bf936d86b
> > commit: 536ff06aba714c1d2d53cfca86b1a2e455842387 cpufreq: Don't use cpu removed during cpufreq_driver_unregister
> > date:   15 hours ago
> >
> > drivers/cpufreq/cpufreq.c:43:8: sparse: symbol 'cpufreq_cpu_data' was not declared. Should it be static?
> >    drivers/cpufreq/cpufreq.c:46:8: sparse: symbol 'cpufreq_cpu_governor' was not declared. Should it be static?
> >>> drivers/cpufreq/cpufreq.c:51:17: sparse: symbol 'cpufreq_online_mask' was not declared. Should it be static?
> >    drivers/cpufreq/cpufreq.c:72:8: sparse: symbol 'cpufreq_policy_cpu' was not declared. Should it be static?
> >    drivers/cpufreq/cpufreq.c:73:8: sparse: symbol 'cpu_policy_rwsem' was not declared. Should it be static?
> >
> > Please consider folding the attached diff :-)
> 
> Thanks for the fix :)
> @Rafael: I hope you can apply that?

I could, but I prefer you to send me a fixed patch. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
