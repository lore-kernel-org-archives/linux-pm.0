From: Chen-Yu Tsai <wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v3 3/9] power: supply: axp20x_usb_power:
 allow disabling input current limiting
Date: Mon, 25 Mar 2019 10:45:01 +0800
Message-ID: <CAGb2v66bh0UXcjScHRL5U4f_mBALDN6Vckt=9sjziz09qygcxA@mail.gmail.com>
References: <20190321084850.20769-1-wens@kernel.org> <20190321084850.20769-4-wens@kernel.org>
 <20190321093012.kg72voxs5kw5xtzu@flea>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBOUB4HSAKGQEW2J3RYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190321093012.kg72voxs5kw5xtzu@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 21, 2019 at 5:30 PM Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi,
>
> The rest of the series is
> Acked-by: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>
> On Thu, Mar 21, 2019 at 04:48:44PM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> >
> > The AXP PMICs allow the user to disable current limiting on the VBUS
> > input. While read-out of this setting was already supported by the
> > driver, it did not allow the user to configure the PMIC to disable
> > current limiting.
> >
> > Add support for this.
> >
> > Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>
> Do we really want to do that though? That could have some pretty bad
> consequences.

If I understand the manual correctly, the PMIC has two mode of operation
with regards to VBUS. Normal operation means the PMIC will try to limit
the current draw to maintain VBUS above the set V_hold (defaults to 4.4V).
This is in addition to the current limit set in this patch.

The other mode of operation is bypass, where it ignores the voltage limit.
Not sure if it also ignores the current limit, but probably not. In any
case we don't support this mode in the driver.

So I can think of a few cases where this might be bad:

1. High current draw results in excessive voltage drop and heating over
   line / traces due to insufficient conductor area. This should be covered
   by the voltage holding mechanism.

2. Over taxing the external power supply. This should also result in some
   voltage drop for simple power bricks. Advanced ones would either have
   current limiting or over-current protection.

What bad consequences are you thinking of?

ChenYu
