From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 4/8] klist: implement klist_prev()
Date: Tue, 28 Jul 2015 08:47:55 +0100
Message-ID: <20150728074755.GR21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438009443-55317-5-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Jul 2015, Andy Shevchenko wrote:

> klist_prev() gets the previous element in the list. It is useful to t=
raverse
> through the list in reverse order, for example, to provide LIFO (last=
 in first
> out) variant of access.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/klist.h |  1 +
>  lib/klist.c           | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)

Applied, thanks.  Pull request to follow.

> diff --git a/include/linux/klist.h b/include/linux/klist.h
> index 61e5b72..953f283 100644
> --- a/include/linux/klist.h
> +++ b/include/linux/klist.h
> @@ -63,6 +63,7 @@ extern void klist_iter_init(struct klist *k, struct=
 klist_iter *i);
>  extern void klist_iter_init_node(struct klist *k, struct klist_iter =
*i,
>  				 struct klist_node *n);
>  extern void klist_iter_exit(struct klist_iter *i);
> +extern struct klist_node *klist_prev(struct klist_iter *i);
>  extern struct klist_node *klist_next(struct klist_iter *i);
> =20
>  #endif
> diff --git a/lib/klist.c b/lib/klist.c
> index 89b485a..d74cf7a 100644
> --- a/lib/klist.c
> +++ b/lib/klist.c
> @@ -324,6 +324,47 @@ static struct klist_node *to_klist_node(struct l=
ist_head *n)
>  }
> =20
>  /**
> + * klist_prev - Ante up prev node in list.
> + * @i: Iterator structure.
> + *
> + * First grab list lock. Decrement the reference count of the previo=
us
> + * node, if there was one. Grab the prev node, increment its referen=
ce
> + * count, drop the lock, and return that prev node.
> + */
> +struct klist_node *klist_prev(struct klist_iter *i)
> +{
> +	void (*put)(struct klist_node *) =3D i->i_klist->put;
> +	struct klist_node *last =3D i->i_cur;
> +	struct klist_node *prev;
> +
> +	spin_lock(&i->i_klist->k_lock);
> +
> +	if (last) {
> +		prev =3D to_klist_node(last->n_node.prev);
> +		if (!klist_dec_and_del(last))
> +			put =3D NULL;
> +	} else
> +		prev =3D to_klist_node(i->i_klist->k_list.prev);
> +
> +	i->i_cur =3D NULL;
> +	while (prev !=3D to_klist_node(&i->i_klist->k_list)) {
> +		if (likely(!knode_dead(prev))) {
> +			kref_get(&prev->n_ref);
> +			i->i_cur =3D prev;
> +			break;
> +		}
> +		prev =3D to_klist_node(prev->n_node.prev);
> +	}
> +
> +	spin_unlock(&i->i_klist->k_lock);
> +
> +	if (put && last)
> +		put(last);
> +	return i->i_cur;
> +}
> +EXPORT_SYMBOL_GPL(klist_prev);
> +
> +/**
>   * klist_next - Ante up next node in list.
>   * @i: Iterator structure.
>   *

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
