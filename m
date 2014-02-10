From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 1/2] PM / OPP: Allow boost frequency to be looked up
 from device tree
Date: Mon, 10 Feb 2014 08:10:51 +0100
Message-ID: <20140210081051.05da33bd@amdc2363>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
 <1391786342-11812-2-git-send-email-thomas.ab@samsung.com>
 <52F50346.7040707@arm.com>
 <CAJuA9agT4PC6YOmhCwKQ=58qaGEr1qSuhTpX57ro1pEuk++Miw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJuA9agT4PC6YOmhCwKQ=58qaGEr1qSuhTpX57ro1pEuk++Miw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>, Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Thomas, Sudeep

> On Fri, Feb 7, 2014 at 9:31 PM, Sudeep Holla <Sudeep.Holla@arm.com>
> wrote:
> > On 07/02/14 15:19, Thomas Abraham wrote:
> >> From: Thomas Abraham <thomas.ab@samsung.com>
> >>
> >> Commit 6f19efc0 ("cpufreq: Add boost frequency support in core")
> >> adds support for CPU boost mode. This patch adds support for
> >> finding available boost frequencies from device tree and marking
> >> them as usable in boost mode.
> >>
> >> Cc: Nishanth Menon <nm@ti.com>
> >> Cc: Lukasz Majewski <l.majewski@samsung.com>
> >> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> >> ---
> >>  drivers/base/power/opp.c |   34 +++++++++++++++++++++++++++++++++-
> >>  1 file changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> >> index fa41874..b636826 100644
> >> --- a/drivers/base/power/opp.c
> >> +++ b/drivers/base/power/opp.c
> >> @@ -628,7 +628,8 @@ int dev_pm_opp_init_cpufreq_table(struct
> >> device *dev, struct device_opp *dev_opp;
> >>       struct dev_pm_opp *opp;
> >>       struct cpufreq_frequency_table *freq_table;
> >> -     int i = 0;
> >> +     int i = 0, j, len, ret;
> >> +     u32 *boost_freqs = NULL;
> >>
> >>       /* Pretend as if I am an updater */
> >>       mutex_lock(&dev_opp_list_lock);
> >> @@ -650,10 +651,35 @@ int dev_pm_opp_init_cpufreq_table(struct
> >> device *dev, return -ENOMEM;
> >>       }
> >>
> >> +     if (of_find_property(dev->of_node, "boost-frequency", &len))
> >> {
> >> +             if (len == 0 || (len & (sizeof(u32) - 1)) != 0) {
> >> +                     dev_err(dev, "%s: invalid boost
> >> frequency\n", __func__);
> >> +                     ret = -EINVAL;
> >> +                     goto err_boost;
> >> +             }
> >> +
> >> +             boost_freqs = kzalloc(len, GFP_KERNEL);
> >> +             if (!boost_freqs) {
> >> +                     dev_warn(dev, "%s: no memory for boost freq
> >> table\n",
> >> +                                     __func__);
> >> +                     ret = -ENOMEM;
> >> +                     goto err_boost;
> >> +             }
> >> +             of_property_read_u32_array(dev->of_node,
> >> "boost-frequency",
> >> +                     boost_freqs, len / sizeof(u32));
> >> +     }
> >> +
> >>       list_for_each_entry(opp, &dev_opp->opp_list, node) {
> >>               if (opp->available) {
> >>                       freq_table[i].driver_data = i;
> >>                       freq_table[i].frequency = opp->rate / 1000;
> >> +                     for (j = 0; j < len / sizeof(u32) &&
> >> boost_freqs; j++) {
> >> +                             if (boost_freqs[j] ==
> >> freq_table[i].frequency) {
> >> +                                     freq_table[i].driver_data =
> >> +
> >> CPUFREQ_BOOST_FREQ;
> >> +                                     break;
> >> +                             }
> >> +                     }
> >>                       i++;
> >>               }
> >>       }
> > IIRC you had mentioned that the boost-opp was not limited to be a
> > cpufreq, but this change seems to be cpufreq only.
> 
> Yes, but as you have initiated the discussion on extending the OPP
> binding, this has been limited to cpufreq only. If the new OPP library
> has support for listing boost frequency, this can be migrated to the
> new OPP libaray.

I agree here with Thomas. Since we are fixing regression here, we shall
use the existing OPP API. When agreement for the future OPPs format is
in place, we will port the boost OPPs to it.

> 
> Thanks,
> Thomas.
> 
> >
> > Regards,
> > Sudeep
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
