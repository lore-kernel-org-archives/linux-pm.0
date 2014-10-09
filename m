From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3] power: of_battery: Initial support for of-based
 battery specification driver.
Date: Thu, 9 Oct 2014 12:44:15 +0200
Message-ID: <20141009104415.GA7699@amd>
References: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
 <1412679518-21499-4-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47490 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaJIKoS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 06:44:18 -0400
Content-Disposition: inline
In-Reply-To: <1412679518-21499-4-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, jenny.tc@intel.com

On Tue 2014-10-07 19:58:38, Jonghwa Lee wrote:
> This driver supports battery specification through the generic interf=
ace of
> power_supply subsystem. All data are parsed from device tree and it e=
xactly
> matches with power_supply_info's content.
>=20
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +++ b/drivers/power/of_battery.c
> @@ -0,0 +1,100 @@
> +/*
> + * OF-based battery specification driver
> + *
> + * This driver supports generic interface to get static battery data=
=2E
> + *
> + * Copyright =A9 2014 Jonghwa Lee <jonghwa3.lee@samsung.com>

I'd replace it with (c).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
