From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Add Documentation/cpu-freq/
Date: Fri, 9 Sep 2016 13:08:19 +0200
Message-ID: <20160909130819.3ae5dad5@endymion>
References: <20160909130524.581de63d@endymion>
        <20160909110603.GD18547@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58105 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753460AbcIILIW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Sep 2016 07:08:22 -0400
In-Reply-To: <20160909110603.GD18547@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Fri, 9 Sep 2016 16:36:03 +0530, Viresh Kumar wrote:
> On 09-09-16, 13:05, Jean Delvare wrote:
> > I am told the cpufreq documentation updates should go to the PM list.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Reported-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  MAINTAINERS |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- linux-4.8-rc5.orig/MAINTAINERS	2016-09-09 13:00:13.928338065 +0200
> > +++ linux-4.8-rc5/MAINTAINERS	2016-09-09 13:00:51.102740802 +0200
> > @@ -3281,6 +3281,7 @@ L:	linux-pm@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> >  T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
> > +F:	Documentation/cpu-freq/
> >  F:	drivers/cpufreq/
> >  F:	include/linux/cpufreq.h
> 
> Oh, I missed that :(
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

No worry :) Thanks the quick ack.

-- 
Jean Delvare
SUSE L3 Support
