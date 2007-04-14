From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [3/3] 2.6.21-rc6: known regressions
Date: Sat, 14 Apr 2007 09:57:03 +0800
Message-ID: <1176515823.4807.7.camel@daplas>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<20070414003808.GU5907@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070414003808.GU5907@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: James Simmons <jsimmons@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

On Sat, 2007-04-14 at 02:38 +0200, Adrian Bunk wrote:
> This email lists some known regressions in Linus' tree compared to 2.6.20.
> =

> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way
> possibly involved with one or more of these issues.
> =

> Due to the huge amount of recipients, please trim the Cc when answering.
> =

> =

> Subject    : resume from RAM corrupts vesafb console
> References : http://lkml.org/lkml/2007/3/26/76
> Submitter  : Marcus Better <marcus@better.se>
> Handled-By : Pavel Machek <pavel@ucw.cz>
> Status     : problem is being debugged
> =

> =

Hi Marcus,

A screen with blinking green blocks implies that your display is in text
mode, not in graphics mode.  I don't know what options you are using,
but have you tried using:

acpi_sleep=3Ds3_mode

If the above does not work, also try

acpi_sleep=3Ds3_bios,s3_mode

If it is still not working, you can add this to your suspend script:

vbetool vbemode set <VESA mode ID>

where VESA mode ID =3D "vga=3D" value - 512 (0x200)

Tony

PS: If your BIOS setup has an option to re-POST the graphics card on
resume, that is a big help.

Tony
