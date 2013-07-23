From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/glue: evaluate "_STA" method directly to get device actual status instead of using acpi_bus_get_status_handle()
Date: Wed, 24 Jul 2013 00:56:50 +0200
Message-ID: <1576514.u2PtRP7MSF@vostro.rjw.lan>
References: <1374547633-4477-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36537 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934626Ab3GWWqt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Jul 2013 18:46:49 -0400
In-Reply-To: <1374547633-4477-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tianyu.lan@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Dagobertstaler@gmail.com, git@karolherbst.de

On Tuesday, July 23, 2013 10:47:13 AM tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> commit 33f767d7(ACPI: Rework acpi_get_child() to be more efficient) changes
> the logic of choosing child in the do_acpi_find_child() when there are
> multi child devices with same _ADR. Original, it returned the last one but
> it return the first one after commit 33f767d7.

I don't really think this is correct, because after that change we do a
post-order walk, but we return the first handle found, while without it we
would do a pre-order walk, but we would return the *last* handle found,
which should be the same in both cases.

Also as indicated here: https://bugzilla.kernel.org/show_bug.cgi?id=60561#c8
simply changing the walk ordering doesn't solve the problem.

It looks like the other change made by commit 33f767d7 is at fualt here,
which was to evaluate _ADR directly instead of using acpi_get_object_info().

That said I think we may try the patch below, but I'm going to rewrite the
changelog a bit.

Thanks,
Rafael


> This causes regression on the
> Notebook P15SM that there is no ACPI handle for video card. This because
> there are two ACPI nodes with same _ADR for associated PCIE port. One
> contains video card's ACPI node and the other one doesn't(So called wrong
> ACPI node.). The wrong one is the first child device on this machine. So
> after commit 33f767d7, bbswitch can't find ACPI handle for video card.
> Further more, both these device nodes don't have _STA.
> 
> commit c7d9ca9(ACPI: add _STA evaluation at do_acpi_find_child()) also
> changes the logic of choosing child. On some platforms, there are multiple
> devices with the same "_ADR" and they are perceptively for WIN7, WIN8 and
> Linux. If one of them is enabled, others will be disabled. The commit calls
> acpi_bus_get_status_handle() to get device's status If a matching device object
> exists, but is disabled, acpi_get_child() will continue to walk the namespace
> in the hope of finding an enabled one. If one is found, its handle will be returned,
> but otherwise the function will return the handle of the disabled object found.
> For this case, Bios must provide _STA for these device nodes since this is designed
> for OS to select which device node should be chosen.
> 
> After commit c7d9ca9, the first enabled device will be chosen or if
> all device nodes were disabled or acpi_bus_get_status_handle() always returned
> error, the last one would be returned. But for device nodes without _STA,
> according acpi spec "If a device object (including the processor object) does not
> have an _STA object, then OSPM assumes that the device is present, enabled, shown
> in the UI, and functioning." and so acpi_bus_get_status_handle() return 0x0F as
> status for these devices without _STA.
> 
> On the Notebook P15SM, both PCIE port device node with same _ADR don't have _STA
> and are treated as ENABLED devices by do_acpi_find_child(). The first wrong device
> node is returned. To workaround the issue, evaluate the _STA directly in the
> do_acpi_find_child() and if all device nodes doesn't have _STA, the last one will
> be chosen. This also will not affect the case for commit c7d9ca9. This have been
> tested on Lenovo Y480 where commit 33f767d7 fixed one similar issue.
> 
> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=60561
> Reference:https://github.com/Bumblebee-Project/bbswitch/issues/65
> reference:https://github.com/Bumblebee-Project/bbswitch/issues/2#issuecomment-21101083
> Tested-by: Sergio Perez <Dagobertstaler@gmail.com>
> Tested-by: Karol Herbst <git@karolherbst.de>
> Cc: <stable@vger.kernel.org> #3.9+
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
> Hi Rafael:
> 	This patch is based on the commit c7d9ca9 merged in v3.11
> and purposes to fix the regression introduced by 33f767d7 merged in v3.9.
> So it's necessary to backport both commit c7d9ca9 and this patch to 3.9+ stable tree?
> 
>  drivers/acpi/glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index f680957..732c707 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -87,7 +87,7 @@ static acpi_status do_acpi_find_child(acpi_handle handle, u32 lvl_not_used,
>  	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &addr);
>  	if (ACPI_SUCCESS(status) && addr == *((u64 *)addr_p)) {
>  		*ret_p = handle;
> -		status = acpi_bus_get_status_handle(handle, &sta);
> +		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
>  		if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_ENABLED))
>  			return AE_CTRL_TERMINATE;
>  	}
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
