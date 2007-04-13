From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:52:41 +0200
Message-ID: <20070413215241.GO28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl>
	<20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
	<20070413211232.GJ28264@elf.ucw.cz>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
	<1176500749.7052.127.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176500749.7052.127.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2007-04-13 23:45:48, Johannes Berg wrote:
> On Fri, 2007-04-13 at 23:33 +0200, Pavel Machek wrote:
> =

> > Still, swsusp shuts down the devices:
> > =

> >         if ((error =3D arch_prepare_suspend()))
> >                 return error;
> > =

> >         local_irq_disable();
> >         /* At this point, device_suspend() has been called, but *not*
> >          * device_power_down(). We *must* device_power_down() now.
> >          * Otherwise, drivers for some devices (e.g. interrupt
> > controllers)
> >          * become desynchronized with the actual state of the hardware
> >          * at resume time, and evil weirdness ensues.
> >          */
> >         if ((error =3D device_power_down(PMSG_FREEZE))) {
> >                 printk(KERN_ERR "Some devices failed to power down, abo=
rting suspend\n");
> >                 goto Enable_irqs;
> >         }
> > =

> > This local_irq_disable() is very similar to the one you are doing in
> > suspend-to-RAM. According to your description, it needs to play with
> > the decrementor, too. But I'd really prefer not to have pm_ops call
> > here -- exactly because swsusp has nothing to do with pm_ops in
> > shutdown mode.
> =

> Right. But we don't actually care because we just power down, we don't
> have to put the CPU into a proper state.

Look again, this sequence is before taking system snapshot, and then
we have to recover and save the snapshot, too.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
