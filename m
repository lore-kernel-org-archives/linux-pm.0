From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] thermal: intel_pch_thermal: Support skylake PCH 100 series thermal
Date: Wed, 19 Oct 2016 05:10:28 +0900
Message-ID: <87eg3dctaj.fsf@mail.parknet.co.jp>
References: <87pomyd515.fsf@mail.parknet.co.jp>
        <1476813814.132953.50.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.parknet.co.jp ([210.171.160.6]:48452 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbcJRUKd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 16:10:33 -0400
In-Reply-To: <1476813814.132953.50.camel@intel.com> (Srinivas Pandruvada's
        message of "Tue, 18 Oct 2016 18:03:36 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> writes:

> On Tue, 2016-10-18 at 06:44 +0900, OGAWA Hirofumi wrote:
>> Using registers are compatible with current driver.
> This description is not enough. Without going through the whole code, I
> was not able to find out what this patch is doing.
>
> Basically you want to tie the themal_zone name and device operations to
> a board, rather than to PCI devices ids. In this way multiple PCI ids
> for the same board can be accounted for.

Exactly. I thought the patch is enough easy to read, and changelog would
be better to not explain what code itself, and wrote note of code
(registers are same with current).

Well, ok. I will explain what patch does. Your explain looks like good,
so I will borrow it :)

> Also need to consider another patch sent to mailing list for supporting
> Haswell PCH.

Sounds good. I think the patch makes it easier.

> One comment below in the code.
>
> [...]
>  
>>  static struct pci_device_id intel_pch_thermal_id[] = {
>> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT) },
>> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_WPT),
>> +	  .driver_data = board_wpt, },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL),
>> +	  .driver_data = board_skl, },
>> +	/* skylake PCH 100 series */
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa131),
> Change a131 to a define (PCH_THERMAL_DID_SKL_H)

I don't think it helps anything actually, because no users of define
anymore. Well, anyway, ok, I don't care either case.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
