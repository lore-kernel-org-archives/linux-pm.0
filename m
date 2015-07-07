From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [pm:bleeding-edge 2/10] drivers/acpi/scan.c:2131:25: error: 'struct acpi_device_info' has no member named 'cls'
Date: Tue, 07 Jul 2015 02:25:21 +0200
Message-ID: <3013609.yTOAvZudGY@vostro.rjw.lan>
References: <201507070754.hc2CSuL4%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56241 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756114AbbGFX6z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 19:58:55 -0400
In-Reply-To: <201507070754.hc2CSuL4%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, Hanjun Guo <hanjun.guo@linaro.org>, linux-pm@vger.kernel.org

On Tuesday, July 07, 2015 07:47:55 AM kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   e3b3968310369aadfa5c1f7baca68ef37bfd1d38
> commit: 1f9cda6095d7073ae96c27b1dbfd8d3fa71a85d3 [2/10] ACPI / scan: Add support for ACPI _CLS device matching
> config: x86_64-lkp (attached as .config)
> reproduce:
>   git checkout 1f9cda6095d7073ae96c27b1dbfd8d3fa71a85d3
>   # save the attached .config to linux build tree
>   make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/acpi/scan.c: In function 'acpi_set_pnp_ids':
> >> drivers/acpi/scan.c:2131:25: error: 'struct acpi_device_info' has no member named 'cls'
>        acpi_add_id(pnp, info->cls.string);
>                             ^

ACPICA chose a different name for this field.  It should be fixed up in my tree now.


> vim +2131 drivers/acpi/scan.c
> 
>   2125				pnp->type.bus_address = 1;
>   2126			}
>   2127			if (info->valid & ACPI_VALID_UID)
>   2128				pnp->unique_id = kstrdup(info->unique_id.string,
>   2129								GFP_KERNEL);
>   2130			if (info->valid & ACPI_VALID_CLS)
> > 2131				acpi_add_id(pnp, info->cls.string);
>   2132	
>   2133			kfree(info);
>   2134	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
