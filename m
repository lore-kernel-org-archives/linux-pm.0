From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to disk modes, default mode
Date: Tue, 20 Mar 2007 11:20:29 +0100
Message-ID: <20070320102029.GA19283@elf.ucw.cz>
References: <1174351671.3645.8.camel@johannes.berg>
	<20070320093322.GE3922@elf.ucw.cz>
	<1174383848.3770.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174383848.3770.8.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Maybe we just need a pm_disk_modes bitmap and a default_pm_disk_mode
> > > member in struct pm_ops instead? What's firmware vs. platform anyway?
> > =

> > bitmap would be nice. Firmware used to mean "let the bios do the whole
> > suspend", platform means "linux does the suspend, but we tell bios we
> > are doing it", shutdown means "linux does the suspend, does not tell
> > anyone".
> =

> Well, actually, "let the bios do the whole suspend" should be
> implemented by a new PM_SUSPEND_FIRMWAREDISK mode that can be used
> instead of "disk" and is invoked through pm_ops directly w/o hitting the
> disk.c code. That would be the right way to invoke such a mode, however,
> currently, no platforms even have such a mode as far as I can tell.

Yes, ignore that. (ACPI can do that in S4bios case. I used to have
machine where it actually worked. It is obscure corner case these days).
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
