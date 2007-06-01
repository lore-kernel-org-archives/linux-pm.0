From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] i386: Do not restore reserved memory after
	hibernation
Date: Fri, 1 Jun 2007 23:26:58 +0000
Message-ID: <20070601232658.GB4559@ucw.cz>
References: <200706012158.32832.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706012158.32832.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, Andi Kleen <ak@suse.de>, Andrey Borzenkov <arvidjaar@mail.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch is designed to fix http://bugzilla.kernel.org/show_bug.cgi?id=7995
> 
> Unfortunately, the reporter is unresponsive, so it hasn't been explicitly
> confirmed to fix the issue, but it's based on some previous patches that
> worked and definitely does what it's meant to do. :-)

Thanks!

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ack, but it needs to be in -mm for a while.

/me feels tricky area.
						Pavel

>  arch/i386/kernel/e820.c  |   30 ++++++++++++++++++++++++++++++
>  arch/i386/kernel/setup.c |    1 +
>  include/asm-i386/e820.h  |    1 +
>  3 files changed, 32 insertions(+)
> 
> Index: linux-2.6.22-rc3/arch/i386/kernel/e820.c
> ===================================================================
> --- linux-2.6.22-rc3.orig/arch/i386/kernel/e820.c
> +++ linux-2.6.22-rc3/arch/i386/kernel/e820.c
> @@ -10,6 +10,7 @@
>  #include <linux/efi.h>
>  #include <linux/pfn.h>
>  #include <linux/uaccess.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/page.h>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
