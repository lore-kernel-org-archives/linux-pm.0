From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] clk: readd refcounting for struct clk instances
Date: Mon, 28 Sep 2015 21:36:31 +0200
Message-ID: <1541157.TohRuBEVWh@diego>
References: <6257096.h7pub3XnDQ@diego> <20150928184640.GM23081@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:41446 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbbI1Tgk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 15:36:40 -0400
In-Reply-To: <20150928184640.GM23081@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@baylibre.com, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Caesar Wang <wxt@rock-chips.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Am Montag, 28. September 2015, 11:46:40 schrieb Stephen Boyd:
> On 09/23, Heiko St=FCbner wrote:
> > ---
> >=20
> > While it may be nice to do the actual handling of the clock referen=
ces
> > only in the calling code, in this current use case it would create
> > a big additional overhead.
> >=20
> > It looks like this so called synchronous reset on power-domain stat=
e-
> > changes, requiring device clocks to be turned on, is not that uncom=
mon
> > or rockchip-specific.
> > For this Kevin requested that we read the clocks from the actual co=
nsumer
> > devices and not double-list them in the power-domain node as well.
> >=20
> > So when expecting pm_clk_add_clk() to work, the current powerdomain=
 code
> >=20
> > can simply do when adding a device to a domain in=20
rockchip_pd_attach_dev():
> >     while ((clk =3D of_clk_get(dev->of_node, i++)) && !IS_ERR(clk))=
 {
> > =09
> > 	dev_dbg(dev, "adding clock '%pC' to list of PM clocks\n", clk);
> > 	error =3D pm_clk_add_clk(dev, clk);
> > 	clk_put(clk);
> > =09
> >     }
> >=20
> > The clock gets handed off to the generic pm clock handling and thus
> > clk_put in there.
> >=20
> >=20
> > On the other hand when only the rockchip power-domain code is expec=
ted
> > to get and put the clock, we would require a lot of new overhead, a=
s now
> > the code would also need to track which devices got added to what
> > domain and also all clock-references until the device gets detached
> > again. So this would essentially duplicate a big part of what the
> > genpd-code does (per-domain device-list and per-device clock-list).
> >=20
> > As this seems to be not uncommon, future powerdomain drivers
> > might need that too and would also need to duplicate that handling.
> >=20
> > When allowing multiple __clk_get and __clk_put calls on the other
> > hand, the overhead for the regular case comes down to one atomic_in=
c,
> > atomic_sub_and_test and the function call to the new separate relea=
se
> > function ;-) .
>=20
> Why are we doing of_clk_get(), pm_clk_add_clk(), and then
> clk_put()?  Just drop that clk_put() in the caller and remove the
> __clk_get() inside pm_clk_add_clk() and everything works the
> same. This patch does most of that, except it doesn't handle the
> error path where we would need to throw a clk_put().

I guess that was my try to keep all the gets and puts together, but als=
o an=20
instance of not seeing the forest for the trees. Looking at your soluti=
on=20
below does look actually really cool.

Would still be nice if the genpd people would speak up on their prefere=
nce. In=20
the worst case I'll try hunting them down at ELCE next week :-)

I guess for the error path, one could just set the notion that if=20
pm_clk_add_clk returns sucessfully it has taken over the clock referenc=
e=20
completely and in the error case the caller should clean up?


>=20
> Really, that snippet of code that loops over a device's clocks
> and adds them to a pm domain is an example of duplicate code that
> should go into some common layer like the PM clock stuff. Then we
> don't have any kind of situation where we're passing struct clk
> pointers off to other layers of code and this "problem" doesn't
> exist.
>=20
> ----8<----
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/cloc=
k_ops.c
> index acef9f9f759a..529a03e8282c 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -95,7 +95,7 @@ static int __pm_clk_add(struct device *dev, const c=
har
> *con_id, return -ENOMEM;
>                 }
>         } else {
> -               if (IS_ERR(clk) || !__clk_get(clk)) {
> +               if (IS_ERR(clk)) {
>                         kfree(ce);
>                         return -ENOENT;
>                 }
> @@ -129,7 +129,7 @@ int pm_clk_add(struct device *dev, const char *co=
n_id)
>   * @clk: Clock pointer
>   *
>   * Add the clock to the list of clocks used for the power management=
 of
> @dev. - * It will increment refcount on clock pointer, use clk_put() =
on it
> when done. + * Callers should not call clk_put() on @clk after callin=
g this
> function. */
>  int pm_clk_add_clk(struct device *dev, struct clk *clk)
>  {

