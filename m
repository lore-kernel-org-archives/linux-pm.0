From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 30 Mar 2016 17:19:50 +0800
Message-ID: <20160330091950.GA3195@peterchendt>
References: <cover.1458822334.git.baolin.wang@linaro.org>
 <20160325070937.GA22398@peterchendt>
 <CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
 <20160328071351.GC3302@peterchendt>
 <20160329172314.GZ2350@sirena.org.uk>
 <20160330020501.GA2740@peterchendt>
 <CAMz4kuKkSt0xj_1jGC9d_yVpEX0krBB_M6x1C3ZR9bDGabQeLQ@mail.gmail.com>
 <20160330074229.GB2740@peterchendt>
 <CAMz4kuJ2SprO0QE4sYg0ZgmO1KvfQjaJ_APusCSbK8DG4i5ueQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33218 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbcC3JUE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 05:20:04 -0400
Content-Disposition: inline
In-Reply-To: <CAMz4kuJ2SprO0QE4sYg0ZgmO1KvfQjaJ_APusCSbK8DG4i5ueQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Mar 30, 2016 at 04:40:31PM +0800, Baolin Wang wrote:
> >> > - Third, since composite driver covers 500mA (and more for CDP) after set
> >> > configuration and 2mA after suspend, and vbus handler covers connect
> >> > and disconnect. I can't see any reasons we need to notify gadget state
> >> > for power driver, do we really need to have usb_charger_plug_by_gadget?
> >>
> >> In some solutions, gadget does not negotiate with the current. They
> >> just send out one signal to power driver to set the current when the
> >> gadget state is changed (plugin or not). So we need to check the
> >> charger state by the gadget state to notify the charger IC to set
> >> current.
> >>
> >
> > Would you give some examples?
> 
> OK. I explain it in detail. Now charger detection can be from gadget
> itself or PMIC, and we focus on gadget detection. Charger IC (charger
> driver) is separate with gadget.
> When the usb cable is plugin, we need to report the plugin event to
> charger driver to set current after setting configuration for gadget.
> The usb charger is responsible for reporting plugin event to charger
> driver. But how usb charger get the plugin event? It can get the
> plugin event from gadget state (if the gadget state is more than
> 'USB_STATE_ATTACHED', it means one cable plugin). So we need notify
> gadget state to usb charger.
> 

Ok, I see, it only changes current limit at function usb_gadget_vbus_draw
in your patch 2/4. Then, we need to make sure usb_charger_set_cur_limit_by_type
is called before calling usb_gadget_set_state(gadget, USB_STATE_CONFIGURED).

It seems you have not implemented usb_charger_plug_by_gadget in your patch set.

-- 
Best Regards,
Peter Chen
