From: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>
Subject: RE: [PATCH] x86, arm64, acpi: Handle lapic/x2apic entries in MADT
Date: Tue, 1 Sep 2015 12:07:15 +0000
Message-ID: <C1C2579D7BE026428F81F41198ADB1723786A47E@irsmsx110.ger.corp.intel.com>
References: <55DDB45D.2030901@arm.com>
 <1440611369-26314-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1440611369-26314-2-git-send-email-lukasz.anaczkowski@intel.com>
 <55E55BA8.5090102@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:15250 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbbIAMHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 08:07:20 -0400
In-Reply-To: <55E55BA8.5090102@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>

From: Tomasz Nowicki [mailto:tomasz.nowicki@linaro.org] 
Sent: Tuesday, September 1, 2015 10:03 AM

>> To fix this, each LAPIC/X2APIC entry from MADT table needs to be 
>> handled at the same time when processing it, thus adding 
>> acpi_subtable_proc structure which stores
>> () ACPI table id
>> () handler that processes table
>> () counter how many items has been processed and passing it to 
>> acpi_table_parse_entries().

> Why can't you leave the parsing code as is and create ApicId sorted list while parsing LAPIC/X2APIC? You could call acpi_register_lapic() after all... Do I miss something ?

Just to make sure I understand correctly - you suggest to replace calls to acpi_register_lapic() with a code that builds an APIC ID list while parsing LAPIC/X2APIC, and after parsing is done,
go thru the list and call acpi_register_lapic() on each APIC ID, correct?

Thanks,
Lukasz
