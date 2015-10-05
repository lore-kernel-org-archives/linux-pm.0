From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / clk: Do not __clk_get passed in clock-references
Date: Mon, 05 Oct 2015 22:54:13 +0200
Message-ID: <7126718.0ZHn4yyKKA@vostro.rjw.lan>
References: <4072102.uMAk2BYxyL@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43042 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750892AbbJEUZo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 16:25:44 -0400
In-Reply-To: <4072102.uMAk2BYxyL@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, October 01, 2015 09:05:09 PM Heiko St=C3=BCbner wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
>=20
> Clock references are on a per-user basis now, so they are not suppose=
d
> to be refcounted by itself anymore. Therefore multiple cascaded get a=
nd
> put calls will fail.
>=20
> When a clock reference gets passed into pm_clk_add_clk we can assume
> that the pm clock handling will take control of the clock reference,
> so after this functions returns the caller should've given up control
> of that handle.
>=20
> So remove the additional call to __clk_get() in __pm_clk_add().
>=20
> The only current user of pm_clk_add_clk is drivers/clk/shmobile/clk-m=
stp.c
> which already follows this paradigm by only getting the clock but not
> puting it after passing the reference into pm_clk_add_clk.
>=20
> In the error case the caller is expected to clean up the clock, as it
> may very well try to do something different if pm_clk_add_clk() fails=
=2E
>=20
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> [add commit-message]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Rafael, Pavel,
>=20
> if that looks acceptable to you, it would be cool if you could ack th=
e
> patch and allow me to put it in front of [0] or alternatively
> provide a stable-branch I could include.

OK

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> [0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip=
=2Egit/commit/?h=3Dv4.4-armsoc/drivers
>=20
>  drivers/base/power/clock_ops.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/cloc=
k_ops.c
> index 652b5a3..6ce7693 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -93,7 +93,7 @@ static int __pm_clk_add(struct device *dev, const c=
har *con_id,
>  			return -ENOMEM;
>  		}
>  	} else {
> -		if (IS_ERR(clk) || !__clk_get(clk)) {
> +		if (IS_ERR(clk)) {
>  			kfree(ce);
>  			return -ENOENT;
>  		}
> @@ -127,7 +127,9 @@ int pm_clk_add(struct device *dev, const char *co=
n_id)
>   * @clk: Clock pointer
>   *
>   * Add the clock to the list of clocks used for the power management=
 of @dev.
> - * It will increment refcount on clock pointer, use clk_put() on it =
when done.
> + * The power-management code will take control of the clock referenc=
e, so
> + * callers should not call clk_put() on @clk after this function suc=
essfully
> + * returned.
>   */
>  int pm_clk_add_clk(struct device *dev, struct clk *clk)
>  {
>=20

