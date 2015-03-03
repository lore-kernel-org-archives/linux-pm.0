From: "Ong, Boon Leong" <boon.leong.ong@intel.com>
Subject: RE: [PATCH v2 1/1] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Tue, 3 Mar 2015 01:13:09 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B73276139A@PGSMSX105.gar.corp.intel.com>
References: <1424880737-12119-1-git-send-email-boon.leong.ong@intel.com>
 <1424880737-12119-2-git-send-email-boon.leong.ong@intel.com>
 <54F48BCB.7070505@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15557 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbbCCBNR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 20:13:17 -0500
In-Reply-To: <54F48BCB.7070505@nexus-software.ie>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>-----Original Message-----
>From: Bryan O'Donoghue [mailto:pure.logic@nexus-software.ie]
>Sent: Tuesday, March 3, 2015 12:12 AM
>To: Ong, Boon Leong; Zhang, Rui; edubezval@gmail.com; Kweh, Hock Leong
>Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH v2 1/1] thermal: intel Quark SoC X1000 DTS thermal driver
>
>On 25/02/15 16:12, Ong Boon Leong wrote:
>
>> +config INTEL_QUARK_DTS_THERMAL
>> +	tristate "Intel Quark DTS thermal driver"
>> +	depends on X86 && IOSF_MBI
>
>Since the change is in RC-1 suggest
>depends on X86_INTEL_QUARK
>you can skip this though it's not important.
Ya. That is true now since the below commit has been merged:
8bbc2a135b63bee6b41fa90f415521a97995a49f to mainline in 4.0-rc1

On another thought, how about adding INTEL_QUARK_DTS_THERMAL to
be selected by X86_INTEL_QUARK  in arch/x86/Kconfig ... and we can
drop the above dependencies from here.

I can send version-3 which above change if that is agreeable by community & maintainer.

>
>Tested works for me:
>
>root@clanton:~# cat /sys/class/thermal/thermal_zone0/temp
>62
>
>Apply finger to die directly - doesn't burn but it's a bit uncomfortable
Yup... this is how I check also =-) 

Thanks Bryan. 
