From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 10:23:44 +0200
Message-ID: <20060615082344.GE21135@elf.ucw.cz>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141657010.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141657010.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > According to
> > =

> > http://bugzilla.kernel.org/show_bug.cgi?id=3D6670
> > =

> > this should help:
> > =

> > http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115005083610700&w=3D2
> =

> Btw, maybe we should do this unconditionally?
> =

> But we should likely do it with a
> =

> 	acpi_os_write_port(acpi_gbl_FADT->smi_cmd,
> 		(u32) acpi_gbl_FADT->acpi_enable, 8);
> =

> instead of trying to just stuff "1" into that thing? Hmm? That's what the =

> regular "enable ACPI mode" code does, afaik.

Re-enabling ACPI mode during resume indeed sounds like a good idea.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
