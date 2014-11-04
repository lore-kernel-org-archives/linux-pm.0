From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: Thermal: int340x_thermal: expose acpi thermal relationship
 tables
Date: Tue, 4 Nov 2014 15:23:11 -0800
Message-ID: <20141104152311.39e02f7e@icelake>
References: <20141013174111.GA8390@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30561 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaKDXXp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Nov 2014 18:23:45 -0500
In-Reply-To: <20141013174111.GA8390@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

On Mon, 13 Oct 2014 20:41:11 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hello Jacob Pan,
> 
> The patch 52b1c69d7e3c: "Thermal: int340x_thermal: expose acpi
> thermal relationship tables" from Sep 3, 2014, leads to the following
> static checker warning:
> 
> 	drivers/thermal/int340x_thermal/acpi_thermal_rel.c:327
> acpi_thermal_rel_ioctl() warn: passing casted pointer '&count' to
> 'acpi_parse_trt()' 64 vs 32.
> 
> drivers/thermal/int340x_thermal/acpi_thermal_rel.c
>    315  static long acpi_thermal_rel_ioctl(struct file *f, unsigned
> int cmd, 316                                     unsigned long __arg)
>    317  {
>    318          int ret = 0;
>    319          unsigned long length = 0;
>    320          unsigned long count = 0;
>    321          char __user *arg = (void __user *)__arg;
>    322          struct trt *trts;
>    323          struct art *arts;
>    324  
>    325          switch (cmd) {
>    326          case ACPI_THERMAL_GET_TRT_COUNT:
>    327                  ret = acpi_parse_trt(acpi_thermal_rel_handle,
> (int *)&count, ^^^^^^^^^^^^
> The reason for the static checker warning is that this will not work
> on big endian 64 bit systems.  It's most likely not a concern but it's
> still pretty ugly.
> 
> You could just make "count" an int and remove the casting.  The copy
> to user will still work if it's an int because the user pointer has
> been casted to unsigned long __user pointer.
you are right, I will make the change. Thanks for pointing this out and
sorry for the late response, I was traveling.

> 
>    328                                  &trts, false);
>    329                  kfree(trts);
>    330                  if (!ret)
>    331                          return put_user(count, (unsigned long
> __user *)__arg); 332                  return ret;
>    333          case ACPI_THERMAL_GET_TRT_LEN:
> 
> regards,
> dan carpenter

[Jacob Pan]
