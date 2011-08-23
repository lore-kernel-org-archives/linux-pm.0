From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] Add regulator driver for the bq2407x family
	of charger ICs
Date: Tue, 23 Aug 2011 22:15:07 +0200
Message-ID: <201108232215.08788.heiko@sntech.de>
References: <201108202224.52250.heiko@sntech.de>
	<20110823115024.GL9232@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110823115024.GL9232@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-pm@vger.kernel.org

Am Dienstag 23 August 2011, 13:50:24 schrieb Mark Brown:
> On Sat, Aug 20, 2011 at 10:24:51PM +0200, Heiko St=FCbner wrote:
> =

> Mostly looks good, just a few fairly small comments below.
> =

> > +	if (pdata->max_uA && pdata->max_uA > 500000
> > +			      && max_uA >=3D pdata->max_uA) {
> > +		dev_dbg(rdev_get_dev(rdev),
> > +			"setting current limit to %d mA\n",
> > +			pdata->max_uA / 1000);
> > +		gpio_set_value(pdata->gpio_en2, 1);
> > +		gpio_set_value(pdata->gpio_en1, 0);
> > +	} else if (max_uA >=3D 500000) {
> > +		dev_dbg(rdev_get_dev(rdev),
> > +			"setting current limit to 500 mA\n");
> > +		gpio_set_value(pdata->gpio_en2, 0);
> > +		gpio_set_value(pdata->gpio_en1, 1);
> > +	} else if (max_uA >=3D 100000) {
> > +		dev_dbg(rdev_get_dev(rdev),
> > +			"setting current limit to 100 mA\n");
> > +		gpio_set_value(pdata->gpio_en2, 0);
> > +		gpio_set_value(pdata->gpio_en1, 0);
> > +	} else {
> > +		dev_dbg(rdev_get_dev(rdev),
> > +			"setting current limit to 0 mA\n");
> > +		gpio_set_value(pdata->gpio_en2, 1);
> > +		gpio_set_value(pdata->gpio_en1, 1);
> > +	}
> =

> I'd rather expect this to return an error sometimes.
gpio_set_value is a void function, so I'm not sure what could cause an erro=
r =

here.

Heiko
