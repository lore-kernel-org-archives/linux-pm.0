From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 03/19] ACPI: add ACPI_TYPE_LOCAL_REFERENCE support to acpi_extract_package()
Date: Wed, 24 Sep 2014 23:58:54 +0200
Message-ID: <18113181.Bfj08FO0BU@vostro.rjw.lan>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com> <1411005230-2227-4-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50260 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751930AbaIXVjF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 17:39:05 -0400
In-Reply-To: <1411005230-2227-4-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, eduardo.valentin@ti.com

On Thursday, September 18, 2014 09:53:34 AM Zhang Rui wrote:
> Add ACPI_TYPE_LOCAL_REFERENCE support to acpi_extract_package(),
> so that we can use this helper for more cases like _ART/_TRT.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

ACK

> ---
>  drivers/acpi/utils.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 07c8c5a..1ed7aba 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -149,6 +149,21 @@ acpi_extract_package(union acpi_object *package,
>  				break;
>  			}
>  			break;
> +		case ACPI_TYPE_LOCAL_REFERENCE:
> +			switch (format_string[i]) {
> +			case 'R':
> +				size_required += sizeof(void *);
> +				tail_offset += sizeof(void *);
> +				break;
> +			default:
> +				printk(KERN_WARNING PREFIX "Invalid package element"
> +					      " [%d] got reference,"
> +					      " expecting [%c]\n",
> +					      i, format_string[i]);
> +				return AE_BAD_DATA;
> +				break;
> +			}
> +			break;
>  
>  		case ACPI_TYPE_PACKAGE:
>  		default:
> @@ -247,7 +262,18 @@ acpi_extract_package(union acpi_object *package,
>  				break;
>  			}
>  			break;
> -
> +		case ACPI_TYPE_LOCAL_REFERENCE:
> +			switch (format_string[i]) {
> +			case 'R':
> +				*(void **)head =
> +				    (void *)element->reference.handle;
> +				head += sizeof(void *);
> +				break;
> +			default:
> +				/* Should never get here */
> +				break;
> +			}
> +			break;
>  		case ACPI_TYPE_PACKAGE:
>  			/* TBD: handle nested packages... */
>  		default:
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
