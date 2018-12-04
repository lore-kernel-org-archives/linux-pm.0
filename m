From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] PM / AVS: SmartReflex: Fix module licence specification
Date: Tue, 4 Dec 2018 21:15:33 +0100
Message-ID: <20181204201533.u467nu3cgoktt7ef@pengutronix.de>
References: <20181008091818.1145-1-uwe@kleine-koenig.org>
 <CAJZ5v0jEHcPKchOmzd9AewGCT0zkXnRgL=QGZTW-xWcJ12HNoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jEHcPKchOmzd9AewGCT0zkXnRgL=QGZTW-xWcJ12HNoA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rafael,

On Tue, Oct 09, 2018 at 09:56:52AM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 8, 2018 at 11:23 AM Uwe Kleine-K=F6nig <uwe@kleine-koenig.org=
> wrote:
> >
> > The header of this file claims "version 2" and not "or later". So adapt
> > the module licence specification accordingly.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> > ---
> >  drivers/power/avs/smartreflex.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartr=
eflex.c
> > index d29b6313cafc..9ed30b5d32c2 100644
> > --- a/drivers/power/avs/smartreflex.c
> > +++ b/drivers/power/avs/smartreflex.c
> > @@ -1062,6 +1062,6 @@ static void __exit sr_exit(void)
> >  module_exit(sr_exit);
> >
> >  MODULE_DESCRIPTION("OMAP Smartreflex Driver");
> > -MODULE_LICENSE("GPL");
> > +MODULE_LICENSE("GPL v2");
> >  MODULE_ALIAS("platform:" DRIVER_NAME);
> >  MODULE_AUTHOR("Texas Instruments Inc");
> > --
> =

> While you are at it, why don't you add a proper SPDX license ID to
> this file and drop the license bolierplate from the heading comment?

That would be a separate patch, right? And in contrast to this one
(which is a fix IMHO) it would only be an "improvement".

As this was just a drive-by change I won't follow up on this one. Take
it as is or don't.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
