From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add regulator driver for the bq2407x family
 of charger ICs
Date: Wed, 24 Aug 2011 10:07:46 +0100
Message-ID: <20110824090746.GP9232@opensource.wolfsonmicro.com>
References: <201108202224.52250.heiko@sntech.de>
	<20110823115024.GL9232@opensource.wolfsonmicro.com>
	<201108232215.08788.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108232215.08788.heiko@sntech.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 23, 2011 at 10:15:07PM +0200, Heiko St=FCbner wrote:
> Am Dienstag 23 August 2011, 13:50:24 schrieb Mark Brown:
> > On Sat, Aug 20, 2011 at 10:24:51PM +0200, Heiko St=FCbner wrote:

> > > +	} else if (max_uA >=3D 100000) {
> > > +		dev_dbg(rdev_get_dev(rdev),
> > > +			"setting current limit to 100 mA\n");
> > > +		gpio_set_value(pdata->gpio_en2, 0);
> > > +		gpio_set_value(pdata->gpio_en1, 0);
> > > +	} else {
> > > +		dev_dbg(rdev_get_dev(rdev),
> > > +			"setting current limit to 0 mA\n");
> > > +		gpio_set_value(pdata->gpio_en2, 1);
> > > +		gpio_set_value(pdata->gpio_en1, 1);
> > > +	}

> > I'd rather expect this to return an error sometimes.

> gpio_set_value is a void function, so I'm not sure what could cause an er=
ror =

> here.

For example if you're asked for a limit below 100mA - disabling the
charger probably isn't a useful implementation.  The disable should be
done with enable/disable.
