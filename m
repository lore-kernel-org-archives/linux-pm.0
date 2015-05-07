From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 06/20] cpufreq: Create for_each_{in}active_policy()
Date: Fri, 08 May 2015 00:11:34 +0200
Message-ID: <2175643.St6HWqz1AC@vostro.rjw.lan>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <CAKohpokanT+6scDTYotp90GNhyatURQNyjKpkfDKxgU9vhbWqQ@mail.gmail.com> <550C7299.7030308@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53533 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751434AbbEGVqa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 17:46:30 -0400
In-Reply-To: <550C7299.7030308@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On Friday, March 20, 2015 12:18:49 PM Saravana Kannan wrote:
> On 03/19/2015 09:41 PM, Viresh Kumar wrote:
> > On 20 March 2015 at 06:31, Saravana Kannan <skannan@codeaurora.org> wrote:
> >> On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> >
> >>> +static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> >>> +                                         bool active)
> >>> +{
> >>> +       while (1) {
> >>
> >>
> >> I don't like while(1) unless it's really meant to be an infinite loop. I
> >
> > I don't hate it that much, and neither does other parts of kernel :)
> >
> >> think a do while would work here and also be more compact and readable.
> >
> > So you want this:
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index d3f9ce3b94d3..ecbd8c2118c2 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -47,7 +47,7 @@ static inline bool policy_is_inactive(struct
> > cpufreq_policy *policy)
> >   static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> >                                            bool active)
> >   {
> > -       while (1) {
> > +       do {
> >                  if (likely(policy))
> >                          policy = list_next_entry(policy, policy_list);
> >                  else
> > @@ -69,9 +69,9 @@ static struct cpufreq_policy *next_policy(struct
> > cpufreq_policy *policy,
> >                   *      1               0                       policy
> >                   *      1               1                       next
> >                   */
> > -               if (active ^ policy_is_inactive(policy))
> > -                       return policy;
> > -       };
> > +       } while (!(active ^ policy_is_inactive(policy)));
> > +
> > +       return policy;
> >   }
> 
> Yes please!! The other uses like inside a thread seem more reasonable to me.

Viresh, have you ever sent an update of this one?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
