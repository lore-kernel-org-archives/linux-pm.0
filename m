From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] PM / AVS: SmartReflex: remove unused function
Date: Wed, 14 Nov 2018 10:42:53 +0100
Message-ID: <20181114094253.v45kxd2efgwhuh42@pengutronix.de>
References: <20181006164059.16106-1-u.kleine-koenig@pengutronix.de>
 <10339961.29dihbgRqp@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <10339961.29dihbgRqp@aspire.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, kernel@pengutronix.de, LinAdmin <linadmin@quickline.ch>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Tue, Oct 16, 2018 at 11:09:11AM +0200, Rafael J. Wysocki wrote:
> On Saturday, October 6, 2018 6:40:59 PM CEST Uwe Kleine-K=F6nig wrote:
> > From: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> > =

> > omap_sr_register_pmic() was introduced in 2010 in commit
> > =

> > 	984aa6dbf4ca ("OMAP3: PM: Adding smartreflex driver support.")
> > =

> > . There was never any caller of this function in mainline resulting in a
> > warning
> > =

> > 	sr_init: No PMIC hook to init smartreflex
> > =

> > for each machine where this driver is enabled. So remove the unused
> > function and the pr_warn.
>
> Applied, thanks!

This patch didn't make it into next yet, is this expected?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
