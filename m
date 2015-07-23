From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: ia64: remove redundant freq_table of acpi_cpufreq_data
Date: Thu, 23 Jul 2015 23:05:31 +0200
Message-ID: <3797364.P63heyTEeB@vostro.rjw.lan>
References: <55AC93B6.7030305@intel.com> <20150720095245.GE8502@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52554 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964782AbbGWUin (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 16:38:43 -0400
In-Reply-To: <20150720095245.GE8502@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pan Xinhui <xinhuix.pan@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On Monday, July 20, 2015 03:22:45 PM Viresh Kumar wrote:
> On 20-07-15, 14:22, Pan Xinhui wrote:
> > From: Pan Xinhui <xinhuix.pan@intel.com>
> > 
> > freq_table is now stored as policy->freq_table, so drop the redundant
> > freq_table from struct cpufreq_acpi_io.
> > 
> > Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> > ---
> >  drivers/cpufreq/ia64-acpi-cpufreq.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
