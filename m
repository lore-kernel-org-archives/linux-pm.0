From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspending to disk on FC6 not working
Date: Wed, 27 Sep 2006 00:15:56 +0200
Message-ID: <20060926221556.GD4714@elf.ucw.cz>
References: <1159138520.19021.11.camel@soncomputer>
	<200609261200.28635.rjw@sisk.pl>
	<1159307254.2780.4.camel@soncomputer>
	<200609270001.50063.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609270001.50063.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Please boot the kernel with "2" appended to the command line, so the =
system
> > > goes to the 2nd runlevel (ie. without network servers and X).  Then l=
og in
> > > as root, do "echo 8 > /proc/sys/kernel/printk" and
> > > "echo disk > /sys/power/state".  The system should suspend to disk an=
d power
> > > off the machine.  If it doesn't do that (ie. if it returns to the she=
ll
> > > immediately), please do "dmesg > dmesg.log" and send the dmesg.log fi=
le
> > > to me.
> > =

> > The system didn't power off, it returned to the shell. I attached dmesg.
> =

> Thanks.
> =

> Pavel, it looks like we have a problem with the CPU suspend on this box:
> =

> acpi acpi: freeze
> PM: snapshotting memory.
> Class driver suspend failed for cpu0
> Could not power down device &q->lock: error -22
> Some devices failed to power down, aborting suspend
> acpi acpi: resuming

That looks like cpufreq/acpi, no?

Can we get bugzilla.kernel.org report?

Can you try without acpi processor and cpufreq?
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
