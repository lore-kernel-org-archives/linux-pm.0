From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI suspend: Execute _WAK with the right
	argument
Date: Thu, 14 Feb 2008 00:30:35 -0500
Message-ID: <200802140030.35658.lenb__11544.0921429128$1202967221$gmane$org@kernel.org>
References: <200802130032.17636.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802130032.17636.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: LKML <linux-kernel@vger.kernel.org>, Mirco Tischler <mt-ml@gmx.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

applied

thanks for quickly finding and fixing this 2.6.25-rc1 regression.

-len

On Tuesday 12 February 2008 18:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The _WAK global ACPI control method has to be called with the
> argument representing the sleep state being exited.  Make it happen.
> 
> Special thanks to Mirco Tischler <mt-ml@gmx.de> for reporting the
> problem and debugging.
> 
> Reported-by: Mirco Tischler <mt-ml@gmx.de>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/hardware/hwsleep.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> +++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> @@ -616,6 +616,7 @@ acpi_status acpi_leave_sleep_state(u8 sl
>  		return_ACPI_STATUS(status);
>  	}
>  
> +	arg.integer.value = sleep_state;
>  	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
>  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
>  		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
