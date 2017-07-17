From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] thermal: int340x: constify attribute_group
 structures.
Date: Mon, 17 Jul 2017 13:41:20 +0300
Message-ID: <1500288080.29303.38.camel@linux.intel.com>
References: <3b42983a016cbb0d1fb3b6bab625b78abf843474.1500287619.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b42983a016cbb0d1fb3b6bab625b78abf843474.1500287619.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2017-07-17 at 16:04 +0530, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work
> with const attribute_group. So mark the non-const structs as const.
> 

I hope you did compile test it.

> File size before:
>    text	   data	    bss	    dec	    hex	
> filename
>    1687	    592	      0	   2279	    8e7	
> int3400_thermal.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	
> filename
>    1751	    528	      0	   2279	    8e7	
> int3400_thermal.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/thermal/int340x_thermal/int3400_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index a9ec94e..b2ffbed 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -104,7 +104,7 @@ static ssize_t current_uuid_store(struct device
> *dev,
>  	NULL
>  };
>  
> -static struct attribute_group uuid_attribute_group = {
> +static const struct attribute_group uuid_attribute_group = {
>  	.attrs = uuid_attrs,
>  	.name = "uuids"
>  };

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
