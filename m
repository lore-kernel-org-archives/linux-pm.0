From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 23/27] i2c-hid: convert acpi_evaluate_object() to acpi_evaluate_integer()
Date: Fri, 06 Sep 2013 10:17:58 +0200
Message-ID: <52298FB6.1030903@redhat.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com> <1378168335-22556-24-git-send-email-rui.zhang@intel.com> <alpine.LNX.2.00.1309041214120.3684@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50683 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab3IFISH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Sep 2013 04:18:07 -0400
In-Reply-To: <alpine.LNX.2.00.1309041214120.3684@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, rjw@sisk.pl, linux-pm@vger.kernel.org

On 04/09/13 12:14, Jiri Kosina wrote:
> On Tue, 3 Sep 2013, Zhang Rui wrote:
> 
>> acpi_evaluate_integer() is an ACPI API introduced to evaluate an
>> ACPI control method that is known to have an integer return value.
>> This API can simplify the code because the calling function does not need to
>> use the specified acpi_buffer structure required by acpi_evaluate_object();
>>
>> Convert acpi_evaluate_object() to acpi_evaluate_integer()
>> in drivers/hid/i2c-hid/i2c-hid.c in this patch.
>>
>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> CC: Jiri Kosina <jkosina@suse.cz>
> 
> Acked-by: Jiri Kosina <jkosina@suse.cz>

As long as it does not break current DSM handling (I can not test this
part of the code),

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin


