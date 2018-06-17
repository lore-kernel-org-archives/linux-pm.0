From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
Date: Sun, 17 Jun 2018 15:05:28 +0800
Message-ID: <20180617070527.GL16091@dragon>
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
 <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
 <2307533.g32PyNi9fl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2307533.g32PyNi9fl@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>, Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 04:33:05PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 12, 2018 2:42:12 PM CEST Oleksij Rempel wrote:
> >  This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
> > --Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924
> > Content-Type: multipart/mixed; boundary="d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg";
> >  protected-headers="v1"
> > From: Oleksij Rempel <o.rempel@pengutronix.de>
> > To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
> >  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
> >  linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
> >  linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
> >  Liam Girdwood <lgirdwood@gmail.com>,
> >  Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
> >  Mark Rutland <mark.rutland@arm.com>,
> >  Michael Turquette <mturquette@baylibre.com>,
> >  Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
> >  Russell King <linux@armlinux.org.uk>
> > Message-ID: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
> > Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
> > References: <20180517055014.6607-1-o.rempel@pengutronix.de>
> >  <20180517055014.6607-4-o.rempel@pengutronix.de>
> > In-Reply-To: <20180517055014.6607-4-o.rempel@pengutronix.de>
> > 
> > --d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg
> > Content-Type: text/plain; charset=utf-8
> > Content-Language: en-US
> > Content-Transfer-Encoding: quoted-printable
> > 
> > Hi Rafael,
> > 
> > Last version of this patch was send at 17.05.2018. No other comment was
> > provided and this patch is a blocker for other patches in this serie.
> > Can you please give some feedback on it.
> 
> I would have done that had I not missed the patch.
> 
> Which probably wouldn't have happened had you CCed it to linux-pm.
> 
> Anyway, I have no particular problems with exporting pm_power_off_prepare via
> EXPORT_SYMBOL_GPL().

Rafael,

Can we have your explicit Acked-by tag on this patch?  Thanks.

Shawn
