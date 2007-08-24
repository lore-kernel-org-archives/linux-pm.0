From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [RFC][PATCH -mm 3/4] Hibernation: Pass CR3 in the
	image header on x86_64
Date: Fri, 24 Aug 2007 11:02:20 +0200
Message-ID: <20070824090220.GA2412__39200.3443827436$1187989390$gmane$org@elf.ucw.cz>
References: <200708221015.16493.rjw@sisk.pl> <20070822082825.GC2479@elf.ucw.cz>
	<200708221817.51334.rjw@sisk.pl> <200708222249.51616.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708222249.51616.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > No, I do not think I like that. I believe both -> control and -> crc
> > > is just useless paranoia. Bitflip in this area is not going to be any
> > > worse than bitflip anywhere else, we should not pretend this is
> > > somehow "more important".
> > > 
> > > -> control should really be "protocol version"... probably should
> > > contain some field that is easy to increment.
> > 
> > OK
> > 
> > Perhaps I'll just remove the crc field.
> 
> Like in the patch below.

Yep, thanks.

> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Since we already pass the address of restore_registers() in the image header,
> we can also pass the value of the CR3 register from before the hibernation in
> the same way.  This will allow us to avoid using init_level4_pgt page tables
> during the restore.

ACK.

> @@ -9,6 +9,7 @@
>  
>  #include <linux/smp.h>
>  #include <linux/suspend.h>
> +#include <linux/crc32.h>
>  #include <asm/proto.h>
>  #include <asm/page.h>
>  #include <asm/pgtable.h>

This one is no longer neccessary.


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
