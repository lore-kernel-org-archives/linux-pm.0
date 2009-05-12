From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] pm: remove unused asm/suspend.h
Date: Tue, 12 May 2009 21:32:00 +0200
Message-ID: <20090512193200.GA22728@elf.ucw.cz>
References: <20090512131606.7984.69575.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090512131606.7984.69575.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2009-05-12 22:16:06, Magnus Damm wrote:
> 
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch removes unused asm/suspend.h files for
> the following architectures:
> 
>  alpha, arm, ia64, m68k, mips, s390, um
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Are you sure? arm does support suspend...
							Pavel

> --- 0001/arch/arm/include/asm/suspend.h
> +++ /dev/null	2009-05-12 09:34:44.497006305 +0900
> @@ -1,4 +0,0 @@
> -#ifndef _ASMARM_SUSPEND_H
> -#define _ASMARM_SUSPEND_H
> -
> -#endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
