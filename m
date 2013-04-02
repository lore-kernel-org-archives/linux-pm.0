From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tools: cpufreq: Fix cpufreq-info print messages for affected[related]_cpus
Date: Tue, 02 Apr 2013 14:04:04 +0200
Message-ID: <3284856.AI9dTDMm0S@skinner.arch.suse.de>
References: <8c5305cdbe0fb20730e6b28f79a71d36a472a817.1364567091.git.viresh.kumar@linaro.org> <1637142.c6PaEcqfQ4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1637142.c6PaEcqfQ4@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On Friday, March 29, 2013 10:40:38 PM Rafael J. Wysocki wrote:
> On Friday, March 29, 2013 07:56:39 PM Viresh Kumar wrote:
> > Earlier definitions of affected and related cpus were:
> > Related_cpus: CPUs which run at the same hardware frequency.
> > Affected_cpus: CPUs which need to have their frequency coordinated by
> > software.
> > 
> > These definitions were very confusing as they don't communicate the real
> > difference between them.
> > 
> > Following are the new definitions of these variables:
> > Related_cpus: All (Online & Offline) CPUs that run at the same hardware
> > frequency. Affected_cpus: Online CPUs that run at the same hardware
> > frequency.
> > 
> > Above definitions are more consistent with latest cpufreq core code.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Thomas Renninger is maintaining cpupower nowadays (added to CC).  I won't
> get any cpupower changes without his ACK.
> 
> Thanks,
> Rafael
> 
> > ---
> > 
> >  tools/power/cpupower/utils/cpufreq-info.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/power/cpupower/utils/cpufreq-info.c
> > b/tools/power/cpupower/utils/cpufreq-info.c index 28953c9..a81d4ec 100644
> > --- a/tools/power/cpupower/utils/cpufreq-info.c
> > +++ b/tools/power/cpupower/utils/cpufreq-info.c
> > @@ -247,7 +247,7 @@ static void debug_output_one(unsigned int cpu)
> > 
> >  	cpus = cpufreq_get_related_cpus(cpu);
> >  	if (cpus) {
> > 
> > -		printf(_("  CPUs which run at the same hardware frequency: "));
> > +		printf(_("  All (Online & Offline) CPUs that run at the same hardware frequency: "));
This one is not worth changing IMO, in the end it tells the user more or less the same and
as this stuff is translated, I'd not change it.
> >  		while (cpus->next) {
> >  		
> >  			printf("%d ", cpus->cpu);
> >  			cpus = cpus->next;
> > 
> > @@ -258,7 +258,7 @@ static void debug_output_one(unsigned int cpu)
> > 
> >  	cpus = cpufreq_get_affected_cpus(cpu);
> >  	if (cpus) {
> > 
> > -		printf(_("  CPUs which need to have their frequency coordinated by software: "));
> > +		printf(_("  Online CPUs that run at the same hardware frequency: "));
> >  		while (cpus->next) {
I agree that this message is more developer than user oriented,
but cpupower is more for the end-user. So this message is not perfect.

Checking the manpage which should also get adjusted, I found another bug:

       -a --related-cpus
              Determines which CPUs run at the same hardware frequency.

       -a --affected-cpus
              Determines  which  CPUs need to have their frequency coordinated
              by software.

It must be:
       -r --related-cpus

>From what I can see of current code with patch aa77a52764a92216b61a6c8079b5c01937c046cd
all related_cpus users are gone and related-cpus does not have any meaning at all
anymore?
I haven't gone through your latest changes, but will at least give them a test on
a AMD K10 multi socket machine which iirc where using related_cpus.
I try to catch up with latest cpufreq changes as well, but wow... no idea when this
will happen.

For now I would just leave it (cpupower messages/manpage) as it is, there is
nothing critical which must get fixed immediately.

      Thomas
