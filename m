From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 30 Mar 2016 10:05:01 +0800
Message-ID: <20160330020501.GA2740@peterchendt>
References: <cover.1458822334.git.baolin.wang@linaro.org>
 <20160325070937.GA22398@peterchendt>
 <CAMz4kuJYBg4eortA35Dhr4-jPVhLzu9XhjpOcu0hDWq6FV09mw@mail.gmail.com>
 <20160328071351.GC3302@peterchendt>
 <20160329172314.GZ2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32775 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbcC3CFO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 22:05:14 -0400
Content-Disposition: inline
In-Reply-To: <20160329172314.GZ2350@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Mar 29, 2016 at 10:23:14AM -0700, Mark Brown wrote:
> On Mon, Mar 28, 2016 at 03:13:51PM +0800, Peter Chen wrote:
> > On Mon, Mar 28, 2016 at 02:51:40PM +0800, Baolin Wang wrote:
> 
> > > > I am afraid I still not find the user (udc driver) for this framework, I would
> > > > like to see how udc driver block the enumeration until the charger detection
> > > > has finished, or am I missing something?
> 
> > > It is not for udc driver but for power users who want to negotiate
> > > with USB subsystem.
> 
> > Then, where is the code the test user to decide what kinds of USB charger
> > (SDP, CDP, DCP) is connecting now?
> 
> Even without detection of CDP and DCP we have configurability within SDP
> - there's the 2.5mA suspended limit, the 100mA default limit and the
> higher 500mA limit which can be negotiated.

Well, things may be a little complicated.

- First, how to design get_charger_type for each udc driver?
Since the charger detection process affects dp/dm signal, it can't be done
during the enumeration or after that. So, the detection process can be only
done after vbus has detected and before udc pull up dp.

Then, when the get_charger_type do real charger detection? My suggestion is,
if the charger type is unknown, we do real one, else, we just return the
stored type value.

- Second, When to notify charger IC to charger:
For SDP and CDP, it needs to notify charger IC after set configuration
has finished.
For DCP (and ACA, I am not sure), can notify charger IC after charger
detection has finished or later.

So, when we get charger is present, we need to notify charger IC at once
for DCP (and ACA); But for SDP and CDP, we need to let the gadget
composite core to notify charger IC after set configuration has finished,
like the patch 2/4 does.

- Third, since composite driver covers 500mA (and more for CDP) after set
configuration and 2mA after suspend, and vbus handler covers connect
and disconnect. I can't see any reasons we need to notify gadget state
for power driver, do we really need to have usb_charger_plug_by_gadget?

-- 
Best Regards,
eter Chen
