From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:12:32 +0200
Message-ID: <20070413211232.GJ28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl>
	<20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176498368.7052.117.camel@johannes.berg>
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

Hi!

> > That it is same old hack it used to be. There's nothing magic about
> > decrementer, and I do not think it is _neccessary_ to touch it just
> > before cli. Just disable it from sysdev handler or something.
> =

> No, you cannot disable it from sysdev handler because you have to be
> able to take interrupts. Can we *please* move on to some more productive
> discussion?

So what happens if you disable it as a platform device? There has to
be better solution than this. What is so special about decrementer?

We were able to handle MTRR registers on PC. Timer setup fit into the
model too...

> > > > @@ -135,9 +135,19 @@ typedef int __bitwise suspend_disk_metho
> > > >   * @prepare: Prepare the platform for the given suspend state. Can=
 return a
> > > >   *	negative error code if necessary.
> > > >   *
> > > > + * @quiesce: This callback is called after devices are suspended b=
ut before
> > > > + *	they are powered down. If assigned, this callback must at least=
 turn
> > > > + *	off local IRQs. If left unassigned, a default callback that does
> > > > + *	nothing but turn off local IRQs is assigned during pm_set_ops().
> > =

> > Is it called for s2ram? swsusp? uswsusp?
> =

> Whoops, I had that in an earlier version, it's not supposed to be called
> for (u)swsusp because pm_ops involvement there is a hack anyway. I'll
> fix the description.

But (u)swsusp needs to shut down the devices, and it does both suspend
and powerdown, too...?
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
