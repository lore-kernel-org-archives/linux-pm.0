From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3 2/2] cpufreq: AMD "frequency sensitivity feedback"
 powersave bias for ondemand governor
Date: Wed, 3 Apr 2013 19:30:28 +0200
Message-ID: <20130403173028.GB4716@pd.tnic>
References: <1364926304-1799-1-git-send-email-jacob.shin@amd.com>
 <20130402192352.GC17675@pd.tnic>
 <20130402200337.GA17919@jshin-Toonie>
 <2932884.BNCEuERbdR@skinner.arch.suse.de>
 <20130402210124.GI17675@pd.tnic>
 <20130403165324.GB17919@jshin-Toonie>
 <20130403170456.GA4723@pd.tnic>
 <20130403171738.GC17919@jshin-Toonie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130403171738.GC17919@jshin-Toonie>
Sender: cpufreq-owner@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: Thomas Renninger <trenn@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 03, 2013 at 12:17:38PM -0500, Jacob Shin wrote:
> Writing 0 to powersave_bias or unloading the AMD driver could do that.
>
> When the AMD driver loads, it will give a sane default value to
> powersave_bias to enable it, when it unloads, it will put it back to
> 0.

... and on systems without hw feedback, it will keep powersave_bias to 0
by default, retaining the old behavior.

Yeah, sounds like a plan.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
