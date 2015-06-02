From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] power: reset: gpio-restart: increase priority slightly
Date: Tue, 02 Jun 2015 08:25:50 -0700
Message-ID: <556DCAFE.5050304@roeck-us.net>
References: <4893951.aWdOo6F7tl@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55174 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759283AbbFBPZy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 11:25:54 -0400
In-Reply-To: <4893951.aWdOo6F7tl@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/02/2015 07:48 AM, Heiko St=FCbner wrote:
> gpio-restart uses a priority of 128 and currently most soc-level rest=
art
> mechanisms use the same - with some exceptions even using 192.
> But while the soc-level restarts are provided by the soc itself,
> gpio-restarts will most of the time be board-specfic and be used
> when some special board condition makes the soc-level restart
> only a second choice.
>
> The problem at hand manifested itself on the rk3288-veyron devices.
> While the soc-level restart can sucessfully restart all other rockchi=
p
> boards I have, the veyron devices use an external restart mechanism t=
hat
> seems to not only reset the soc but also some external needed compone=
nts.
>
> With both restart handlers having priority 128 in my tests the soc-sp=
ecific
> variant took precedent in all cases. While it could restart the soc
> sucessfully in all cases, firmware then got an issue when talking to =
an
> external component, resulting in the device being put into recovery m=
ode.
>
> So, give the board-specific restart handler a slight push and move it
> to priority 129 to make it more important than the generic soc-specif=
ic
> restart-handler.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Makes sense.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

