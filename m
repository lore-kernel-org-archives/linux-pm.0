From: Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH V3 2/2] cpufreq: AMD "frequency sensitivity feedback"
 powersave bias for ondemand governor
Date: Wed, 3 Apr 2013 12:17:38 -0500
Message-ID: <20130403171738.GC17919@jshin-Toonie>
References: <1364926304-1799-1-git-send-email-jacob.shin@amd.com>
 <20130402192352.GC17675@pd.tnic>
 <20130402200337.GA17919@jshin-Toonie>
 <2932884.BNCEuERbdR@skinner.arch.suse.de>
 <20130402210124.GI17675@pd.tnic>
 <20130403165324.GB17919@jshin-Toonie>
 <20130403170456.GA4723@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:55472
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762172Ab3DCRRq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 13:17:46 -0400
Content-Disposition: inline
In-Reply-To: <20130403170456.GA4723@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Thomas Renninger <trenn@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

On Wed, Apr 03, 2013 at 07:04:56PM +0200, Borislav Petkov wrote:
> On Wed, Apr 03, 2013 at 11:53:24AM -0500, Jacob Shin wrote:
> > Then Thomas, Boris, would it be acceptable if enable the frequency
> > feedback feature by default with a sane powersave_bias tunable value?
> > And also add proper documentation for both vanila powersave_bias
> > and powersave_bias with AMD frequency sensitivity loaded to
> > Documentation/cpu-freq/ondemand ?
> 
> Yeah, this was what I was proposing, basically. The only question here
> is, would anyone want to disable freq decisions on systems with hw
> feedback? If yes, then you'd need to be able to disable the feedback
> thing, maybe have a magic value for powersave_bias...

Writing 0 to powersave_bias or unloading the AMD driver could do that.

When the AMD driver loads, it will give a sane default value to
powersave_bias to enable it, when it unloads, it will put it back to 0

> 
> Thanks.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Sent from a fat crate under my desk. Formatting is fine.
> --
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

