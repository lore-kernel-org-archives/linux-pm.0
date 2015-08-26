From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: Re: [PATCH] x86, acpi: Handle lapic/x2apic entries in MADT
Date: Wed, 26 Aug 2015 19:49:28 +0200
Message-ID: <1440611369-26314-1-git-send-email-lukasz.anaczkowski@intel.com>
References: <55DDB45D.2030901@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55815 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbbHZRtf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Aug 2015 13:49:35 -0400
In-Reply-To: <55DDB45D.2030901@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Marc nad Lorenzo,

First of all appologies for breaking arm64 (again) and thank you for
debugging effort. I own you.

> - count is only incremented when max_entries != 0, as you noticed

You are right, sorry for that, it's fixed in v3.

> - With max_entries != 0, count now represent the sum of all matches
>  Is that expected?

I have no strong opinion on that one. All of the x86 ACPI entries
handling only checks for count < 0, or uses count from the
acpi_subtable_proc structure (and that's why I didn't noticed the
mainline breakage).
If you think it's not correct or less usable than other approach,
let me know.

> - The proc iteration stops after the first match. Why?

So, the initial implementation of the acpi_parse_entries accepted
single handler for the ACPI table. Now, with this change, assumption
is that different handlers for different tables/subtables are passed,
meaning only one can meet entry->type == proc[i].id condition.
mainline breakage). This approach saves one local varaible, but
I don't think this is ultimate argument :)

> - The test for max_entries is done inside the proc loop. Why?

That's obviously wrong in context of the overall wrong counting.

> [...] this should be documented and agreed upon.

I've added description with assumptions. Again, if you think it's
not correct, let me know.

Tomasz Nowicki wrote:
> should acpi_table_parse_entries suppose to be removed above?

Thanks for pointing this out. I've missed implementation of
acpi_table_parse_entries when was backporting initial patch.
I've added it back.

Cheers,
Lukasz

