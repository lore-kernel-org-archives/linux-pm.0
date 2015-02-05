From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Thu, 05 Feb 2015 16:11:49 +0100
Message-ID: <1746505.56yzpQ04cT@vostro.rjw.lan>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <6147604.f4mimnOd4x@vostro.rjw.lan> <54D2CD76.2030609@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62409 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757299AbbBEOsw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Feb 2015 09:48:52 -0500
In-Reply-To: <54D2CD76.2030609@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On Wednesday, February 04, 2015 05:55:02 PM Saravana Kannan wrote:
> On 02/04/2015 03:20 PM, Rafael J. Wysocki wrote:
> > On Wednesday, February 04, 2015 02:28:55 PM Saravana Kannan wrote:
> >> On 02/03/2015 10:20 PM, Viresh Kumar wrote:
> >>> On 4 February 2015 at 03:58, Saravana Kannan <skannan@codeaurora.org> wrote:
> >>>> Can you explain why we need a fallback list in the first place? Now that we
> >>>> are not destroying and creating policy objects, I don't see any point in the
> >>>> fallback list.
> >>>
> >>> Because we wanted to mark the policy inactive. But as I have introduced another
> >>> field for that now, probably it can be fixed. Will check again on what
> >>> can be done.
> >>
> >> Thanks. That's why I was asking. Now that you have another flag. Also,
> >> you might not even need a flag. You can just check if policy->cpus is
> >> empty (btw, I think we should let that go to empty)
> >
> > So the idea would be to avoid clearig cpufreq_cpu_data during offline
> > tear-down (because we know that the CPU is offline anyway) and then start
> > using the same policy pointer during offline?
> 
> Yeah. We still don't clear the policy->cpus today when the last CPU goes 
> down. But that can be done easily by changing a few "if" conditions and 
> rearranging the hotplug notifier code (I think it's mostly there with 
> this series). Once we clear policy->cpus when all CPUs are offline, we 
> can just use that data to figure out if it's "active" or not.

OK

I'm still concerned about the case when the last policy CPU is physically
going away, in which we do the offline as a preliminary step and then
will go for full CPU device unregistration.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
