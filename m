From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [pm:bleeding-edge 2/10] drivers/acpi/scan.c:2131:25: error: 'struct
 acpi_device_info' has no member named 'cls'
Date: Thu, 9 Jul 2015 14:02:18 +0700
Message-ID: <559E1C7A.1020300@amd.com>
References: <201507070754.hc2CSuL4%fengguang.wu@intel.com>
 <3013609.yTOAvZudGY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2on0116.outbound.protection.outlook.com ([65.55.169.116]:12512
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750833AbbGIHQl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jul 2015 03:16:41 -0400
In-Reply-To: <3013609.yTOAvZudGY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, Hanjun Guo <hanjun.guo@linaro.org>, linux-pm@vger.kernel.org



On 7/7/15 07:25, Rafael J. Wysocki wrote:
> On Tuesday, July 07, 2015 07:47:55 AM kbuild test robot wrote:
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
>> head:   e3b3968310369aadfa5c1f7baca68ef37bfd1d38
>> commit: 1f9cda6095d7073ae96c27b1dbfd8d3fa71a85d3 [2/10] ACPI / scan: Add support for ACPI _CLS device matching
>> config: x86_64-lkp (attached as .config)
>> reproduce:
>>    git checkout 1f9cda6095d7073ae96c27b1dbfd8d3fa71a85d3
>>    # save the attached .config to linux build tree
>>    make ARCH=x86_64
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>     drivers/acpi/scan.c: In function 'acpi_set_pnp_ids':
>>>> drivers/acpi/scan.c:2131:25: error: 'struct acpi_device_info' has no member named 'cls'
>>         acpi_add_id(pnp, info->cls.string);
>>                              ^
>
> ACPICA chose a different name for this field.  It should be fixed up in my tree now.

Thanks,

Suravee
