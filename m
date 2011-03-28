From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] apm: orphan the driver
Date: Mon, 28 Mar 2011 14:44:38 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.1103281443240.8162__33818.887131247$1301316416$gmane$org@twin.jikos.cz>
References: <20110326172204.05e52c10.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110326172204.05e52c10.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ingo Molnar <mingo@elte.hu>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, Ondrej Zary <linux@rainbow-software.org>, Andrew Morton <akpm@linux-foundation.org>, Linus <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 26 Mar 2011, Stephen Rothwell wrote:

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  MAINTAINERS |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> I no longer have access to any hardware that uses APM and have not
> provided real maintenance for several years.  Hopefully someone with the
> hardware or energy will step forward if the driver is to be kept.
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 749f9cd..61f9948 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -548,10 +548,8 @@ S:	Maintained
>  F:	sound/aoa/
>  
>  APM DRIVER
> -M:	Stephen Rothwell <sfr@canb.auug.org.au>
>  L:	linux-laptop@vger.kernel.org
> -W:	http://www.canb.auug.org.au/~sfr/
> -S:	Supported
> +S:	Orphan
>  F:	arch/x86/kernel/apm_32.c
>  F:	include/linux/apm_bios.h

I still have some hardware that uses APM and put a new 2.6 on it time to 
time, so I can take this driver over if you want to. According to git log 
it's really low effort anyway :)

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
