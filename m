From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: linux-pm build failure
Date: Fri, 9 May 2014 01:11:00 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880255ADA9@SHSMSX101.ccr.corp.intel.com>
References: <536BBAF8.6040601@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61182 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486AbaEIBLF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 21:11:05 -0400
In-Reply-To: <536BBAF8.6040601@semaphore.gr>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Huang, Ying" <ying.huang@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Stratos

Could you offer me the .config to check.

Thanks and best regards
-Lv

> -----Original Message-----
> From: Stratos Karafotis [mailto:stratosk@semaphore.gr]
> Sent: Friday, May 09, 2014 1:12 AM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J
> Cc: linux-pm@vger.kernel.org
> Subject: linux-pm build failure
> 
> Hi all,
> 
> There is a build failure in latest linux-pm bleeding-edge:
> 
> In file included from include/linux/linkage.h:6:0,
>                  from include/linux/kernel.h:6,
>                  from include/acpi/platform/aclinux.h:64,
>                  from include/acpi/platform/acenv.h:150,
>                  from include/acpi/acpi.h:56,
>                  from drivers/acpi/acpica/rscreate.c:44:
> include/linux/export.h:59:20: error: redefinition of '__kstrtab_acpi_buffer_to_resource'
>   static const char __kstrtab_##sym[]   \
>                     ^
> include/linux/export.h:69:2: note: in expansion of macro '__EXPORT_SYMBOL'
>   __EXPORT_SYMBOL(sym, "")
>   ^
> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro 'EXPORT_SYMBOL'
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>                                      ^
> drivers/acpi/acpica/rscreate.c:119:1: note: in expansion of macro 'ACPI_EXPORT_SYMBOL'
>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
>  ^
> include/linux/export.h:59:20: note: previous definition of '__kstrtab_acpi_buffer_to_resource' was here
>   static const char __kstrtab_##sym[]   \
>                     ^
> include/linux/export.h:69:2: note: in expansion of macro '__EXPORT_SYMBOL'
>   __EXPORT_SYMBOL(sym, "")
>   ^
> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro 'EXPORT_SYMBOL'
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>                                      ^
> drivers/acpi/acpica/rscreate.c:117:1: note: in expansion of macro 'ACPI_EXPORT_SYMBOL'
>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
>  ^
> include/linux/export.h:63:39: error: redefinition of '__ksymtab_acpi_buffer_to_resource'
>   __visible const struct kernel_symbol __ksymtab_##sym \
>                                        ^
> include/linux/export.h:69:2: note: in expansion of macro '__EXPORT_SYMBOL'
>   __EXPORT_SYMBOL(sym, "")
>   ^
> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro 'EXPORT_SYMBOL'
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>                                      ^
> drivers/acpi/acpica/rscreate.c:119:1: note: in expansion of macro 'ACPI_EXPORT_SYMBOL'
>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
>  ^
> include/linux/export.h:63:39: note: previous definition of '__ksymtab_acpi_buffer_to_resource' was here
>   __visible const struct kernel_symbol __ksymtab_##sym \
>                                        ^
> include/linux/export.h:69:2: note: in expansion of macro '__EXPORT_SYMBOL'
>   __EXPORT_SYMBOL(sym, "")
>   ^
> include/acpi/platform/aclinux.h:110:37: note: in expansion of macro 'EXPORT_SYMBOL'
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>                                      ^
> drivers/acpi/acpica/rscreate.c:117:1: note: in expansion of macro 'ACPI_EXPORT_SYMBOL'
>  ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
>  ^
> make[3]: *** [drivers/acpi/acpica/rscreate.o] Error 1
> make[2]: *** [drivers/acpi/acpica] Error 2
> make[1]: *** [drivers/acpi] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> 
> 
> Reverting commit 51e35823eb57 ("ACPICA: Update acpi_buffer_to_resource interface"), build completes fine.
> 
> 
> Thanks,
> Stratos Karafotis
