From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/9] thermal: rockchip: handle the power sequence for
 tsadc controller
Date: Thu, 28 Apr 2016 08:04:33 -0700
Message-ID: <20160428150432.GA20009@localhost.localdomain>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
 <1460950562-20652-5-git-send-email-wxt@rock-chips.com>
 <20160427234818.GB2590@localhost.localdomain>
 <57216C65.5040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36645 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbcD1PEh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 11:04:37 -0400
Content-Disposition: inline
In-Reply-To: <57216C65.5040501@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Apr 28, 2016 at 09:50:29AM +0800, Caesar Wang wrote:
>=20
>=20
> =E5=9C=A8 2016=E5=B9=B404=E6=9C=8828=E6=97=A5 07:48, Eduardo Valentin=
 =E5=86=99=E9=81=93:
> >On Mon, Apr 18, 2016 at 11:35:56AM +0800, Caesar Wang wrote:
> >>+		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_ON);
> >>+		mdelay(10);
> >>+		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_OFF);
> >>+		udelay(100); /* The spec note says at least 15 us */
> >>+		regmap_write(grf, GRF_SARADC_TESTBIT, GRF_SARADC_TESTBIT_ON);
> >>+		regmap_write(grf, GRF_TSADC_TESTBIT_H, GRF_TSADC_TESTBIT_H_ON);
> >>+		udelay(200); /* The spec note says at least 90 us */
> >Does it make sense to use usleep_range() instead?
>=20
> I think so in the past, but I'm digging into the the udelay/usleep fo=
r
> kernel.

What do you mean by in the past? timekeeping doc still recommends the
range 10us to 20ms for usleep_range()

>=20
> In general,
>=20
> udelay < 10us ~100us
> mdelay > 1m, <1000ms/HZ
> usleep_range(min,max) > 100us, <20ms

even here, your udelays could be replaced by usleep_range().

Any particular reason you believe spining is better than sleeping in
your case?

> msleep > 20ms,  < 1000ms
>=20
> So the udelay is suit for tsadc power sequence.
> ---
>=20
>=20
> Also,  we have used the mdelay(10), so it doesn't matter if use the u=
delay.
> After all the udelay is stable than the usleep_range.

What do you mean udelay is stable than usleep_range? usleep_range will
give the opportunity to the scheduler to coalesce wakeups. udelay is a
busyloop spin. Besides, I am not sure the current situation, but
busylooping may be affected by cpu frequency.

>=20
> -Caesar
>=20
> >1.9.1
> >
> >
> >
> >
> >--=20
> >Thanks,
> >Caesar
