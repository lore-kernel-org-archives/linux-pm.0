From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: Re: [PATCH] x86, acpi: Handle xapic/x2apic entries in MADT
Date: Tue, 14 Jul 2015 10:06:48 +0200
Message-ID: <1436861209-4047-1-git-send-email-lukasz.anaczkowski@intel.com>
References: <55A3D7A3.90609@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24020 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbbGNIG4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 04:06:56 -0400
In-Reply-To: <55A3D7A3.90609@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 07/13/2015 23:22 PM, Hanjun Guo wrote:
>> In case when BIOS is populating MADT wiht both x2apic and local apic
>> entries (as per ACPI spec), kernel builds it's processor table
>> in the following order: BSP, X2APIC, local APIC, resulting in
>> processors on the same core are not separated by core count.
>
> I'm confused here, I can't figure out where is the problem, could you
> explain it in detail?
>
> For me, logical CPU IDs allocated by OS will have mappings to physical
> CPU IDs, what you are saying seems CPU topology problem to me.

Sorry for confusion, I'll send another patch with updated commit message
where I'll try to put some more details and explanation. Hope that one will
be less confusing.

>>   arch/x86/kernel/acpi/boot.c | 29 +++++++++++++-----
>>   drivers/acpi/numa.c         | 28 ++++++++++++-----
>>   drivers/acpi/tables.c       | 75 ++++++++++++++++++++++++++++-----------------
>>   drivers/irqchip/irq-gic.c   | 15 ++++++---
>
> Anyway, You also miss the SMP boot for ARM64 in ACPI way, which will
> cause compile error on ARM64.

The only symbol that's changed is acpi_parse_entries and I don't see
any calls to it in ARM64. I also tried compilation of arm64/defconfig
and it compiles fine. Could yoy point me to place where it might failing?

Thanks,
    Lukasz
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

