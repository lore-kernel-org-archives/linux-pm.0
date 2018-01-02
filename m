From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Tue, 2 Jan 2018 14:17:23 +0100
Message-ID: <CAPDyKFrdsr=t-Fh+LhJM7dDD+4bLoDG=MhF803ZS6MHUNynyCQ@mail.gmail.com>
References: <1514547423-18965-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0gCnQgRS7aBkQ6LUoNab0_=mMqdqje+YLmJpcusANkfMg@mail.gmail.com>
 <CAPDyKFq_sOvGBkSgVKgzooKke_huNFxOQabk+QiLGFCiP6vvWA@mail.gmail.com> <60600616.To3JVj42o5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <60600616.To3JVj42o5@aspire.rjw.lan>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 January 2018 at 12:43, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, January 2, 2018 12:36:55 PM CET Ulf Hansson wrote:
>> On 30 December 2017 at 01:44, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Fri, Dec 29, 2017 at 12:37 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >> The PM core in the device_prepare() phase, resets the wakeup_path status
>> >> flag to the value of device_may_wakeup(). This means if a ->prepare() or a
>> >> ->suspend() callback for the device would update the device's wakeup
>> >> setting, this doesn't become reflected in the wakeup_path status flag.
>> >>
>> >> In general this isn't a problem, because wakeup settings are not supposed
>> >> to be changed (via for example calling device_set_wakeup_enable()) during
>> >> any system wide suspend/resume phase.  Nevertheless there are some users,
>> >> which can be considered as legacy, that don't conform to this behaviour.
>> >>
>> >> These legacy cases should be corrected, however until that is done, let's
>> >> address the issue from the PM core, by moving the assignment of the
>> >> wakeup_path status flag to the __device_suspend() phase and after the
>> >> ->suspend() callback has been invoked.
>> >>
>> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> ---
>> >>  drivers/base/power/main.c | 4 +++-
>> >>  1 file changed, 3 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> >> index 6e8cc5d..810e5fb 100644
>> >> --- a/drivers/base/power/main.c
>> >> +++ b/drivers/base/power/main.c
>> >> @@ -1620,6 +1620,8 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>> >>   End:
>> >>         if (!error) {
>> >>                 dev->power.is_suspended = true;
>> >> +               if (device_may_wakeup(dev))
>> >> +                       dev->power.wakeup_path = true;
>> >>                 dpm_propagate_to_parent(dev);
>> >>                 dpm_clear_suppliers_direct_complete(dev);
>> >>         }
>> >> @@ -1744,7 +1746,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>> >>
>> >>         device_lock(dev);
>> >>
>> >> -       dev->power.wakeup_path = device_may_wakeup(dev);
>> >> +       dev->power.wakeup_path = false;
>> >
>> > If you did "dev->power.wakeup_path = device_may_wakeup(dev)" in
>> > __device_suspend(), it wouldn't need to be cleared here I guess?
>> >
>>
>> No that doesn't work, because it may override the value of the flag
>> wrongly, in case a child's wakeup_path flag that is set and has been
>> propagated to the parent.
>
> I see, OK.
>
> So it looks like the new driver flag is not really necessary.

Okay, I am fine with that. Please just check the other mail thread,
should we have a helper function that users call to set the flag?

>
> The wakeup_path propagation may be done even later, like at the end of
> __device_suspend_late(), which is fine, because it is not going to be used
> before __device_suspend_noirq() anyway.

I think we need to keep existing code in __device_suspend() as the
flag is used by drivers/ssb/pcihost_wrapper.c, from its ->suspend()
callback. Moreover, I think this is probably useful for other similar
scenarios of drivers dealing with parent devices.

However, adopting __device_suspend_late() to also deal the propagation
of the flag is a good idea.

>
> Then, drivers can set it from their ->suspend and ->suspend_late callbacks.

Yes, that would be great!

Kind regards
Uffe
