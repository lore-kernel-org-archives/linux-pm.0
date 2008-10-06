From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI Suspend: Enable ACPI during resume if
 SCI_EN is not set
Date: Mon, 06 Oct 2008 00:34:16 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810060034050.2973@localhost.localdomain>
References: <200810040005.06220.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200810040005.06220.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

applied to acpi-test.

thanks,
-Len

On Sat, 4 Oct 2008, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI Suspend: Enable ACPI during resume if SCI_EN is not set
> 
> On some machines, like for example MSI Wind U100, the BIOS doesn't
> enable ACPI before returning control to the OS, which sometimes
> causes resume to fail.  This is against the ACPI specification,
> which clearly states that "When the platform is waking from an S1, S2
> or S3 state, OSPM assumes the hardware is already in the ACPI mode
> and will not issue an ACPI_ENABLE", but it won't hurt to check the
> SCI_EN bit and enable ACPI during resume from S3 if this bit is not
> set.
> 
> Fortunately, we already have acpi_enable() for that, so use it in the
> resume code path, before executing _BFS, in analogy with the
> resume-from-hibernation code path.
> 
> NOTE: We aren't supposed to set SCI_EN directly, because it's owned
> by the hardware.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep/main.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/sleep/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/sleep/main.c
> +++ linux-2.6/drivers/acpi/sleep/main.c
> @@ -200,6 +200,8 @@ static int acpi_suspend_enter(suspend_st
>  		break;
>  	}
>  
> +	/* If ACPI is not enabled by the BIOS, we need to enable it here. */
> +	acpi_enable();
>  	/* Reprogram control registers and execute _BFS */
>  	acpi_leave_sleep_state_prep(acpi_state);
>  
> 
