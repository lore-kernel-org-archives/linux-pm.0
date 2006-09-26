From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspending to disk on FC6 not working
Date: Wed, 27 Sep 2006 00:26:30 +0200
Message-ID: <200609270026.31011.rjw@sisk.pl>
References: <1159138520.19021.11.camel@soncomputer>
	<200609270001.50063.rjw@sisk.pl> <20060926221556.GD4714@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060926221556.GD4714@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 27 September 2006 00:15, Pavel Machek wrote:
> Hi!
> =

> > > > Please boot the kernel with "2" appended to the command line, so th=
e system
> > > > goes to the 2nd runlevel (ie. without network servers and X).  Then=
 log in
> > > > as root, do "echo 8 > /proc/sys/kernel/printk" and
> > > > "echo disk > /sys/power/state".  The system should suspend to disk =
and power
> > > > off the machine.  If it doesn't do that (ie. if it returns to the s=
hell
> > > > immediately), please do "dmesg > dmesg.log" and send the dmesg.log =
file
> > > > to me.
> > > =

> > > The system didn't power off, it returned to the shell. I attached dme=
sg.
> > =

> > Thanks.
> > =

> > Pavel, it looks like we have a problem with the CPU suspend on this box:
> > =

> > acpi acpi: freeze
> > PM: snapshotting memory.
> > Class driver suspend failed for cpu0
> > Could not power down device &q->lock: error -22
> > Some devices failed to power down, aborting suspend
> > acpi acpi: resuming
> =

> That looks like cpufreq/acpi, no?
> =

> Can we get bugzilla.kernel.org report?

Ah, it may be the same bug as http://bugzilla.kernel.org/show_bug.cgi?id=3D=
7188

> Can you try without acpi processor and cpufreq?

First, please try to remove the acpi_cpufreq module before the suspend.

Greetings,
Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
