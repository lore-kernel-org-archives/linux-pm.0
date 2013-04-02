From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V3 2/2] cpufreq: AMD "frequency sensitivity feedback" powersave bias for ondemand governor
Date: Tue, 02 Apr 2013 22:51:51 +0200
Message-ID: <2932884.BNCEuERbdR@skinner.arch.suse.de>
References: <1364926304-1799-1-git-send-email-jacob.shin@amd.com> <20130402192352.GC17675@pd.tnic> <20130402200337.GA17919@jshin-Toonie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130402200337.GA17919@jshin-Toonie>
Sender: cpufreq-owner@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 02, 2013 03:03:37 PM Jacob Shin wrote:
> On Tue, Apr 02, 2013 at 09:23:52PM +0200, Borislav Petkov wrote:
> > On Tue, Apr 02, 2013 at 01:11:44PM -0500, Jacob Shin wrote:
> > > Future AMD processors, starting with Family 16h, can provide software
> > > with feedback on how the workload may respond to frequency change --
> > > memory-bound workloads will not benefit from higher frequency, where
> > > as compute-bound workloads will. This patch enables this "frequency
> > > sensitivity feedback" to aid the ondemand governor to make better
> > > frequency change decisions by hooking into the powersave bias.

I had a quick look at the specification of these registers.
So this seem to be designed and stay very cpufreq specific and other kernel
parts probably won't make use of it.
...
> > > +
> > > +	/* this workload is not CPU bound, so choose a lower freq */
> > > +	if (sensitivity < od_tuners->powersave_bias) {
> > 
> > Ok, I still didn't get an answer to that: don't we want to use this
> > feature by default, even without looking at ->powersave_bias? I mean,
> > with feedback from the hardware, we kinda know better than the user, no?
> 
> Well, so this powersave_bias also works as a tunable knob.
> 
> From ondemand side, if /sys/../ondemand/powersave_bias is 0, then we
> (AMD sensitivity) don't get called and you get the default ondemand
> behavior.
> 
> Like existing powersave_bias, users can tune the value to whatever
> they want, to get a specturum of less to more aggressive power savings
> vs performance.
I understand powersave_bias code to only be able to do a more
aggressive power saving way:
If you pass 900, a frequency of 90%  (for example 900MHz instead of 1000MHz)
of the one ondemand typically would choose is taken.
powersave_bias values above 1000 (take higher frequencies than the ondemand
would take) are not allowed.

powersave_bias is undocumented in Documentation/cpu-freq/...
I guess its use-case is for people who want to get some percent more
power savings out of their laptop and do not care of the one or other
percent performance.
In fact I would like to get rid of this extra code and I expect nobody would 
miss it.
I might miss a configuration tool where someone went through the code,
documented things and allows users to set powersave_bias values through
some /etc/* config files.
If so, please point me to it.

What your patch misses are some hints how and when to use this at all.
What value should a user write to powersave_bias tunable to activate your 
stuff?
I guess it's also for laptop users to get some percent more battery out of 
their platform and this with an even higher performance rate?
Server guys do not care for some percent of power, but they do care for
some percent of performance.

> I thought tunable would be more flexible .. out in the field or what
> not .. no?
Yep, if you want anyone to make use of this, it should better get embedded
in more general, at least general ondemand code.

       Thomas

