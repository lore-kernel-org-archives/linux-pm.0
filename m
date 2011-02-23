From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Subject: Re: [PATCH] xen: fix XEN_SAVE_RESTORE Kconfig
	dependencies
Date: Wed, 23 Feb 2011 09:08:43 +0000
Message-ID: <1298452123.16356.10537.camel__45124.3858355612$1298452284$gmane$org@zakaz.uk.xensource.com>
References: <1298446066-11754-1-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298446066-11754-1-git-send-email-rshriram@cs.ubc.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2011-02-23 at 07:27 +0000, Shriram Rajagopalan wrote:
> Make XEN_SAVE_RESTORE user visible and enable HIBERNATION and SWAP,
> if this option is enabled.

I was under the (perhaps mistaken?) impression that selecting user
visible Kconfig symbols was verboten since it has side-effects which
make it hard for users to figure out why something cannot be switched
off and/or how to turn things on etc.

In any case I think I preferred the "depends HIBERNATION" idea -- I
thought that was the consensus of the thread too?

> Remove XEN_SAVE_RESTORE dependancy from PM_SLEEP.

"dependency"

Ian.

> 
> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
> ---
>  arch/x86/xen/Kconfig |    6 ++++--
>  kernel/power/Kconfig |    2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index 5b54892..ab6c3a2 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -37,8 +37,10 @@ config XEN_MAX_DOMAIN_MEMORY
>           portions of which are freed.
>  
>  config XEN_SAVE_RESTORE
> -       bool
> -       depends on XEN && PM
> +       bool "Enable Xen Guest save/restore/checkpoint"
> +       depends on XEN
> +       select SWAP
> +       select HIBERNATION
>         default y
>  
>  config XEN_DEBUG_FS
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 2657299..ccff0ba 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -92,7 +92,7 @@ config PM_SLEEP_SMP
>  
>  config PM_SLEEP
>  	bool
> -	depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
> +	depends on SUSPEND || HIBERNATION
>  	default y
>  
>  config PM_SLEEP_ADVANCED_DEBUG
