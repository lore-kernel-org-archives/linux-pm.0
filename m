From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-stats: Minor documentation fix
Date: Fri, 9 Sep 2016 16:35:24 +0530
Message-ID: <20160909110524.GC18547@vireshk-i7>
References: <20160908123943.6141564f@endymion>
 <20160908112006.GS27345@vireshk-i7>
 <e538cefd-dc59-e135-d07e-4c3e1603a8e5@intel.com>
 <20160909130359.0e5c8d2e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33047 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbcIILF2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 07:05:28 -0400
Received: by mail-pf0-f170.google.com with SMTP id g202so28660909pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 04:05:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160909130359.0e5c8d2e@endymion>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>

On 09-09-16, 13:03, Jean Delvare wrote:
> On Fri, 9 Sep 2016 00:38:59 +0200, Rafael J. Wysocki wrote:
> > On 9/8/2016 1:20 PM, Viresh Kumar wrote:
> > > On 08-09-16, 12:39, Jean Delvare wrote:
> > >> The cpufreq-stats code can no longer be built as a module, so it now
> > >> appears with square brackets in menuconfig.
> > >>
> > >> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > >> Fixes: 1aefc75b2449 ("cpufreq: stats: Make the stats code non-modular")
> > >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > >> ---
> > >>   Documentation/cpu-freq/cpufreq-stats.txt |    2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> --- linux-4.8-rc5.orig/Documentation/cpu-freq/cpufreq-stats.txt	2016-09-04 23:31:46.000000000 +0200
> > >> +++ linux-4.8-rc5/Documentation/cpu-freq/cpufreq-stats.txt	2016-09-08 11:34:34.805606601 +0200
> > >> @@ -103,7 +103,7 @@ Config Main Menu
> > >>   	Power management options (ACPI, APM)  --->
> > >>   		CPU Frequency scaling  --->
> > >>   			[*] CPU Frequency scaling
> > >> -			<*>   CPU frequency translation statistics
> > >> +			[*]   CPU frequency translation statistics
> > >>   			[*]     CPU frequency translation statistics details
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > Applied, but please CC PM material to linux-pm too.  That makes it much 
> > easier to handle.
> 
> OK. MAINTAINERS didn't tell me so, I'll send an update in a minute.

You sure about it?

CPU FREQUENCY DRIVERS
M:      "Rafael J. Wysocki" <rjw@rjwysocki.net>
M:      Viresh Kumar <viresh.kumar@linaro.org>
L:      linux-pm@vger.kernel.org
S:      Maintained
T:      git
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
T:      git git://git.linaro.org/people/vireshk/linux.git (For ARM
Updates)
F:      drivers/cpufreq/
F:      include/linux/cpufreq.h

Also, its already applied. Don't resend it.

-- 
viresh
