From: Pavel Machek <pavel@ucw.cz>
Subject: Re: arch/x86/kernel/apm_32.c: removed duplicated	#include
Date: Wed, 13 Aug 2008 09:23:28 +0200
Message-ID: <20080813072328.GA17873@elf.ucw.cz>
References: <20080810210401.2EFA.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080810210401.2EFA.WEIYI.HUANG@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Huang Weiyi <weiyi.huang@gmail.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun 2008-08-10 21:05:12, Huang Weiyi wrote:
> Removed duplicated include file <linux/smp_lock.h> in 
> arch/x86/kernel/apm_32.c.
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Acked-by: Pavel Machek <pavel@suse.cz>

> 
> diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
> index bf9b441..f499808 100644
> --- a/arch/x86/kernel/apm_32.c
> +++ b/arch/x86/kernel/apm_32.c
> @@ -229,7 +229,6 @@
>  #include <linux/suspend.h>
>  #include <linux/kthread.h>
>  #include <linux/jiffies.h>
> -#include <linux/smp_lock.h>
> 
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
