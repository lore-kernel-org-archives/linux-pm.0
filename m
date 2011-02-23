From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] xen: fix XEN_SAVE_RESTORE Kconfig
	dependencies
Date: Wed, 23 Feb 2011 10:41:37 +0100
Message-ID: <201102231041.37406.rjw__33997.9798569859$1298454308$gmane$org@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 23, 2011, Shriram Rajagopalan wrote:
> Make XEN_SAVE_RESTORE user visible and enable HIBERNATION and SWAP,
> if this option is enabled.
> Remove XEN_SAVE_RESTORE dependancy from PM_SLEEP.
> 
> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>

Please rebase on top of suspend-2.6/linux-next
(git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git).

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

This line is being modified in linux-next already.

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

Thanks,
Rafael
