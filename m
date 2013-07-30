From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
Date: Tue, 30 Jul 2013 15:33:44 +0200
Message-ID: <2534583.WCBIj5YC29@vostro.rjw.lan>
References: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com> <ABB05CD9C9F68C46A5CEDC7F15439259FEF32C@039-SN2MPN1-021.039d.mgd.msft.net> <51F7A152.3030602@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:47405 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017Ab3G3NXg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Jul 2013 09:23:36 -0400
In-Reply-To: <51F7A152.3030602@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Wang Dongsheng-B40534 <B40534@freescale.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

On Tuesday, July 30, 2013 01:19:46 PM Daniel Lezcano wrote:
> On 07/30/2013 12:48 PM, Wang Dongsheng-B40534 wrote:
> > 
> > 
> >> -----Original Message-----
> >> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
> >> Sent: Tuesday, July 30, 2013 5:28 PM
> >> To: Wang Dongsheng-B40534
> >> Cc: rjw@sisk.pl; linux-pm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
> >>
> >> On 07/30/2013 08:55 AM, Dongsheng Wang wrote:
> >>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >>>
> >>> After __cpuidle_register_device, the cpu incs are added up, but decs
> >>> are not, thus the module refcount is not match. So the module "exit"
> >>> function can not be executed when we do remove operation. Move
> >>> module_put into __cpuidle_register_device to fix it.
> >>
> >> Sorry, I still don't get it :/
> >>
> >> register->module_get
> >> unregister->module_put
> >>
> >> you change it by:
> >>
> >> register->module_get
> >> register->module_put
> >> unregister->none
> >>
> >> which is wrong.
> >>
> > module_get->set per cpu incs=1
> > module_put->set per cpu decs=1
> > 
> > module_refcount-> incs - decs;
> > 
> > "unregister" usually call in module->exit function. 
> > But if module_refcount is not zero, the module->exit() cannot be executed.
> 
> Ok, IIUC, the refcount is decremented in the unregister function but
> this one is never called because the refcount is not zero.
> 
> Funny, that means the module format was *never* used at all as it does
> not work.
> 
> I am wondering if we shouldn't just remove the module support for
> cpuidle. Rafael ?

That would be the simplest thing to do and possibly the most correct one too,
but I need to double check how inte_idle/ACPI idle interactions depend on that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
