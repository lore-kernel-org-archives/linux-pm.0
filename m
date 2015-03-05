From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/1] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Thu, 5 Mar 2015 18:11:28 +0200
Message-ID: <CAHp75VfLj5moAXsbXz4bFh8Ukgv9+4DWYc63E_SOKckR+gqNeQ@mail.gmail.com>
References: <1424880737-12119-1-git-send-email-boon.leong.ong@intel.com>
	<1424880737-12119-2-git-send-email-boon.leong.ong@intel.com>
	<54F48BCB.7070505@nexus-software.ie>
	<AF233D1473C1364ABD51D28909A1B1B73276139A@PGSMSX105.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AF233D1473C1364ABD51D28909A1B1B73276139A@PGSMSX105.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ong, Boon Leong" <boon.leong.ong@intel.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "Kweh, Hock Leong" <hock.leong.kweh@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 3, 2015 at 3:13 AM, Ong, Boon Leong
<boon.leong.ong@intel.com> wrote:
>>> +config INTEL_QUARK_DTS_THERMAL
>>> +    tristate "Intel Quark DTS thermal driver"
>>> +    depends on X86 && IOSF_MBI
>>
>>Since the change is in RC-1 suggest
>>depends on X86_INTEL_QUARK
>>you can skip this though it's not important.
> Ya. That is true now since the below commit has been merged:
> 8bbc2a135b63bee6b41fa90f415521a97995a49f to mainline in 4.0-rc1
>
> On another thought, how about adding INTEL_QUARK_DTS_THERMAL to
> be selected by X86_INTEL_QUARK  in arch/x86/Kconfig ... and we can
> drop the above dependencies from here.

This driver as far as I understand is not critical to run Intel Quark.
So, there is should not be a dependency in the platform definition.

On the other hand is the driver will work exclusively on Quark? If so,
better to leave the mentioned dependency, .i.e.
depends on X86_INTEL_QUARK

-- 
With Best Regards,
Andy Shevchenko
