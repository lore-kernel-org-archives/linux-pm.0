From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] intel_pstate: Use pr_fmt
Date: Wed, 6 Apr 2016 20:31:12 +0530
Message-ID: <20160406150112.GC16889@vireshk-i7>
References: <cover.1459887986.git.joe@perches.com>
 <710e23a9e0846d1aaa660849321e433b5f5dd4e7.1459887986.git.joe@perches.com>
 <1459892619.7030.2.camel@linux.intel.com>
 <002601d19013$c129de60$437d9b20$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33474 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbcDFPBQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 11:01:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id 184so35477872pff.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 08:01:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <002601d19013$c129de60$437d9b20$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Joe Perches' <joe@perches.com>, 'Len Brown' <lenb@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 06-04-16, 07:51, Doug Smythies wrote:
> On 2016.04.05 02:44 Srinivas Pandruvada wrote:
> > On Tue, 2016-04-05 at 13:28 -0700, Joe Perches wrote:
> >> Prefix the output using the more common kernel style.
> >> 
> >> Signed-off-by: Joe Perches <joe@perches.com>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >> ---
> >>  drivers/cpufreq/intel_pstate.c | 18 ++++++++++--------
> >>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> ...[cut, example left]...
> 
> > -		pr_warn("intel_pstate: Turbo disabled by BIOS or
> > unavailable on processor\n");
> > +		pr_warn("Turbo disabled by BIOS or unavailable on
> > processor\n");
> 
> I do  not understand.
> The common and unique string "intel_pstate" was added on purpose
> so as to provide a way to easily extract the related message from
> an otherwise huge log file.

The first line of the patch does this:

+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

which will automagically add name of the current file (intel_pstate)
before every print message printed using pr_*() helpers.

-- 
viresh
