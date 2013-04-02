From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3 2/2] cpufreq: AMD "frequency sensitivity feedback"
 powersave bias for ondemand governor
Date: Tue, 2 Apr 2013 23:01:24 +0200
Message-ID: <20130402210124.GI17675@pd.tnic>
References: <1364926304-1799-1-git-send-email-jacob.shin@amd.com>
 <20130402192352.GC17675@pd.tnic>
 <20130402200337.GA17919@jshin-Toonie>
 <2932884.BNCEuERbdR@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2932884.BNCEuERbdR@skinner.arch.suse.de>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jacob Shin <jacob.shin@amd.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 02, 2013 at 10:51:51PM +0200, Thomas Renninger wrote:
> Yep, if you want anyone to make use of this, it should better get
> embedded in more general, at least general ondemand code.

Yeah, it all sounds like we want to enable this by default on systems
which support it. Maybe with an off-switch for people who want plain
ondemand decisions.

The remaining systems with ripped out powersave_bias would get plain
ondemand governor decisions. Provided, of course, nobody uses
powersave_bias and the functionality doesn't make any sense anyway.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
