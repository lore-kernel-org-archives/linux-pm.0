From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 2/4] power: add axp20x-battery driver
Date: Tue, 5 Jul 2016 14:43:17 +0200
Message-ID: <20160705144317.4a654376@pluto.restena.lu>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
	<20160701092926.32005-2-icenowy@aosc.xyz>
	<577B44FD.6040404@mailbox.org>
	<112861467708458@web7h.yandex.ru>
Reply-To: bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDCZ5GUK4UNRB2OW525QKGQEUQRUO5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <112861467708458-tvSLaYVQeptuio3avFS2gg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Michael Haas <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>, Wens <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 05 Jul 2016 16:47:38 +0800 Icenowy Zheng wrote:
> I read the datasheet of axp20x, and then found that this driver does
> not support backup RTC battery.
> (But maybe backup battery do not need a driver -- at least on IBM PC
> it has no driver)

A driver is needed to enable/disable the RTC battery charging (unless
uboot does it).
However all the driver can do according to datasheet is configure the
charge voltage/current or disable charging completely.
Monitoring RTC battery is not possible, neither is presence detection.

So driver should just apply configuration it finds in device-tree and
eventually share that information via power supply class.

> And I don't know whether the axp20x has default Li-ion/LiPo battery
> OCV parameter. (axp22x seems to be have a set of default OCV)

It seems to have default OCV parameters as well. With empty RTC
battery OCV values are present.

> You can test this driver on AXP20x. (I think I didn't access to
> AXP22x-specified registers in the power supply code)

Bruno
