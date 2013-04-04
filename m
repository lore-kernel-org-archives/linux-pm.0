From: Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH V4 2/2] cpufreq: AMD "frequency sensitivity feedback"
 powersave bias for ondemand governor
Date: Thu, 4 Apr 2013 15:29:47 -0500
Message-ID: <20130404202947.GB24479@jshin-Toonie>
References: <1365092344-11310-1-git-send-email-jacob.shin@amd.com>
 <1365092344-11310-3-git-send-email-jacob.shin@amd.com>
 <20130404192323.GI32271@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130404192323.GI32271@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Renninger <trenn@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 04, 2013 at 09:23:23PM +0200, Borislav Petkov wrote:
> On Thu, Apr 04, 2013 at 11:19:04AM -0500, Jacob Shin wrote:
> > Future AMD processors, starting with Family 16h, can provide software
> > with feedback on how the workload may respond to frequency change --
> > memory-bound workloads will not benefit from higher frequency, where
> > as compute-bound workloads will. This patch enables this "frequency
> > sensitivity feedback" to aid the ondemand governor to make better
> > frequency change decisions by hooking into the powersave bias.
> > 
> > Signed-off-by: Jacob Shin <jacob.shin@amd.com>
> 
> Looks good to me.
> 
> Acked-by: Borislav Petkov <bp@suse.de>

Rafael, got acks from both Boris and Thomas. Please commit to
linux-next when you get the chance.

Thanks,

-Jacob

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Sent from a fat crate under my desk. Formatting is fine.
> --
> 

