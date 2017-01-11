From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Resend][PATCH 2/3] PM / core / docs: Convert sleep states API
 document to reST
Date: Wed, 11 Jan 2017 03:58:00 +0100
Message-ID: <CAJZ5v0iLxPw5f3VMk3nk-HHd8qOroToKYaJg0-JskfnpmbkTBg@mail.gmail.com>
References: <17467778.bsRBpnPicc@aspire.rjw.lan> <3016250.oKr138Ysat@aspire.rjw.lan>
 <20170110014102.GA23533@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35856 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760951AbdAKC6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 21:58:01 -0500
In-Reply-To: <20170110014102.GA23533@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

On Tue, Jan 10, 2017 at 2:41 AM, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Rafael,
>
> I've perused devices.rst up until section "Entering System Suspend"
> so far, about half of the document.  Here are my comments, I'll read
> the remainder of the document later.
>
>
> On Fri, Jan 06, 2017 at 02:41:38AM +0100, Rafael J. Wysocki wrote:
>> +.. |struct| replace:: :c:type:`struct`
> [...]
>> +|struct| :c:type:`dev_pm_ops` defined in :file:`include/linux/pm.h`.
>
> I don't know what the proper markup for structs is, but this renders
> differently than what the DRM folks use, e.g.:
>
> :c:type:`struct drm_driver <drm_driver>`

This simply doesn't generate the cross references correctly AFAICS.

>
>> +++ linux-pm/Documentation/driver-api/pm/index.rst
>> @@ -0,0 +1,15 @@
>> +=======================
>> +Device Power Management
>> +=======================
>> +
>> +.. toctree::
>> +
>> +   types
>> +   devices
>
> I'd invert the order of these two, seems better didactically to have
> the prose introduction in devices.rst first, then the gory details
> in types.rst.

Well, there was a particular reason why I did it this way, but I can't
recall what it was ATM. :-)

>
>> +There also is a deprecated "old" or "legacy" interface for power management
>> +operations available at least for some subsystems.  This approach does not use
>> +|struct| :c:type`dev_pm_ops` objects and it is suitable only for implementing
>
> ~~~~~~~~~~~~~~~~~~~^
>                    missing colon, renders incorrectly
>
>
>> +:c:member`power.wakeup` field is a pointer to an object of type
>
> ~~~~~~~~~~~~^
>             missing colon, renders incorrectly
>

Yup, thanks!

>> +Call Sequence Guarantees
>> +------------------------
>> +
>> +To ensure that bridges and similar links needing to talk to a device are
>> +available when the device is suspended or resumed, the device hierarchy is
>> +walked in a bottom-up order to suspend devices.  A top-down order is
>> +used to resume those devices.
>> +
>> +The ordering of the device hierarchy is defined by the order in which devices
>> +get registered:  a child can never be registered, probed or resumed before
>> +its parent; and can't be removed or suspended after that parent.
>> +
>> +The policy is that the device hierarchy should match hardware bus topology.
>> +[Or at least the control bus, for devices which use multiple busses.]
>> +In particular, this means that a device registration may fail if the parent of
>> +the device is suspending (i.e. has been chosen by the PM core as the next
>> +device to suspend) or has already suspended, as well as after all of the other
>> +devices have been suspended.  Device drivers must be prepared to cope with such
>> +situations.
>
> Hm, "device registration may fail if the parent of the device is
> suspending".  Why would a device be registered at all during the
> system sleep process?  My understanding was that new devices are not
> *allowed* to be registered during system sleep.

Registration alone should not be problematic, but binding is.

> We sort of enforce that
> in the driver core since 4.5 in so far as newly registered devices are
> not bound until after ->complete.  (So there's no hard rule that
> registering new devices is forbidden, but binding drivers is postponed.)

Right.

> Confusingly, device_resume() contains a comment suggesting that
> registering new children is already allowed from ->resume.
>
>         /*
>          * This is a fib.  But we'll allow new children to be added below
>          * a resumed device, even if the device hasn't been completed yet.
>          */
>         dev->power.is_prepared = false;
>

That comment is actually correct.  From the core's perspective, it is
fine to register a child device under a resumed parent.

> My understanding was also that the purpose of the ->prepare hook is to
> disable recognition and registration of new child devices, e.g. by
> disabling hotplug interrupts.  For this reason, the device hierarchy is
> walked top-down during ->prepare, the opposite of the following ->suspend
> hooks.

That's right and I think there some text about this in the doc.

> Since ->complete mirrors ->prepare and is supposed to undo
> its effects (i.e. re-enable registration of children), it walks the
> device hierarchy bottom-up (which again is the opposite direction of
> the preceding ->resume hooks.  That's what Alan Stern told me in a mailing
> list conversation last year, it might be worth to add the information to
> this paragraph.

Yeah, it might.

Thanks,
Rafael
