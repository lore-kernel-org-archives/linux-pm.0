From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] phy: core: Move runtime PM reference counting to
 the parent device
Date: Thu, 21 Dec 2017 11:50:54 +0100
Message-ID: <CAPDyKFokLc5cQW7RWAsdCY4h_Q8BgHKGQwHVUFX68fWF=BE6_g@mail.gmail.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
 <1513778960-10073-2-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0iwR1MnBokL29_QmUw2F6fgNNwzP7WLhtAL37MkMLd1xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iwR1MnBokL29_QmUw2F6fgNNwzP7WLhtAL37MkMLd1xQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21 December 2017 at 02:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Dec 20, 2017 at 3:09 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The runtime PM deployment in the phy core is deployed using the phy core
>> device, which is created by the phy core and assigned as a child device of
>> the phy provider device.
>>
>> The behaviour around the runtime PM deployment cause some issues during
>> system suspend, in cases when the phy provider device is put into a low
>> power state via a call to the pm_runtime_force_suspend() helper, as is the
>> case for a Renesas SoC, which has its phy provider device attached to the
>> generic PM domain.
>>
>> In more detail, the problem in this case is that pm_runtime_force_suspend()
>> expects the child device of the provider device, which is the phy core
>> device, to be runtime suspended, else a WARN splat will be printed
>> (correctly) when runtime PM gets re-enabled at system resume.
>
> So we are now trying to work around issues with
> pm_runtime_force_suspend().  Lovely. :-/

Yes, we have to, as pm_runtime_force_suspend() is widely deployed. Or
are you saying we should just ignore all issues related to it?

Of course, if we had something that could replace
pm_runtime_force_suspend(), that would be great, but there isn't.

>
>> In the current scenario, even if a call to phy_power_off() triggers it to
>> invoke pm_runtime_put() during system suspend, the phy core device doesn't
>> get runtime suspended, because this is prevented in the system suspend
>> phases by the PM core.
>>
>> To solve this problem, let's move the runtime PM deployment from the phy
>> core device to the phy provider device, as this provides the similar
>> behaviour. Changing this makes it redundant to enable runtime PM for the
>> phy core device, so let's avoid doing that.
>
> I'm not really convinced that this approach is the best one to be honest.
>
> I'll have a deeper look at this in the next few days, stay tuned.

There is different ways to solve this, for sure. I picked this one,
because I think it's the most trivial thing to do, and it shouldn't
cause any other problems.

I think any other option would involve assigning ->suspend|resume()
callbacks to the phy core device, but that's fine too, if you prefer
that.

Also, I have considered how to deal with wakeup paths for phys,
although I didn't want to post changes as a part of this series, but
maybe I should to give a more complete picture?

Kind regards
Uffe
