From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/3] drivers: power: twl4030_charger: fix link
 problems when building as module
Date: Thu, 24 Sep 2015 22:39:25 +0200
Message-ID: <20150924203924.GD3125@earth>
References: <1442953171-19718-1-git-send-email-marek@goldelico.com>
 <20150922212900.GB15646@earth>
 <CAAfyv36mr67fUJKbe1F_rdxRjtvR8M+da0rYCtVTxDgyhKLvSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv36mr67fUJKbe1F_rdxRjtvR8M+da0rYCtVTxDgyhKLvSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Sep 24, 2015 at 09:09:15PM +0200, Belisko Marek wrote:
> On Tue, Sep 22, 2015 at 11:29 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Tue, Sep 22, 2015 at 10:19:29PM +0200, Marek Belisko wrote:
> >> If either twl4030_charger or twl4030_madc is configured as MODULE,
> >> we get build (link) errors.
> >>
> >> To solve, the direct call of twl4030_get_madc_conversion() is replaced
> >> by a call to iio_read_channel_processed().
> >>
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> Signed-off-by: Marek Belisko <marek@goldelico.com>
> >> ---
> >> changes from V1: added missing iio_channel_release + document and add new DT bindings
> >
> > That was fast :) Patchset looks fine to me except for one last
> > thing: Let's make the iio-channel optional, so that old DT blobs
> > are still supported. Also the IS_REACHABLE(CONFIG_TWL4030_MADC)
> > check can be removed, it should no longer be needed with
> > iio_read_channel_processed().
> OK I updated driver code to pass when 'vac' property isn't found in
> DT. Should I mark it also
> in DT bindings or keep it as it was in v2? Thanks.

Move it from "Required properties:" to "Optional properties:". Maybe
stating, that the feature does not work, if it's not provided.

-- Sebastian

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWBF98AAoJENju1/PIO/qab8MP/0CoSqi1KeRuhrmjDhiuIjie
sHAG7koLJOE754cICR0SZ+iptfozd7T9w5FkA58bh0xr49n90aWTn8ho35RlzDeu
/3W6qHT4jRByqlxIxX0V8XLExohlMuq7Lq0n/LHMZoa5Rv4IkLhkoFEk49rlM2Jh
2JUh31FONJtEAgcCgGeTXa2FhYYB3qRoE085m3yXaL1PgmT5cZo/spcL1Hct7pMh
mpMODyJB3ptvU+zR71NIA84plxeuZx6I7+Jt61TJCzkcTIhT3bDolQDohnWzsbl8
MH3t43/ngmzqPOcH3eSPjp6fPFMr/PrVIG+Pms00oFM5VvSeNVyZ7UYHvlvtuof3
p2TlE8PD1fcFBewMVnMLXZqD2dKncoT3OyoziOlspaWmmDtblr8RuPUMP6MGREJh
kQudD/rwNhGPXIvTYSBg+E1yfNwsTp0xnbkAmtOeL5iUf77CBmt7cuRo42wiIkt/
Cp0AlW3iaV7GlUsI1jolO1cMhSvu2iQXar7K+WJIzNhxY/cuDg010GSTLE8D0SJR
LKj8XX7dd9NxtZ/z8FzNOLv22COknzEhazPGMbpVT68M8Vto3W9QhlpluHv16NOC
rQ0lZwapmmrkH5d6Ffd/zh1M2OcUsPnrzYBq7Qy1mQZn8YKgGQVFNC4THn0A54mN
wSxjJLWvHmojX7F8JFhK
=ik+g
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
