From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Thu, 7 Apr 2016 11:03:50 +0800
Message-ID: <20160407030350.GB10672@shlinux2.ap.freescale.net>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org>
 <20160406071956.GA21101@shlinux2.ap.freescale.net>
 <CAMz4kuJkf0Q1JKdc5W8EcDBvr6MccTcdZa-Pse_Z4pFwySTSDA@mail.gmail.com>
 <AM4PR04MB2130F58AA1018FFD367C89E0899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <871t6j2ai2.fsf@intel.com>
 <AM4PR04MB213054CF3F597CE2E6FE976F899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <87oa9m28x0.fsf@intel.com>
 <AM4PR04MB2130E03385128C1CD22553E7899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <87egai261g.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35097 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbcDGDKh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 23:10:37 -0400
Content-Disposition: inline
In-Reply-To: <87egai261g.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Jun Li <jun.li@nxp.com>, Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "device-mainlining@lists.linuxfoundation.org" <device-mainlining@lists.linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Apr 06, 2016 at 04:58:03PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Jun Li <jun.li@nxp.com> writes:
> >> >> >> > Since we already have get_charger_type callback at usb_charger
> >> >> >> > structure, why we still need this API at usb_gadget_ops?
> >> >> >>
> >> >> >> In case some users want to get charger type at gadget level.
> >> >> >>
> >> >> > Why gadget needs to know charger type? I also don't catch the
> >> >> > intent of
> >> >>
> >> >> because some gadgets need to call usb_gadget_vbus_draw(), although
> >> >> for that they need power in mA rather.
> >> >
> >> > In below change of usb_gadget_vbus_draw(), already can get charger
> >> > type via usb_charger_get_type().
> >> >
> >> > static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget,
> >> > unsigned mA)  {
> >> > +       enum usb_charger_type type;
> >> > +
> >> > +       if (gadget->charger) {
> >> > +               type = usb_charger_get_type(gadget->charger);
> >> > +               usb_charger_set_cur_limit_by_type(gadget->charger, type,
> >> mA);
> >> > +       }
> >> > +
> >> >         if (!gadget->ops->vbus_draw)
> >> >                 return -EOPNOTSUPP;
> >> >         return gadget->ops->vbus_draw(gadget, mA);
> >> >
> >> > Could you detail in what situation gadget->ops-> get_charger_type() is
> >> used?
> >> 
> >> isn't it right there in the code ? Isn't usb_gadget_vbus_draw() calling
> >> it ? What did I miss here ?
> >
> > Well, that's true, so my real meaning is why gadget need get charger type
> > via another new api gadget->ops->get_charger_type().
> 
> because of semantics. usb_gadget_vbus_draw() is *only* supposed to
> connect a load across vbus and gnd so some battery can be charged. Also,
> we need to abstract away this ->get_charger_type() operation because it
> might be different for each UDC.

In this patch set, there are two ->get_charger_type in below two
structures, as my understanding, get_charger_type at struct usb_charger
can be implemented at UDC drivers; But I don't see necessary we
need to implement get_charger_type for usb_gadget_ops at UDC drivers
again. What do you think?

struct usb_gadget_ops {
	....
	        struct usb_ep *(*match_ep)(struct usb_gadget *,
	+       /* get the charger type */
	+       enum usb_charger_type (*get_charger_type)(struct usb_gadget *);
};

struct usb_charger {
	...
+       /* user can get charger type by implementing this callback */
+       enum usb_charger_type   (*get_charger_type)(struct usb_charger
		*);
}
> 
> $subject has a fragility, however: It's assuming that we should always
> call ->get_charger_type() before ->vbus_draw(), but that's a good
> default, I'd say.
> 

-- 

Best Regards,
Peter Chen
