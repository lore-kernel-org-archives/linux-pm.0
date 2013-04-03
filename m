From: Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH V3 2/2] cpufreq: AMD "frequency sensitivity feedback"
 powersave bias for ondemand governor
Date: Wed, 3 Apr 2013 11:53:24 -0500
Message-ID: <20130403165324.GB17919@jshin-Toonie>
References: <1364926304-1799-1-git-send-email-jacob.shin@amd.com>
 <20130402192352.GC17675@pd.tnic>
 <20130402200337.GA17919@jshin-Toonie>
 <2932884.BNCEuERbdR@skinner.arch.suse.de>
 <20130402210124.GI17675@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:2563 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761939Ab3DCQx3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 12:53:29 -0400
Content-Disposition: inline
In-Reply-To: <20130402210124.GI17675@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Thomas Renninger <trenn@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

On Tue, Apr 02, 2013 at 11:01:24PM +0200, Borislav Petkov wrote:
> On Tue, Apr 02, 2013 at 10:51:51PM +0200, Thomas Renninger wrote:
> > powersave_bias is undocumented in Documentation/cpu-freq/...
> > I guess its use-case is for people who want to get some percent more
> > power savings out of their laptop and do not care of the one or other
> > percent performance.
> > In fact I would like to get rid of this extra code and I expect nobody would 
> > miss it.
> > I might miss a configuration tool where someone went through the code,
> > documented things and allows users to set powersave_bias values through
> > some /etc/* config files.
> > Yep, if you want anyone to make use of this, it should better get
> > embedded in more general, at least general ondemand code.
> 
> Yeah, it all sounds like we want to enable this by default on systems
> which support it. Maybe with an off-switch for people who want plain
> ondemand decisions.
> 
> The remaining systems with ripped out powersave_bias would get plain
> ondemand governor decisions. Provided, of course, nobody uses
> powersave_bias and the functionality doesn't make any sense anyway.

Rafael, any thoughts on removing powersave_bias altogether ?

If we remove it, then is it acceptable to add an alternate callback/
handler registration to ondemand governor to account for hardware
feedback ?

Or, if we don't want to remove powersave_bias,

Then Thomas, Boris, would it be acceptable if enable the frequency
feedback feature by default with a sane powersave_bias tunable value ?
And also add proper documentation for both vanila powersave_bias and
powersave_bias with AMD frequency sensitivity loaded to
Documentation/cpu-freq/ondemand ?

> 
> Thanks.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Sent from a fat crate under my desk. Formatting is fine.
> --
> 

