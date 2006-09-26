From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspending to disk on FC6 not working
Date: Wed, 27 Sep 2006 00:58:02 +0200
Message-ID: <20060926225802.GF4714@elf.ucw.cz>
References: <1159138520.19021.11.camel@soncomputer>
	<1159310353.3566.7.camel@soncomputer>
	<20060926224554.GE4714@elf.ucw.cz> <200609270054.14016.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609270054.14016.rjw@sisk.pl>
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

On Wed 2006-09-27 00:54:13, Rafael J. Wysocki wrote:
> On Wednesday, 27 September 2006 00:45, Pavel Machek wrote:
> > On Tue 2006-09-26 18:39:13, Louis Garcia wrote:
> > > On Wed, 2006-09-27 at 00:26 +0200, Rafael J. Wysocki wrote:
> > > > On Wednesday, 27 September 2006 00:15, Pavel Machek wrote:
> > > > > Hi!
> > > > > =

> > > > > > > > Please boot the kernel with "2" appended to the command lin=
e, so the system
> > > > > > > > goes to the 2nd runlevel (ie. without network servers and X=
).  Then log in
> > > > > > > > as root, do "echo 8 > /proc/sys/kernel/printk" and
> > > > > > > > "echo disk > /sys/power/state".  The system should suspend =
to disk and power
> > > > > > > > off the machine.  If it doesn't do that (ie. if it returns =
to the shell
> > > > > > > > immediately), please do "dmesg > dmesg.log" and send the dm=
esg.log file
> > > > > > > > to me.
> > > > > > > =

> > > > > > > The system didn't power off, it returned to the shell. I atta=
ched dmesg.
> > > > > > =

> > > > > > Thanks.
> > > > > > =

> > > > > > Pavel, it looks like we have a problem with the CPU suspend on =
this box:
> > > > > > =

> > > > > > acpi acpi: freeze
> > > > > > PM: snapshotting memory.
> > > > > > Class driver suspend failed for cpu0
> > > > > > Could not power down device &q->lock: error -22
> > > > > > Some devices failed to power down, aborting suspend
> > > > > > acpi acpi: resuming
> > > > > =

> > > > > That looks like cpufreq/acpi, no?
> > > > > =

> > > > > Can we get bugzilla.kernel.org report?
> > > > =

> > > > Ah, it may be the same bug as http://bugzilla.kernel.org/show_bug.c=
gi?id=3D7188
> > > > =

> > > > > Can you try without acpi processor and cpufreq?
> > > > =

> > > > First, please try to remove the acpi_cpufreq module before the susp=
end.
> > > > =

> > > > Greetings,
> > > > Rafael
> > > =

> > > Yep sure is. I removed the acpi_cpufreq module and my box suspended a=
nd
> > > resumed nicely, from gnome even.
> > > =

> > > This has not been working since 2.6.17. Something in cpufreq in the
> > > 2.6.18pre series broke.
> > =

> > bugzilla time, cc dave jones and acpi people.
> =

> We _already_ _have_ a bugzilla entry for that (please see above).

Sorry.

> Louis, could you please add a "me too" to the bugzilla entry at the above
> address?

Also state that it worked okay in 2.6.17...

...hmm, and at this point you should be able to git bisect...

...or perhaps it is easier to add printks into acpi_cpufreq and find
_why_ its class suspend fails?
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
