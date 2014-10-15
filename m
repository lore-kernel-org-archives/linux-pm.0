From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 0/7] power_supply: Decrement the device reference counter
Date: Wed, 15 Oct 2014 14:52:13 +0200
Message-ID: <1413377533.26771.16.camel@AMDC1943>
References: <1413290117-13082-1-git-send-email-k.kozlowski@samsung.com>
 <20141015121841.GA26579@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:63294 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbaJOMwS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Oct 2014 08:52:18 -0400
In-reply-to: <20141015121841.GA26579@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On =C5=9Bro, 2014-10-15 at 14:18 +0200, Pavel Machek wrote:
> Hi!
>=20
> > The reference counter of device allocated for power supply was
> > incremented with each call to power_supply_get_by_name() and
> > power_supply_get_by_phandle().
> >=20
> > Add a symmetric 'put' operation so the device could be released aft=
er
> > final put_device() call during supply unregistering.
> >=20
> >=20
> > Rebased on next-20141007 + mine [1] patchset.
> > Tested on Trats2 board (max77693 + charger manager).
> >=20
> > Kindly asking for reviewing/testing other drivers.
>=20
> I'm not sure if we should support power_supply_put(NULL), but
> otherwise the series looks ok to me.
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks for reviewing. I'll remove the non-NULL check and resend with
your ack.

Best regards,
Krzysztof

