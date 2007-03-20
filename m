From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to disk modes, default mode
Date: Tue, 20 Mar 2007 10:33:22 +0100
Message-ID: <20070320093322.GE3922@elf.ucw.cz>
References: <1174351671.3645.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174351671.3645.8.camel@johannes.berg>
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

> This suspend to disk modes stuff really sucks. The last time I looked
> must have been a long time ago because then shutdown was default. Now I
> find that in November 06 you changed it to be platform by default.
> =

> The problem with this is that not all platforms support the "platform"
> mode.
> =

> I have a pm_ops struct for PMU-based Apple powerpc machines that doesn't
> set pm_disk_mode in order not to allow the platform mode because that
> currently fails.
> =

> I also used to think this was for implementing suspend-to-both, is that
> wrong? In any case, I can't live with it being platform by default

No, it is to get ACPI working after resume.

> Maybe we just need a pm_disk_modes bitmap and a default_pm_disk_mode
> member in struct pm_ops instead? What's firmware vs. platform anyway?

bitmap would be nice. Firmware used to mean "let the bios do the whole
suspend", platform means "linux does the suspend, but we tell bios we
are doing it", shutdown means "linux does the suspend, does not tell
anyone".
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
