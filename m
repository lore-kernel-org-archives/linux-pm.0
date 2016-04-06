From: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v9 2/4] gadget: Support for the usb charger framework
Date: Wed, 6 Apr 2016 13:49:04 +0000
Message-ID: <AM4PR04MB2130E03385128C1CD22553E7899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <13c2f4fb71958bf9a5527acbed8b8b60dc569656.1459494744.git.baolin.wang@linaro.org>
 <20160406071956.GA21101@shlinux2.ap.freescale.net>
 <CAMz4kuJkf0Q1JKdc5W8EcDBvr6MccTcdZa-Pse_Z4pFwySTSDA@mail.gmail.com>
 <AM4PR04MB2130F58AA1018FFD367C89E0899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <871t6j2ai2.fsf@intel.com>
 <AM4PR04MB213054CF3F597CE2E6FE976F899F0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <87oa9m28x0.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87oa9m28x0.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Wednesday, April 06, 2016 8:56 PM
> To: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>; Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>; Peter
> Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Sebastian Reichel
> <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; David
> Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>; Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>;
> Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>; r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; Yoshihiro
> Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>; Lee Jones
> <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>; Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Charles Keepax
> <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>; patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org;
> Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>;
> device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org; LKML <linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Subject: RE: [PATCH v9 2/4] gadget: Support for the usb charger framework
> 
> 
> Hi,
> 
> Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org> writes:
> >> >> On 6 April 2016 at 15:19, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> >> > On Fri, Apr 01, 2016 at 03:21:50PM +0800, Baolin Wang wrote:
> >> >> >>
> >> >> >> @@ -563,6 +564,8 @@ struct usb_gadget_ops {
> >> >> >>       struct usb_ep *(*match_ep)(struct usb_gadget *,
> >> >> >>                       struct usb_endpoint_descriptor *,
> >> >> >>                       struct usb_ss_ep_comp_descriptor *);
> >> >> >> +     /* get the charger type */
> >> >> >> +     enum usb_charger_type (*get_charger_type)(struct
> >> >> >> + usb_gadget *);
> >> >> >>  };
> >> >> >
> >> >> > Since we already have get_charger_type callback at usb_charger
> >> >> > structure, why we still need this API at usb_gadget_ops?
> >> >>
> >> >> In case some users want to get charger type at gadget level.
> >> >>
> >> > Why gadget needs to know charger type? I also don't catch the
> >> > intent of
> >>
> >> because some gadgets need to call usb_gadget_vbus_draw(), although
> >> for that they need power in mA rather.
> >
> > In below change of usb_gadget_vbus_draw(), already can get charger
> > type via usb_charger_get_type().
> >
> > static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget,
> > unsigned mA)  {
> > +       enum usb_charger_type type;
> > +
> > +       if (gadget->charger) {
> > +               type = usb_charger_get_type(gadget->charger);
> > +               usb_charger_set_cur_limit_by_type(gadget->charger, type,
> mA);
> > +       }
> > +
> >         if (!gadget->ops->vbus_draw)
> >                 return -EOPNOTSUPP;
> >         return gadget->ops->vbus_draw(gadget, mA);
> >
> > Could you detail in what situation gadget->ops-> get_charger_type() is
> used?
> 
> isn't it right there in the code ? Isn't usb_gadget_vbus_draw() calling
> it ? What did I miss here ?

Well, that's true, so my real meaning is why gadget need get charger type
via another new api gadget->ops->get_charger_type().
 
> 
> >> > This api, as my understanding, gadget only need report gadget state
> >> changes.
> >> > All information required for usb charger is charger type and gadget
> >> state.
> >>
> >> you're making an assumption about how the HW is laid out which might
> >> not be true.
> >>
> >
> > What other information you refer to here? Or what I am not aware of?
> 
> what I'm trying to say is that you're assuming gadgets don't need to know
> anything other than charger type and gadget state (suspended, resume,
> enumerated, default state, addressed, etc), but that might not be true for
> all UDCs. You can't make that assumption that charger type and gadget
> state is enough. The real question is what do we need *now*, but still
> keep in mind that what we need *now* might be valid 2 years from now, so
> API needs to be a little flexible.

Get your point, flexible, I just thought create an api without any user
for existing case/spec, wouldn't it be better to let the real user add it
later when it's needed.

> 
> cheers
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
