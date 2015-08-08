From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM / AVS: rockchip-io: add io selectors and supplies for rk3368
Date: Sat, 08 Aug 2015 03:35:34 +0200
Message-ID: <47967648.T4i5CCNGtq@vostro.rjw.lan>
References: <3371948.nX6iqYbHnA@diego> <1481228.KhoIt654ID@diego> <7hlhdmwvhm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7hlhdmwvhm.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Friday, August 07, 2015 04:04:53 PM Kevin Hilman wrote:
> Heiko St=C3=BCbner <heiko@sntech.de> writes:
>=20
> > This adds the necessary data for handling io voltage domains on the=
 rk3368.
> > As interesting tidbit, the rk3368 contains two separate iodomain ar=
eas.
> > One in the regular General Register Files (GRF) and one in PMUGRF i=
n the
> > pmu power domain.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Acked-by: Kevin Hilman <khilman@linaro.org>
>=20
> Rafael, feel free to take this series directly, or let me know if you
> want a pull request.  I don't have anything other AVS stuff queued up
> for v4.3.

I'll take it directly, thanks!

Rafael
