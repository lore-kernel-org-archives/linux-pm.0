From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] MAINTAINERS: Add Documentation/cpu-freq/
Date: Wed, 14 Sep 2016 03:02:09 +0200
Message-ID: <2555951.IoaMVhVR3T@vostro.rjw.lan>
References: <20160909130524.581de63d@endymion> <20160909110603.GD18547@vireshk-i7> <20160909130819.3ae5dad5@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62977 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755545AbcINA4C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 20:56:02 -0400
In-Reply-To: <20160909130819.3ae5dad5@endymion>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Friday, September 09, 2016 01:08:19 PM Jean Delvare wrote:
> On Fri, 9 Sep 2016 16:36:03 +0530, Viresh Kumar wrote:
> > On 09-09-16, 13:05, Jean Delvare wrote:
> > > I am told the cpufreq documentation updates should go to the PM list.
> > > 
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > Reported-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  MAINTAINERS |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > --- linux-4.8-rc5.orig/MAINTAINERS	2016-09-09 13:00:13.928338065 +0200
> > > +++ linux-4.8-rc5/MAINTAINERS	2016-09-09 13:00:51.102740802 +0200
> > > @@ -3281,6 +3281,7 @@ L:	linux-pm@vger.kernel.org
> > >  S:	Maintained
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> > >  T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
> > > +F:	Documentation/cpu-freq/
> > >  F:	drivers/cpufreq/
> > >  F:	include/linux/cpufreq.h
> > 
> > Oh, I missed that :(
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> No worry :) Thanks the quick ack.

Applied.

Thanks,
Rafael

