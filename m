From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 22:58:37 +0200
Message-ID: <20070413205837.GG28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704132243.59618.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > For powermac, we need to do some things between suspending devices and
> > device_power_off, for example setting the decrementer. This patch
> > introduces pm_ops.quiesce and pm_ops.activate which will be called inst=
ead
> > of disabling/enabling irqs so platforms get control over this step.
> > =

> > If not assigned, these two calls will be assigned with defaults during
> > set_pm_ops.
> > =

> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> =

> I have no objections.  Pavel, what do you think?

That it is same old hack it used to be. There's nothing magic about
decrementer, and I do not think it is _neccessary_ to touch it just
before cli. Just disable it from sysdev handler or something.

> > --- wireless-dev.orig/include/linux/pm.h	2007-04-13 10:09:17.835356880 =
+0200
> > +++ wireless-dev/include/linux/pm.h	2007-04-13 14:57:01.525356880 +0200
> > @@ -135,9 +135,19 @@ typedef int __bitwise suspend_disk_metho
> >   * @prepare: Prepare the platform for the given suspend state. Can ret=
urn a
> >   *	negative error code if necessary.
> >   *
> > + * @quiesce: This callback is called after devices are suspended but b=
efore
> > + *	they are powered down. If assigned, this callback must at least turn
> > + *	off local IRQs. If left unassigned, a default callback that does
> > + *	nothing but turn off local IRQs is assigned during pm_set_ops().

Is it called for s2ram? swsusp? uswsusp?

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
