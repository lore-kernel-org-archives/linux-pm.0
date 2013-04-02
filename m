From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] tools: cpufreq: Fix cpufreq-info print messages for affected[related]_cpus
Date: Tue, 2 Apr 2013 18:38:56 +0530
Message-ID: <CAKohpomMdBDHPVEeHsCf5o1ABmc4CboeXsZfvf2_E3deVTdVKg@mail.gmail.com>
References: <8c5305cdbe0fb20730e6b28f79a71d36a472a817.1364567091.git.viresh.kumar@linaro.org>
	<1637142.c6PaEcqfQ4@vostro.rjw.lan>
	<3284856.AI9dTDMm0S@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <3284856.AI9dTDMm0S@skinner.arch.suse.de>
Sender: cpufreq-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On 2 April 2013 17:34, Thomas Renninger <trenn@suse.de> wrote:
> On Friday, March 29, 2013 10:40:38 PM Rafael J. Wysocki wrote:
>> On Friday, March 29, 2013 07:56:39 PM Viresh Kumar wrote:
>> > -           printf(_("  CPUs which run at the same hardware frequency: "));
>> > +           printf(_("  All (Online & Offline) CPUs that run at the same hardware frequency: "));
> This one is not worth changing IMO, in the end it tells the user more or less the same and
> as this stuff is translated, I'd not change it.

Okay.

>> > -           printf(_("  CPUs which need to have their frequency coordinated by software: "));
>> > +           printf(_("  Online CPUs that run at the same hardware frequency: "));
>> >             while (cpus->next) {
> I agree that this message is more developer than user oriented,
> but cpupower is more for the end-user. So this message is not perfect.

> From what I can see of current code with patch aa77a52764a92216b61a6c8079b5c01937c046cd
> all related_cpus users are gone and related-cpus does not have any meaning at all
> anymore?

No, that's wrong. We need to set policy->cpus correctly (with online +
offline cpus) and cpufreq core will take care of setting related_cpus
with everything
from policy->cpus and policy->cpus will be modified to keep only online cpus.

> I haven't gone through your latest changes, but will at least give them a test on
> a AMD K10 multi socket machine which iirc where using related_cpus.
> I try to catch up with latest cpufreq changes as well, but wow... no idea when this
> will happen.

:)

> For now I would just leave it (cpupower messages/manpage) as it is, there is
> nothing critical which must get fixed immediately.

Yes its not really critical but it must be fixed to reflect the right stuff.
