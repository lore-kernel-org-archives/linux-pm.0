From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH V2 2/6] cpufreq: Remove cpufreq_frequency_get_table()
Date: Thu, 2 Jun 2016 19:02:50 +0100
Message-ID: <20160602180250.GC2966@e104805>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
 <13d43ddfe208a9b387fe0fd247de069ba0332308.1464876229.git.viresh.kumar@linaro.org>
 <20160602145903.GA2966@e104805>
 <CAKohponBAEZMhiVPNKqbY3nHAT9uB=7rK=SvVaf4jfgMPPft9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47116 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324AbcFBSCz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 14:02:55 -0400
Content-Disposition: inline
In-Reply-To: <CAKohponBAEZMhiVPNKqbY3nHAT9uB=7rK=SvVaf4jfgMPPft9w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jun 02, 2016 at 09:06:26PM +0530, Viresh Kumar wrote:
> On 2 June 2016 at 20:29, Javi Merino <javi.merino@arm.com> wrote:
> > In 5a31d594a973 ("cpufreq: Allow freq_table to be obtained for offline
> > CPUs") you did the opposite: don't use cpufreq_cpu_get_raw() because
> > it won't give you the policy of a cpu that is offline.  Now you are
> > arguing that we should go back to cpufreq_cpu_get() which implicitly
> > calls cpufreq_cpu_get_raw().  Won't we hit the same issue that
> > 5a31d594a973 was trying to prevent: that we can't get a freq_table for
> > a cpu that is offline?
> 
> Yes, that should be fixed. Thanks for letting me know about it :)

Ok, that was my only nit.  Other than that, it looks good to me.  For cpu_cooling.c 

Acked-by: Javi Merino <javi.merino@arm.com>
