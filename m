From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [5/6] 2.6.21-rc3: known regressions
Date: Tue, 13 Mar 2007 19:14:04 +0100
Message-ID: <20070313181404.GC12224@elf.ucw.cz>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
	<20070313125016.GV18731@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070313125016.GV18731@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Arkadiusz Miskiewicz <arekm@maven.pl>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Tomas Janousek <tomi@nomi.cz>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

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

> Subject    : resume: slab error in verify_redzone_free(): cache `size-512=
':
>                      memory outside object was overwritten
> References : http://lkml.org/lkml/2007/2/24/41
> Submitter  : Pavel Machek <pavel@ucw.cz>
> Status     : unknown
> =

> =

> Subject    : beeps get longer after suspend
> References : http://lkml.org/lkml/2007/2/26/276
> Submitter  : Pavel Machek <pavel@ucw.cz>
> Status     : unknown

Seems fixed in -rc3.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
