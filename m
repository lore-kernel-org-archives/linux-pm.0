From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/6] ACPI / PM: Call acpi_save_state_mem()
 right before low-level suspend
Date: Fri, 4 Mar 2011 16:38:23 +0100
Message-ID: <20110304153823.GF1358__47735.9538934708$1299253433$gmane$org@ucw.cz>
References: <201102072316.41270.rjw@sisk.pl> <201102072320.53799.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102072320.53799.rjw@sisk.pl>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2011-02-07 23:20:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Since acpi_save_state_mem() is only called by acpi_suspend_enter()
> if the target sleep state is S3, it's better to call it under the
> switch (acpi_state), right before do_suspend_lowlevel().

ack.

> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/sleep.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/sleep.c
> +++ linux-2.6/drivers/acpi/sleep.c
> @@ -244,17 +244,10 @@ static int acpi_suspend_enter(suspend_st
>  {
>  	acpi_status status = AE_OK;
>  	u32 acpi_state = acpi_target_sleep_state;
> +	int error;
>  
>  	ACPI_FLUSH_CPU_CACHE();
>  
> -	/* Do arch specific saving of state. */
> -	if (acpi_state == ACPI_STATE_S3) {
> -		int error = acpi_save_state_mem();
> -
> -		if (error)
> -			return error;
> -	}
> -
>  	switch (acpi_state) {
>  	case ACPI_STATE_S1:
>  		barrier();
> @@ -262,6 +255,9 @@ static int acpi_suspend_enter(suspend_st
>  		break;
>  
>  	case ACPI_STATE_S3:
> +		error = acpi_save_state_mem();
> +		if (error)
> +			return error;
>  		do_suspend_lowlevel();
>  		pr_info(PREFIX "Low-level resume complete\n");
>  		break;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
