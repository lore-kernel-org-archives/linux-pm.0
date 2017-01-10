From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [Resend][PATCH 2/3] PM / core / docs: Convert sleep states API
 document to reST
Date: Tue, 10 Jan 2017 02:41:02 +0100
Message-ID: <20170110014102.GA23533@wunner.de>
References: <17467778.bsRBpnPicc@aspire.rjw.lan>
 <3016250.oKr138Ysat@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3016250.oKr138Ysat@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

I've perused devices.rst up until section "Entering System Suspend"
so far, about half of the document.  Here are my comments, I'll read
the remainder of the document later.


On Fri, Jan 06, 2017 at 02:41:38AM +0100, Rafael J. Wysocki wrote:
> +.. |struct| replace:: :c:type:`struct`
[...]
> +|struct| :c:type:`dev_pm_ops` defined in :file:`include/linux/pm.h`.

I don't know what the proper markup for structs is, but this renders
differently than what the DRM folks use, e.g.:

:c:type:`struct drm_driver <drm_driver>`


> +++ linux-pm/Documentation/driver-api/pm/index.rst
> @@ -0,0 +1,15 @@
> +=======================
> +Device Power Management
> +=======================
> +
> +.. toctree::
> +
> +   types
> +   devices

I'd invert the order of these two, seems better didactically to have
the prose introduction in devices.rst first, then the gory details
in types.rst.


> +There also is a deprecated "old" or "legacy" interface for power management
> +operations available at least for some subsystems.  This approach does not use
> +|struct| :c:type`dev_pm_ops` objects and it is suitable only for implementing

~~~~~~~~~~~~~~~~~~~^
                   missing colon, renders incorrectly


> +:c:member`power.wakeup` field is a pointer to an object of type

~~~~~~~~~~~~^
            missing colon, renders incorrectly


> +Call Sequence Guarantees
> +------------------------
> +
> +To ensure that bridges and similar links needing to talk to a device are
> +available when the device is suspended or resumed, the device hierarchy is
> +walked in a bottom-up order to suspend devices.  A top-down order is
> +used to resume those devices.
> +
> +The ordering of the device hierarchy is defined by the order in which devices
> +get registered:  a child can never be registered, probed or resumed before
> +its parent; and can't be removed or suspended after that parent.
> +
> +The policy is that the device hierarchy should match hardware bus topology.
> +[Or at least the control bus, for devices which use multiple busses.]
> +In particular, this means that a device registration may fail if the parent of
> +the device is suspending (i.e. has been chosen by the PM core as the next
> +device to suspend) or has already suspended, as well as after all of the other
> +devices have been suspended.  Device drivers must be prepared to cope with such
> +situations.

Hm, "device registration may fail if the parent of the device is
suspending".  Why would a device be registered at all during the
system sleep process?  My understanding was that new devices are not
*allowed* to be registered during system sleep.  We sort of enforce that
in the driver core since 4.5 in so far as newly registered devices are
not bound until after ->complete.  (So there's no hard rule that
registering new devices is forbidden, but binding drivers is postponed.)

Confusingly, device_resume() contains a comment suggesting that
registering new children is already allowed from ->resume.

        /*
         * This is a fib.  But we'll allow new children to be added below
         * a resumed device, even if the device hasn't been completed yet.
         */
        dev->power.is_prepared = false;

My understanding was also that the purpose of the ->prepare hook is to
disable recognition and registration of new child devices, e.g. by
disabling hotplug interrupts.  For this reason, the device hierarchy is
walked top-down during ->prepare, the opposite of the following ->suspend
hooks.  Since ->complete mirrors ->prepare and is supposed to undo
its effects (i.e. re-enable registration of children), it walks the
device hierarchy bottom-up (which again is the opposite direction of
the preceding ->resume hooks.  That's what Alan Stern told me in a mailing
list conversation last year, it might be worth to add the information to
this paragraph.

Thanks,

Lukas
