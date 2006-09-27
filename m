From: Dave Jones <davej@redhat.com>
Subject: Re: suspending to disk on FC6 not working
Date: Tue, 26 Sep 2006 22:36:31 -0400
Message-ID: <20060927023631.GD3108@redhat.com>
References: <1159138520.19021.11.camel@soncomputer>
	<200609261200.28635.rjw@sisk.pl>
	<1159307254.2780.4.camel@soncomputer>
	<200609270001.50063.rjw@sisk.pl> <20060926221556.GD4714@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060926221556.GD4714@elf.ucw.cz>
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

On Wed, Sep 27, 2006 at 12:15:56AM +0200, Pavel Machek wrote:
 > Hi!
 > =

 > > > > Please boot the kernel with "2" appended to the command line, so t=
he system
 > > > > goes to the 2nd runlevel (ie. without network servers and X).  The=
n log in
 > > > > as root, do "echo 8 > /proc/sys/kernel/printk" and
 > > > > "echo disk > /sys/power/state".  The system should suspend to disk=
 and power
 > > > > off the machine.  If it doesn't do that (ie. if it returns to the =
shell
 > > > > immediately), please do "dmesg > dmesg.log" and send the dmesg.log=
 file
 > > > > to me.
 > > > =

 > > > The system didn't power off, it returned to the shell. I attached dm=
esg.
 > > =

 > > Pavel, it looks like we have a problem with the CPU suspend on this bo=
x:
 > > =

 > > acpi acpi: freeze
 > > PM: snapshotting memory.
 > > Class driver suspend failed for cpu0
 > > Could not power down device &q->lock: error -22

That's an interesting device name.

 > > Some devices failed to power down, aborting suspend
 > > acpi acpi: resuming
 > =

 > That looks like cpufreq/acpi, no?

Looking at drivers/cpufreq/cpufreq.c:cpufreq_suspend(),
There's only two ways we can fail that function. In one way,
we'll see a printk, and the other we silently -EINVAL.
Given the log doesn't show the printk, we must be failing here..

    cpu_policy =3D cpufreq_cpu_get(cpu);
    if (!cpu_policy)
        return -EINVAL;

cpufreq_cpu_get has a number of potential ways it could fail however,
and isn't very chatty about failing, so we've no real idea
what's falling apart there.

	Dave
