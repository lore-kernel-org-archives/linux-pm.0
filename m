From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Revert "cpufreq: pcc-cpufreq: update default value of
 cpuinfo_transition_latency"
Date: Fri, 22 Jul 2016 16:30:42 -0700
Message-ID: <20160722233042.GI3122@ubuntu>
References: <20160722151411.GB11711@suselix.suse.de>
 <3431802.ZZWypmTthK@vostro.rjw.lan>
 <20160722212852.GE3122@ubuntu>
 <3860863.MLaNBM27lJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3860863.MLaNBM27lJ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andreas Herrmann <aherrmann@suse.com>, Jacob Tanenbaum <jtanenba@redhat.com>, stable@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-07-16, 23:46, Rafael J. Wysocki wrote:
> On Friday, July 22, 2016 02:28:52 PM Viresh Kumar wrote:
> > On 22-07-16, 23:31, Rafael J. Wysocki wrote:
> > > > cpufreq.c
> > > > 
> > > > 	if (policy->governor->max_transition_latency &&
> > > > 	    policy->cpuinfo.transition_latency >
> > > > 	    policy->governor->max_transition_latency) {
> > > > 
> > > > - And this check will always fail, unless max_transition_latency is zero.
> > > 
> > > Why would it fail?  If governor->max_transition_latency is non-zero, but less
> > > than UNIT_MAX, the condition checked will be true to my eyes.
> > 
> > Bad wording. Sorry.
> > 
> > I meant, this 'if' check will always succeed (as you also noted), and
> > so we will always get the error message reported in this patch.
> 
> Not always, but for drivers setting cpuinfo.transition_latency to CPUFREQ_ETERNAL.

So the drivers which have set their transition_latency to
CPUFREQ_ETERNAL, can't use ondemand governor unless
governor->max_transition_latency is set to 0 from userspace.

What should be done about this patch then ? It broke in late 2015.

-- 
viresh
