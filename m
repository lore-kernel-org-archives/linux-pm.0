From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2 0/4] PM / Domains: Fix race conditions during boot
Date: Fri, 03 Oct 2014 08:10:51 -0700
Message-ID: <7hvbo1qjd0.fsf@deeprootsystems.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
	<7h38b6rm2l.fsf@deeprootsystems.com>
	<CAPDyKFqteXGe0nfZMDcM2v1Z_Q_e+=0t2KD3MjPEJjN6+EzG+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:48414 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964AbaJCPKy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Oct 2014 11:10:54 -0400
In-Reply-To: <CAPDyKFqteXGe0nfZMDcM2v1Z_Q_e+=0t2KD3MjPEJjN6+EzG+g@mail.gmail.com>
	(Ulf Hansson's message of "Fri, 3 Oct 2014 11:47:37 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 3 October 2014 03:14, Kevin Hilman <khilman@kernel.org> wrote:
>> Ulf, Rafael,
>>
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>>> When there are more than one device in a PM domain these will obviously
>>> be probed at different times. Depending on timing and the implemented
>>> support for runtime PM in a driver/subsystem, genpd may be advised to
>>> power off a PM domain after a successful probe sequence.
>>>
>>> Ideally we should have relied on the driver/subsystem, through runtime
>>> PM, to bring their device's PM domain into powered state prior doing
>>> probing if such requirement exist.
>>
>> I think I've stumbled on a related problem, or maybe the same one.
>>
>> Even if platform-specific init code has initialized a device with
>> pm_runtime_set_active(), it seems that the genpd domain can still
>> power off before before all of its devices are probed.
>>
>> This is because pm_genpd_poweroff() requires there to be a driver
>> when it's checking if a device is pm_runtime_suspended() which will not
>> be the case if the driver has not been probed yet.
>>
>> Consider this case: There are several devices in the domain that haven't
>> been probed yet (dev->driver == NULL), but have been marked with
>> pm_runtime_set_active() + _get_noresume(), so pm_runtime_suspended() == false.
>
> I haven't seen this kind of set up before. Are you invoking
> pm_runtime_enable() here as well?

Yes: _set_active(), _get_noresume() and _enable().

> I am not sure pm_runtime_get_noresume() is a good idea, since that
> will prevent the device from going inactive - even after the driver
> has probed it. 

That's the goal.  The experiment I'm doing is the equivalent of a
_get_sync() in ->probe and a _put() in ->remove.

> Unless the driver do pm_runtime_put_sync twice of
> course. :-)
>
> On the other hand, if you have done pm_runtime_enable() your certainly
> need to prevent the device some going inactive...

Exactly.

>>
>> Then, one of devices is in the domain is probed, and during the probe it
>> does a _get_sync(), sets some stuff up, and then does _put_sync().
>> After the probe, because of the _put_sync(), the genpd
>> ->runtime_suspend() will be triggered, causing it to attempt a
>> _genpd_poweroff().  Since the rest of the devices in the domain haven't
>> (yet) been probed, their dev->driver pointers are all still NULL, so the
>> pm_runtime_suspended() check will not be attempted for them.
>>
>> The result is that the genpd will poweroff after the first device is
>> probed, but before the others have had a chance to probe, which is not
>> exactly desired behavior for a genpd that has been initialized as
>> powered on.
>>
>> With the hack below[1], I'm able to avoid that problem, but am not
>> completely sure yet if this is safe in general.
>>
>> Rafael, do you remember why that check for dev->driver is needed?
>> Without digging deeper (which I'll do tomorrow), seems to me that
>> checking pm_runtime_suspended() on devices without drivers is a
>> reasonable thing to do since they can be initailzed by platform code
>> before they are probed.   If you think this is OK, I'll cook up a real
>> patch with a changelog.
>>
>> Ulf, I'm not sure if this is the same problem you're having, but do you
>> think this would solve your problem if the drivers are properly
>> initialized?
>
> Unfortunately no.
>
> I am using the DT initialization path so all my devices aren't being
> added to the PM domain before drivers starts to probe them.
>
> Instead they are added when each device gets probed, thus the PM
> domain can still power off between devices being probed.

OK

Kevin
