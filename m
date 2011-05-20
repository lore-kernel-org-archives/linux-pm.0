From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Fri, 20 May 2011 11:21:31 -0700
Message-ID: <BANLkTik0WV4+p+YWEKC0XataCh0Po_cEPg__17934.8901882351$1305915801$gmane$org@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
	<201105182144.37713.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
	<10124.1305906020@localhost>
	<20110520154341.GL31426@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110520154341.GL31426@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Valdis.Kletnieks@vt.edu, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

Sorry that I need=A0fix my gmail setting to make it show up in LKML.

Hi, Tejun/Valdis,

Since this is an interoperability issue of SATA host controller, the
first step I want to try it to make sure the tweak that MAKE my
controller WORK does not break other controllers.
You are both right that adding this majic 5ms delay at this place
should not be the final solution.

If this magic 5ms delay works on other affected systems, I plan to
post a new patch that inside ahci_start_engine(), still perform same
check, and show warning message if failed, but will set a flag, then
still set START bit, and if there is such failure flag, add 5ms delay.

Valdis, could you apply the following patch and retest it?

Tejun, please review it.

--- a/drivers/ata/libahci.c 2011-05-18 14:23:36.564665643 -0700

+++ c/drivers/ata/libahci.c 2011-05-20 09:48:06.194663506 -0700
@@ -540,6 +540,7 @@

=A0 void __iomem *port_mmio =3D ahci_port_base(ap);
=A0 u32 tmp;
=A0 u8 status;

+ int err =3D 0;


=A0 status =3D readl(port_mmio + PORT_TFDATA) & 0xFF;


@@ -553,12 +554,12 @@

=A0=A0 * specific controller will fail under this condition
=A0=A0 */
=A0 if (status & (ATA_BUSY | ATA_DRQ))
-=A0 return;

+=A0 err =3D 1;

=A0 else {
=A0=A0 ahci_scr_read(&ap->link, SCR_STATUS, &tmp);

=A0=A0 if ((tmp & 0xf) !=3D 0x3)
-=A0=A0 return;

+=A0=A0 err =3D 1;
=A0 }

=A0 /* start DMA */
@@ -566,6 +567,13 @@
=A0 tmp |=3D PORT_CMD_START;
=A0 writel(tmp, port_mmio + PORT_CMD);
=A0 readl(port_mmio + PORT_CMD); /* flush */
+
+ /* Some controllers need longer time to be ready */
+ if(err) {
+=A0 printk(KERN_WARNING
+=A0=A0 "Controller in wrong state when setting START bit\n");
+=A0 msleep(5);
+ }
=A0}
=A0EXPORT_SYMBOL_GPL(ahci_start_engine);

On Fri, May 20, 2011 at 8:43 AM, Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, May 20, 2011 at 11:40:20AM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 18 May 2011 17:14:56 PDT, Jian Peng said:
> >
> > > > @@ -1353,6 +1332,8 @@
> > > >
> > > >
> > > > =A0 ahci_start_engine(ap);
> > > >
> > > > + msleep(5);
> > > > +
> > > > =A0 if (online)
> > > >
> > > > =A0 =A0*class =3D ahci_dev_classify(ap);
> > > >
> >
> > It may very well be that adding a magic msleep(5) here just Makes It Wo=
rk, but
> > I have a gut feeling that it's in the wrong place (for starters, 'onlin=
e' can't change
> > during the msleep() unless somebody *else* sets it - in which case the =
locking
> > is screwed up as we're not forcing a re-read of the value). =A0The msle=
ep() probably
> > needs to be before something else further down in the code (but I have =
no idea
> > exactly what).
>
> At this point, I think it would be better to simply add a flag and
> enable the check for the affected controller.
>
> Thanks.
>
> --
> tejun
