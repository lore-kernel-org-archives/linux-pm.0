From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Wed, 6 Apr 2016 12:51:44 +0000
Message-ID: <AM4PR04MB213054CF3F597CE2E6FE976F899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org>
 <20160406071956.GA21101@shlinux2.ap.freescale.net>
 <CAMz4kuJkf0Q1JKdc5W8EcDBvr6MccTcdZa-Pse_Z4pFwySTSDA@mail.gmail.com>
 <AM4PR04MB2130F58AA1018FFD367C89E0899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <871t6j2ai2.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db3on0055.outbound.protection.outlook.com ([157.55.234.55]:4958
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751954AbcDFMvt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 08:51:49 -0400
In-Reply-To: <871t6j2ai2.fsf@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Peter Chen <hzpeterchen@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@kernel.org]
> Sent: Wednesday, April 06, 2016 8:22 PM
> To: Jun Li <jun.li@nxp.com>; Baolin Wang <baolin.wang@linaro.org>; Peter
> Chen <hzpeterchen@gmail.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>; Sebastian Reichel
> <sre@kernel.org>; Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>; David
> Woodhouse <dwmw2@infradead.org>; Peter Chen <peter.chen@freescale.com>;
> Alan Stern <stern@rowland.harvard.edu>; r.baldyga@samsung.com; Yoshihiro
> Shimoda <yoshihiro.shimoda.uh@renesas.com>; Lee Jones
> <lee.jones@linaro.org>; Mark Brown <broonie@kernel.org>; Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com>; patches@opensource.wolfsonmicro.com;
> Linux PM list <linux-pm@vger.kernel.org>; USB <linux-usb@vger.kernel.org>;
> device-mainlining@lists.linuxfoundation.org; LKML <linux-
> kernel@vger.kernel.org>
> Subject: RE: [PATCH v9 2/4] gadget: Support for the usb charger framework
> 
> 
> Hi,
> 
> Jun Li <jun.li@nxp.com> writes:
> >> -----Original Message-----
> >> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
> >> owner@vger.kernel.org] On Behalf Of Baolin Wang
> >> Sent: Wednesday, April 06, 2016 6:47 PM
> >> To: Peter Chen <hzpeterchen@gmail.com>
> >> Cc: Felipe Balbi <balbi@kernel.org>; Greg KH
> >> <gregkh@linuxfoundation.org>; Sebastian Reichel <sre@kernel.org>;
> >> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>; David Woodhouse
> >> <dwmw2@infradead.org>; Peter Chen <peter.chen@freescale.com>; Alan
> >> Stern <stern@rowland.harvard.edu>; r.baldyga@samsung.com; Yoshihiro
> >> Shimoda <yoshihiro.shimoda.uh@renesas.com>; Lee Jones
> >> <lee.jones@linaro.org>; Mark Brown <broonie@kernel.org>; Charles
> >> Keepax <ckeepax@opensource.wolfsonmicro.com>;
> >> patches@opensource.wolfsonmicro.com;
> >> Linux PM list <linux-pm@vger.kernel.org>; USB
> >> <linux-usb@vger.kernel.org>;
> >> device-mainlining@lists.linuxfoundation.org; LKML <linux-
> >> kernel@vger.kernel.org>
> >> Subject: Re: [PATCH v9 2/4] gadget: Support for the usb charger
> >> framework
> >>
> >> On 6 April 2016 at 15:19, Peter Chen <hzpeterchen@gmail.com> wrote:
> >> > On Fri, Apr 01, 2016 at 03:21:50PM +0800, Baolin Wang wrote:
> >> >>
> >> >> @@ -563,6 +564,8 @@ struct usb_gadget_ops {
> >> >>       struct usb_ep *(*match_ep)(struct usb_gadget *,
> >> >>                       struct usb_endpoint_descriptor *,
> >> >>                       struct usb_ss_ep_comp_descriptor *);
> >> >> +     /* get the charger type */
> >> >> +     enum usb_charger_type (*get_charger_type)(struct usb_gadget
> >> >> + *);
> >> >>  };
> >> >
> >> > Since we already have get_charger_type callback at usb_charger
> >> > structure, why we still need this API at usb_gadget_ops?
> >>
> >> In case some users want to get charger type at gadget level.
> >>
> > Why gadget needs to know charger type? I also don't catch the intent
> > of
> 
> because some gadgets need to call usb_gadget_vbus_draw(), although for
> that they need power in mA rather.

In below change of usb_gadget_vbus_draw(), already can get charger type
via usb_charger_get_type().

static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
+       enum usb_charger_type type;
+
+       if (gadget->charger) {
+               type = usb_charger_get_type(gadget->charger);
+               usb_charger_set_cur_limit_by_type(gadget->charger, type, mA);
+       }
+
        if (!gadget->ops->vbus_draw)
                return -EOPNOTSUPP;
        return gadget->ops->vbus_draw(gadget, mA);

Could you detail in what situation gadget->ops-> get_charger_type() is used?

> 
> > This api, as my understanding, gadget only need report gadget state
> changes.
> > All information required for usb charger is charger type and gadget
> state.
> 
> you're making an assumption about how the HW is laid out which might not
> be true.
> 

What other information you refer to here? Or what I am not aware of?

Thanks.
Li Jun  

> --
> balbi
