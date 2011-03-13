From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 8/8] Introduce ARCH_NO_SYSDEV_OPS config
	option
Date: Sun, 13 Mar 2011 14:55:13 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1103131453360.2787@localhost6.localdomain6>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
	<201103122221.37295.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103122221.37295.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 12 Mar 2011, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> ===================================================================
> --- linux-2.6.orig/arch/x86/Kconfig
> +++ linux-2.6/arch/x86/Kconfig
> @@ -184,6 +184,9 @@ config ARCH_HIBERNATION_POSSIBLE
>  config ARCH_SUSPEND_POSSIBLE
>  	def_bool y
>  
> +config ARCH_NO_SYSDEV_OPS
> +	def_bool y
> +

Can we please put that in drivers/base/Kconfig and let the arch
Kconfig select it?

Thanks,

	tglx
