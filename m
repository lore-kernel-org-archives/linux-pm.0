From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: conservative: Fix comment explaining frequency updates
Date: Thu, 24 Nov 2016 02:17:30 +0100
Message-ID: <1598322.M8zmuJxMQN@vostro.rjw.lan>
References: <4986155b-de07-1a4c-186c-71d90b12e75c@semaphore.gr> <20161117034059.GB4894@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61965 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935292AbcKXBJn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 20:09:43 -0500
In-Reply-To: <20161117034059.GB4894@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thursday, November 17, 2016 09:10:59 AM Viresh Kumar wrote:
> On 16-11-16, 21:27, Stratos Karafotis wrote:
> > The original comment about the frequency increase to maximum is wrong.
> > 
> > Both increase and decrease happen at steps.
> > 
> > Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> > ---
> >  -> v2
> > Remove a trailing space
> > 
> >  drivers/cpufreq/cpufreq_conservative.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> > index a48b724..7522ec6 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -55,8 +55,8 @@ static inline unsigned int get_freq_step(struct cs_dbs_tuners *cs_tuners,
> >   * sampling_down_factor, we check, if current idle time is more than 80%
> >   * (default), then we try to decrease frequency
> >   *
> > - * Any frequency increase takes it to the maximum frequency. Frequency reduction
> > - * happens at minimum steps of 5% (default) of maximum frequency
> > + * Frequency updates happen at minimum steps of 5% (default) of maximum
> > + * frequency
> >   */
> >  static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> >  {
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael

