From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
Date: Fri, 1 Jun 2018 10:24:33 +0530
Message-ID: <20180601045433.GA17425@in.ibm.com>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Hi Balbir,

Thanks for reviewing the patch!

On Fri, Jun 01, 2018 at 12:51:05AM +1000, Balbir Singh wrote:
> On Thu, May 31, 2018 at 10:15 PM, Gautham R. Shenoy

[..snip..]
> >
> > +static u64 get_snooze_timeout(struct cpuidle_device *dev,
> > +                             struct cpuidle_driver *drv,
> > +                             int index)
> > +{
> > +       int i;
> > +
> > +       if (unlikely(!snooze_timeout_en))
> > +               return default_snooze_timeout;
> > +
> > +       for (i = index + 1; i < drv->state_count; i++) {
> > +               struct cpuidle_state *s = &drv->states[i];
> > +               struct cpuidle_state_usage *su = &dev->states_usage[i];
> > +
> > +               if (s->disabled || su->disable)
> > +                       continue;
> > +
> > +               return s->target_residency * tb_ticks_per_usec;
> 
> Can we ensure this is not prone to overflow?

s->target_residency is an "unsigned int" so can take a maximum value
of UINT_MAX. tb_ticks_per_usec is an "unsigned long" with a value in
the range of 100-1000. The return value is a u64. The product of
s->target_residency and tb_ticks_per_usec should be contained in u64.

Is there a potential case of overflow that I am missing ?

> 
> Otherwise looks good
> 
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

--
Thanks and Regards
gautham.
