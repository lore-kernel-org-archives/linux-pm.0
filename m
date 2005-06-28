From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Suspend "core": what to do now ?
Date: Tue, 28 Jun 2005 15:02:35 +1000
Message-ID: <1119934956.5133.192.camel@gaston>
References: <1119851395.5133.112.camel@gaston>
	<1119912918.30369.7.camel@localhost.localdomain>
	<1119916159.5133.145.camel@gaston> <1119931577.5133.189.camel@gaston>
	<20050628045846.GA10735@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76417012493647762=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050628045846.GA10735@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Adam Belay <abelay@novell.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============76417012493647762==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-06-28 at 06:58 +0200, Pavel Machek wrote:
> Hi!
> 
> > However, PM_DISK_PLATFORM and PM_DISK_FIRMWARE sort-of abuse the pm_ops
> > that I have killed to call into arch code... it's all crap as it exposes
> > to all archs some behaviours that may not be supported by those archs.
> 
> Feel free to kill PM_DISK_FIRMWARE. PM_DISK_PLATFORM looks like the
> "right way" to do swsusp on acpi-enabled systems, so it should stay...

No, not in this form. It will be under arch control too. Makes no sense
to aim to remove the pm_ops callbacks and just add new ones for
PM_DISK_FIRMWARE :) Instead, ACPI systems will expose an S4 state that
does the right thing and calls swsusp_* library routines to do the job.

What I'll do is that I'll keep the "shutdown" case and will rename the
file generic_disk.c. It will be a "drop in" implementation that
architectures can use if they have no callbacks need at all. PPC won't
use it though. And I suspect x86 neither.

Ben.



--===============76417012493647762==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76417012493647762==--
