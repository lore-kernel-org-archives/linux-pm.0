From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 1/4] Hibernate: Call platform_begin
	before	swsusp_shrink_memory
Date: Thu, 23 Oct 2008 09:37:52 +1100
Message-ID: <1224715072.8156.4.camel@nigel-laptop>
References: <200810222249.20629.rjw@sisk.pl> <200810222250.36537.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810222250.36537.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi.

On Wed, 2008-10-22 at 22:50 +0200, Rafael J. Wysocki wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Hibernate: Call platform_begin before swsusp_shrink_memory
> 
> Call platform_begin() before swsusp_shrink_memory() so that we can
> always allocate enough memory to save the ACPI NVS region from
> platform_begin().
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/disk.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/disk.c
> +++ linux-2.6/kernel/power/disk.c
> @@ -267,12 +267,12 @@ int hibernation_snapshot(int platform_mo
>  {
>  	int error, ftrace_save;
>  
> -	/* Free memory before shutting down devices. */
> -	error = swsusp_shrink_memory();
> +	error = platform_begin(platform_mode);
>  	if (error)
>  		return error;
>  
> -	error = platform_begin(platform_mode);
> +	/* Free memory before shutting down devices. */
> +	error = swsusp_shrink_memory();
>  	if (error)
>  		goto Close;
>  

Acked-by: Nigel Cunningham <nigel@tuxonice.net>
