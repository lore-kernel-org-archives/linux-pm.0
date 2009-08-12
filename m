From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH update] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 15)
Date: Wed, 12 Aug 2009 11:47:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908121145200.9635-100000__33517.3473381021$1250092185$gmane$org@iolanthe.rowland.org>
References: <aec7e5c30908120337g2928b825m1a17a311a0756305@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30908120337g2928b825m1a17a311a0756305@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Aug 2009, Magnus Damm wrote:

> > --- /dev/null
> > +++ linux-2.6/drivers/base/power/runtime.c
> [...]
> > +int __pm_runtime_suspend(struct device *dev, bool from_wq)
> > + =A0 =A0 =A0 __releases(&dev->power.lock) __acquires(&dev->power.lock)
> [...]
> > + =A0 =A0 =A0 if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_sus=
pend) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D dev->bus->pm->runtime_suspend(=
dev);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.runtime_error =3D retval;
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOSYS;
> > + =A0 =A0 =A0 }
> =

> Nit: { and } above do not follow the regular coding style.

As a matter of fact they do.  From Documentation/CodingStyle:


Do not unnecessarily use braces where a single statement will do.

if (condition)
	action();

This does not apply if one branch of a conditional statement is a single
statement. Use braces in both branches.

if (condition) {
	do_this();
	do_that();
} else {
	otherwise();
}


Alan Stern
