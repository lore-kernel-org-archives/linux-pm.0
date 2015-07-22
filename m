From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: rk808: make better use of the gpiod API
Date: Wed, 22 Jul 2015 09:13:29 +0200
Message-ID: <20150722071329.GM9981@pengutronix.de>
References: <20150721132945.7ffc443b@canb.auug.org.au>
 <1437461993-14860-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAJKOXPfY4zYtWKa6U4mzBjtS87HZepOV_hHodU2QJaJrLcr9qQ@mail.gmail.com>
 <20150721143524.GD9981@pengutronix.de>
 <20150721144100.GU11162@sirena.org.uk>
 <55AEE03F.8060100@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55AEE03F.8060100@samsung.com>
Sender: linux-next-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Zhong <zyw@rock-chips.com>, kernel@pengutronix.de, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Wed, Jul 22, 2015 at 09:13:51AM +0900, Krzysztof Kozlowski wrote:
> On 21.07.2015 23:41, Mark Brown wrote:
> > That looks like a bug, yes.
>=20
> Cc: linux-pm, Kevin, Rafael, Ulf
Good idea. Note I already sent a patch to Greg that you might want to
look at, too:
	http://article.gmane.org/gmane.linux.kernel/2001345

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
