From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] clk: readd refcounting for struct clk instances [when used in pm_clk_add_clk(), genpd]
Date: Wed, 16 Sep 2015 11:18:05 +0200
Message-ID: <9158634.8HmHM8CzF6@diego>
References: <1878691.zhVxsBBBGg@diego> <20150916003931.GK23081@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150916003931.GK23081@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

Am Dienstag, 15. September 2015, 17:39:31 schrieb Stephen Boyd:
> On 09/15, Heiko St=FCbner wrote:
> > With the split into struct clk and struct clk_core, clocks lost the
> > ability for nested __clk_get clkdev calls. While it stays possible =
to
> > call __clk_get, the first call to (__)clk_put will clear the struct=
 clk,
> > making subsequent clk_put calls run into a NULL pointer dereference=
=2E
> >=20
> > One prime example of this sits in the generic power domain code, wh=
ere it
> > is possible to add the clocks both by name and by passing in a stru=
ct clk
> > via pm_clk_add_clk(). __pm_clk_add() in turn then calls __clk_get t=
o
> > increase the refcount, so that the original code can put the clock =
again.
> >=20
> > A possible call-path looks like
> > clk =3D of_clk_get();
> > pm_clk_add_clk(dev, clk);
> > clk_put(clk);
> >=20
> > with pm_clk_add_clk() =3D> __pm_clk_add() then calling __clk_get on=
 the clk
> > and later clk_put when the pm clock list gets destroyed, thus creat=
ing
> > a NULL pointer deref, as the struct clk doesn't exist anymore.
> >=20
> > So add a separate refcounting for struct clk instances and only cle=
an up
> > once the refcount reaches zero.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > I stumbled upon this while applying the new Rockchip power-domain d=
river,
> > but I guess the underlying issue is universal and probably present =
since
> > the original clk/clk_core split, so this probably counts as fix.
>=20
> Ok. The fix makes sense, but I wonder why we do this. Perhaps we
> should stop exporting __clk_get() and __clk_put() to everything
> that uses clkdev in the kernel. They're called per-user clks for
> a reason. There's one user. Now we have two users of the same
> struct clk instance, so we have to refcount it too? I hope the
> shared clk instance isn't being used to set rates in two pieces
> of code.
>=20
> And this only affects pm_clk_add_clk() callers right? So the only
> caller in the kernel (drivers/clk/shmobile/clk-mstp.c) doesn't
> seem to have this problem right now because it never calls
> clk_put() on the pointer it passes to pm_clk_add_clk().

As written above, I stumbled upon this with the new Rockchip power-doma=
in=20
driver [0] which calls pm_clk_add_clk in its rockchip_pd_attach_dev() f=
unction


[0] http://www.spinics.net/lists/kernel/msg2070432.html

> So what if we did the patch below? This would rely on callers not
> calling clk_put() before calling pm_clk_remove() or
> pm_clk_destroy(), and the life cycle would be clear, but the
> sharing is still there. Or we could say that after a clk is given
> to pm_clk_add_clk() that the caller shouldn't touch it anymore,
> like shmobile is doing right now. Then there's nothing to do
> besides remove the extra __clk_get() call in the pm layer.

I guess that is the call of the genpd people (Rafael and Pavel accordin=
g to=20
get_maintainers.pl). I'm very much fine with adapting the Rockchip powe=
r-
domain driver as needed to new handling paradigms.

Personally I'd prefer your solution of making the initial handler do al=
l the=20
getting and putting, as doing clk_get in the power-domain driver and re=
lying=20
on clk_put being done in the genpd core feels awkward. Although that so=
lution=20
would mean, the calling driver would also need to keep track of clocks,=
 while=20
the current rockchip power-domain driver can just call clk_put after ha=
nding=20
the clock of to genpd.


>=20
> > @@ -2606,6 +2607,18 @@ static void __clk_release(struct kref *ref)
> >=20
> >  	kfree(core);
> > =20
> >  }
> >=20
> > +static void __clk_release(struct kref *ref)
> > +{
> > +	struct clk *clk =3D container_of(ref, struct clk, ref);
> > +
> > +	hlist_del(&clk->clks_node);
> > +	if ((clk->min_rate > clk->core->req_rate ||
> > +	     clk->max_rate < clk->core->req_rate))
>=20
> Why did we grow a pair of parenthesis?

Remnant of me moving code around, sorry about that.
As it seems you prefer a different solution, I'll refrain from sending =
a fixed=20
version, till we decide which way to go :-).


>=20
> > +		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
> > +
> > +	kfree(clk);
> > +}
> > +
> >=20
> >  /*
> > =20
> >   * Empty clk_ops for unregistered clocks. These are used temporari=
ly
> >   * after clk_unregister() was called on a clock and until last clo=
ck
>=20
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/cloc=
k_ops.c
> index 652b5a367c1f..ef62bb3d7b26 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -31,6 +31,7 @@ struct pm_clock_entry {
>  	char *con_id;
>  	struct clk *clk;
>  	enum pce_status status;
> +	bool needs_clk_put;
>  };
>=20
>  /**
> @@ -59,8 +60,10 @@ static inline void __pm_clk_enable(struct device *=
dev,
> struct pm_clock_entry *ce */
>  static void pm_clk_acquire(struct device *dev, struct pm_clock_entry=
 *ce)
>  {
> -	if (!ce->clk)
> +	if (!ce->clk) {
>  		ce->clk =3D clk_get(dev, ce->con_id);
> +		ce->needs_clk_put =3D true;
> +	}
>  	if (IS_ERR(ce->clk)) {
>  		ce->status =3D PCE_STATUS_ERROR;
>  	} else {
> @@ -93,7 +96,7 @@ static int __pm_clk_add(struct device *dev, const c=
har
> *con_id, return -ENOMEM;
>  		}
>  	} else {
> -		if (IS_ERR(clk) || !__clk_get(clk)) {
> +		if (IS_ERR(clk)) {
>  			kfree(ce);
>  			return -ENOENT;
>  		}
> @@ -149,7 +152,8 @@ static void __pm_clk_remove(struct pm_clock_entry=
 *ce)
>=20
>  		if (ce->status >=3D PCE_STATUS_ACQUIRED) {
>  			clk_unprepare(ce->clk);
> -			clk_put(ce->clk);
> +			if (ce->needs_clk_put)
> +				clk_put(ce->clk);
>  		}
>  	}
