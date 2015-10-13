From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Linaro-acpi] [PATCH v5 0/5] Provide better MADT subtable sanity
 checks
Date: Tue, 13 Oct 2015 09:43:45 +0100
Message-ID: <561CC441.6090003@arm.com>
References: <1443570346-15378-1-git-send-email-al.stone@linaro.org>
 <561B5B7E.6080901@linaro.org> <561B8114.4060800@arm.com>
 <32835486.gnkKHR2R1U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51307 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbbJMInt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 04:43:49 -0400
In-Reply-To: <32835486.gnkKHR2R1U@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Pat Erley <pat-lkml@erley.org>, Al Stone <ahs3@redhat.com>, linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-arm-kernel@lists.infradead.org



On 12/10/15 20:25, Rafael J. Wysocki wrote:
> On Monday, October 12, 2015 10:44:52 AM Sudeep Holla wrote:

[...]

>>
>> Instead of just removing the check completely on x86, IMO restrict
>> it to some newer/later version of ACPI so you can still force
>> vendors to fix their ACPI tables at-least in future.
>
> No, we can't force vendors to fix their ACPI tables.  This is
> completely unrealistic.
>

No, I was referring to the future platforms *only*

> We simly need to deal with the bugs in the ACPI tables in the
> kernel.
>

Yes sadly true for existing systems, but if we now place a check for
ACPIv6.0 and above, we might avoid seeing such broken tables sometime in
future once the kernel with this check in place is used for validation.

>> It would be good to get such sanity check in the tools used to
>> build those tables, but yes since such static tables can be built
>> in many ways, its difficult to deal it in all those tools.
>
> As I said to Al, we need those checks in firmware test suites.
> Having them in the kernel is OK too, but they should cause warnings
> to be printed to the kernel log instead of causing the kernel to
> panic.
>

Agreed

-- 
Regards,
Sudeep
