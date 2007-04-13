From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:33:49 +0200
Message-ID: <20070413213349.GL28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl>
	<20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
	<20070413211232.GJ28264@elf.ucw.cz>
	<1176499086.7052.124.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176499086.7052.124.camel@johannes.berg>
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

On Fri 2007-04-13 23:18:05, Johannes Berg wrote:
> On Fri, 2007-04-13 at 23:12 +0200, Pavel Machek wrote:
> =

> =

> > > Whoops, I had that in an earlier version, it's not supposed to be cal=
led
> > > for (u)swsusp because pm_ops involvement there is a hack anyway. I'll
> > > fix the description.
> > =

> > But (u)swsusp needs to shut down the devices, and it does both suspend
> > and powerdown, too...?
> =

> Yes, but the special S4 state is just hacked onto pm_ops, nothing but
> ACPI S4 will ever sanely use pm_ops. If I'd invented pm_ops I'd made
> pm_ops solely for suspend to ram/standby/... and added a *separate* hook
> for pm_disk_mode and S4 because logically that really doesn't belong to
> pm_ops which does almost exclusively things for suspend to ram/standby.

Still, swsusp shuts down the devices:

        if ((error =3D arch_prepare_suspend()))
                return error;

        local_irq_disable();
        /* At this point, device_suspend() has been called, but *not*
         * device_power_down(). We *must* device_power_down() now.
         * Otherwise, drivers for some devices (e.g. interrupt
controllers)
         * become desynchronized with the actual state of the hardware
         * at resume time, and evil weirdness ensues.
         */
        if ((error =3D device_power_down(PMSG_FREEZE))) {
                printk(KERN_ERR "Some devices failed to power down, abortin=
g suspend\n");
                goto Enable_irqs;
        }

This local_irq_disable() is very similar to the one you are doing in
suspend-to-RAM. According to your description, it needs to play with
the decrementor, too. But I'd really prefer not to have pm_ops call
here -- exactly because swsusp has nothing to do with pm_ops in
shutdown mode.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
