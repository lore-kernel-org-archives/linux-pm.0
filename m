From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] cpufreq-stats: Minor documentation fix
Date: Fri, 9 Sep 2016 13:03:59 +0200
Message-ID: <20160909130359.0e5c8d2e@endymion>
References: <20160908123943.6141564f@endymion>
        <20160908112006.GS27345@vireshk-i7>
        <e538cefd-dc59-e135-d07e-4c3e1603a8e5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57793 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752956AbcIILED (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Sep 2016 07:04:03 -0400
In-Reply-To: <e538cefd-dc59-e135-d07e-4c3e1603a8e5@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>

On Fri, 9 Sep 2016 00:38:59 +0200, Rafael J. Wysocki wrote:
> On 9/8/2016 1:20 PM, Viresh Kumar wrote:
> > On 08-09-16, 12:39, Jean Delvare wrote:
> >> The cpufreq-stats code can no longer be built as a module, so it now
> >> appears with square brackets in menuconfig.
> >>
> >> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> >> Fixes: 1aefc75b2449 ("cpufreq: stats: Make the stats code non-modular")
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> ---
> >>   Documentation/cpu-freq/cpufreq-stats.txt |    2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> --- linux-4.8-rc5.orig/Documentation/cpu-freq/cpufreq-stats.txt	2016-09-04 23:31:46.000000000 +0200
> >> +++ linux-4.8-rc5/Documentation/cpu-freq/cpufreq-stats.txt	2016-09-08 11:34:34.805606601 +0200
> >> @@ -103,7 +103,7 @@ Config Main Menu
> >>   	Power management options (ACPI, APM)  --->
> >>   		CPU Frequency scaling  --->
> >>   			[*] CPU Frequency scaling
> >> -			<*>   CPU frequency translation statistics
> >> +			[*]   CPU frequency translation statistics
> >>   			[*]     CPU frequency translation statistics details
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> Applied, but please CC PM material to linux-pm too.  That makes it much 
> easier to handle.

OK. MAINTAINERS didn't tell me so, I'll send an update in a minute.

-- 
Jean Delvare
SUSE L3 Support
