From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 04/27] fujitsu-laptop: convert acpi_evaluate_object() to
 acpi_execute_simple_method()
Date: Tue, 3 Sep 2013 22:41:26 +0930
Message-ID: <20130903131126.GA20020@marvin.atrad.com.au>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
 <1378168335-22556-5-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378168335-22556-5-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org, jwoithe@just42.net
List-Id: linux-pm@vger.kernel.org

This (and the other two along similar lines) look ok to me.

Acked-by: Jonathan Woithe <jwoithe@just42.net>

On Tue, Sep 03, 2013 at 08:31:52AM +0800, Zhang Rui wrote:
> acpi_execute_simple_method() is a new ACPI API introduced to invoke
> an ACPI control method that has single integer parameter and no return value.
> 
> Convert acpi_evaluate_object() to acpi_execute_simple_method()
> in drivers/platform/x86/fujitsu-laptop.c
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> CC: Matthew Garrett <matthew.garrett@nebula.com>
> CC: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> CC: platform-driver-x86@vger.kernel.org
> ---
>  drivers/platform/x86/fujitsu-laptop.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 52b8a97..29738cb 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -317,8 +317,6 @@ static enum led_brightness kblamps_get(struct led_classdev *cdev)
>  static int set_lcd_level(int level)
>  {
>  	acpi_status status = AE_OK;
> -	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> -	struct acpi_object_list arg_list = { 1, &arg0 };
>  	acpi_handle handle = NULL;
>  
>  	vdbg_printk(FUJLAPTOP_DBG_TRACE, "set lcd level via SBLL [%d]\n",
> @@ -333,9 +331,8 @@ static int set_lcd_level(int level)
>  		return -ENODEV;
>  	}
>  
> -	arg0.integer.value = level;
>  
> -	status = acpi_evaluate_object(handle, NULL, &arg_list, NULL);
> +	status = acpi_execute_simple_method(handle, NULL, level);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> @@ -345,8 +342,6 @@ static int set_lcd_level(int level)
>  static int set_lcd_level_alt(int level)
>  {
>  	acpi_status status = AE_OK;
> -	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> -	struct acpi_object_list arg_list = { 1, &arg0 };
>  	acpi_handle handle = NULL;
>  
>  	vdbg_printk(FUJLAPTOP_DBG_TRACE, "set lcd level via SBL2 [%d]\n",
> @@ -361,9 +356,7 @@ static int set_lcd_level_alt(int level)
>  		return -ENODEV;
>  	}
>  
> -	arg0.integer.value = level;
> -
> -	status = acpi_evaluate_object(handle, NULL, &arg_list, NULL);
> +	status = acpi_execute_simple_method(handle, NULL, level);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -- 
> 1.8.1.2

-- 
Dr Jonathan Woithe
  Research Scientist and System administrator
  Atmospheric Radar Systems
  email:   jwoithe@atrad.com.au
  website: http://www.physics.adelaide.edu.au/~jwoithe
