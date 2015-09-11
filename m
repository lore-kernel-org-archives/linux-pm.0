From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Fri, 11 Sep 2015 23:30:42 +0200
Message-ID: <2418240.peTGggLtDn@vostro.rjw.lan>
References: <001401d0e691$302127b0$90637710$@net> <20150908024014.GD26760@linux> <55F33D07.5090107@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53637 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751696AbbIKVCs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 17:02:48 -0400
In-Reply-To: <55F33D07.5090107@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, linux-pm@vger.kernel.org

On Friday, September 11, 2015 01:43:51 PM Saravana Kannan wrote:
> Sorry about the late reply and not helping out earlier. Didn't check 
> this email account for sometime.
> 
> On 09/07/2015 07:40 PM, Viresh Kumar wrote:
> > On 07-09-15, 15:32, Rafael J. Wysocki wrote:
> >> First, if policy->cpu is offline, the policy will be inactive to my eyes, so
> >> we don't need the second check.
> >
> > Hmm, or maybe just drop the first check.
> >
> >> But if the policy is active (and policy->cpu is online), it will not generally
> >> fail for an offline CPU.
> >
> > Right.
> >
> >> So, if the policy applies to more than 1 CPU, you
> >> can use any of them to manipulate it, even if one of them is offline as long
> >> as there are any online CPUs in the set.
> >
> > Right.
> >
> >> This isn't entirely consistent.  We should either fail store() for any offline
> >> CPU
> >
> > At that point we have no idea of the CPU for which the sysfs operation
> > is called. And so we have to go ahead without failing, if policy is
> > active.
> >
> >> or make the changes for offline CPUs to.
> >
> > What does that mean? Most of the stuff we do is for the policy, rather
> > than per-cpu. And if there is per-cpu stuff, then we *only* should be
> > doing that for the online ones.
> >
> > Not sure if I understood what you meant here. :(
> >
> >> And in the particular case of
> >> the governor, I'm wondering what will be the problem with changing last_governor
> >> for an inactive policy?
> >
> > I don't think we should be adding special cases for updating sysfs
> > attributes of an inactive policy. Its not just about the last_governor
> > thing, but other sysfs attributes as well.
> >
> 
> The way I see it, having the cpufreq policy control sysfs "bits" under 
> every CPU directory is what's causing some semantic confusion/inconsistency.
> 
> Every single node under a cpufreq folder is for policy control and not 
> CPU control. But by putting the policy control bits under the cpuX 
> directory, we give the wrong semantic impression that it's a per CPU 
> attribute when it's really per-policy.
> 
> Ideally (in terms of semantics) we would have put all the policy control 
> bits in a per policy directory under 
> /sys/devices/system/cpu/cpufreq/policyX/ where X would/could be the tied 
> to the first CPU in related CPUs -- so that it's easy to correlate and 
> also to avoid having the policy numbering being different depending on 
> the order in which CPUs get hotplugged.
> 
> But we can't go about breaking userspace ABI by removing the cpufreq 
> directories out of the cpu directories just because of the semantic 
> confusion.
> 
> Well, we COULD still put the policy directories under cpu/cpufreq/ and 
> then make every cpuX/cpufreq directory a symlink to the actual policy 
> directory. But that is not going to help with this specific 
> issue/discussion.

It isn't, but it'd be a good change in my view.

> Having said all that, I still think that stores to all these sysfs files 
> should work. I'm not saying it's a trivial change (like setting a 
> governor's polling time, etc would need some checks to cache the value 
> and not start a timer immediately, etc), but I think it's a more 
> consistent and user friendly API.

I agree.

It also is backwards compatible with scripts that walk the cpufreq directories
for all CPUs without checking the online attribute and expect things to work.

> If the user wants to set a min CPU freq, why should they care if the CPU 
> is online at that very instant? It gets especially painful if you have a 
> thermal daemon that's plugging in/out CPUs while the user or a script is 
> trying to set the parameters.

You mean putting them offline/online I suppose?

Thanks,
Rafael

