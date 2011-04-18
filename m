From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 10/14] PM / MIPS: Use struct syscore_ops
	instead of sysdevs for PM
Date: Mon, 18 Apr 2011 22:03:15 +0200
Message-ID: <201104182203.16171.rjw__12779.4839012951$1303157249$gmane$org@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172312.35060.rjw@sisk.pl>
	<20110418101218.GA25325@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110418101218.GA25325@linux-mips.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>, Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 18, 2011, Ralf Baechle wrote:
> This patch breaks the Alchemy kernel compile; below patch on top of it fixes
> that again.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!  If you don't mind, I'd like to fold your patch into [10/14].

Rafael


> ---
>  arch/mips/alchemy/common/irq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-mips/arch/mips/alchemy/common/irq.c
> ===================================================================
> --- linux-mips.orig/arch/mips/alchemy/common/irq.c
> +++ linux-mips/arch/mips/alchemy/common/irq.c
> @@ -619,8 +619,8 @@ static struct syscore_ops alchemy_ic_sys
>  
>  static int __init alchemy_ic_syscore_init(void)
>  {
> -	alchemy_ic_data[0].base = ioremap(icbase[IC0_PHYS_ADDR], 0x1000);
> -	alchemy_ic_data[1].base = ioremap(icbase[IC1_PHYS_ADDR], 0x1000);
> +	alchemy_ic_data[0].base = ioremap(IC0_PHYS_ADDR, 0x1000);
> +	alchemy_ic_data[1].base = ioremap(IC1_PHYS_ADDR, 0x1000);
>  
>  	register_syscore_ops(&alchemy_ic_syscore_ops);
>  
> 
> 
