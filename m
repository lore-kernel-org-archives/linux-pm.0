From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 4 Feb 2009 17:48:24 +0100 (CET)
Message-ID: <alpine.LRH.2.00.0902041747451.7690__36060.4094843895$1233766277$gmane$org@vixen.sonytel.be>
References: <4989A784.3030604@suse.de> <200902041628.03675.elendil@planet.nl>
	<alpine.LRH.2.00.0902041642450.7690@vixen.sonytel.be>
	<200902041713.00301.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902041713.00301.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, frank@f-seidel.de, shaohuhua.li@intel.com, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, kristen.c.accardi@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Feb 2009, Frans Pop wrote:
> On Wednesday 04 February 2009, Geert Uytterhoeven wrote:
> > > This patch looks broken to me, at least for some of your changes.
> > > For example, in the bit quoted above all printks together make up
> > > *one single* message, which means that only the _first_ of the
> > > printks should have the KERN_* prefix. printks that are continuations
> > > should not have the prefix.
> >
> > Actually they should, but the right prefix :-)
> =

> Hmm. I was going by memory and from what I've seen in existing code, but
> also found this (somewhat old) post:
> https://lists.linux-foundation.org/pipermail/kernel-janitors/2005-October=
/014375.html

That one predates KERN_CONT.

> > Quoting include/linux/kernel.h:
> > | /*
> > |  * Annotation for a "continued" line of log printout (only done after=
 a
> > |  * line that had no enclosing \n). Only to be used by core/arch code
> > |  * during early bootup (a continued line is not SMP-safe otherwise).
> > |  */
> > | #define KERN_CONT       ""
> >
> > Please also consider the note about SMP-safeness.
> =

> From that it looks like KERN_CONT should only be used in a very limited
> context, but I guess this example qualifies.

Yep, the general advise is to avoid using continuations.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
