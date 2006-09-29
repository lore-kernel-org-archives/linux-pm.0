From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspending to disk on FC6 not working
Date: Fri, 29 Sep 2006 22:14:41 +0000
Message-ID: <20060929221440.GA6242@ucw.cz>
References: <EB12A50964762B4D8111D55B764A8454ABBA55@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A8454ABBA55@scsmsx413.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Could not power down device &q->lock: error -22
> > > Some devices failed to power down, aborting suspend
> >
> >Ok, I'm not quite sure how we got into this state.  Venkatesh, =

> >any ideas ?
> >acpi-cpufreq got quite a few changes between .17 and .18, including the
> >two large 'P-state coordination' change.
> >
> >Louis, I'm attaching two smaller changes that went into .18.
> >Can you apply those with -R, and see if either of those makes =

> >a difference?
> =

> cpufreq_cpu_data[] =3D NULL; only happens when acpi_cpufreq driver init
> fails;
> Looks like acpi_cpufreq driver init is failing at some point in this
> case and the driver is staying loaded after that failure. That in turn
> seems similar to one other bug I saw recently.

Uh, if acpi_cpufreq is built-in... you can't unload it when init
fails, so you need to handle that somehow...?

							Pavel
-- =

Thanks for all the (sleeping) penguins.
