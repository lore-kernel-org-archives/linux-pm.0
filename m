From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.4-rc1 #1
Date: Tue, 3 Nov 2015 22:14:06 +0100
Message-ID: <CAJZ5v0h_TekGs1rNcYRsnmDT8Hca5nZVssFDs993frUYzEYbLw@mail.gmail.com>
References: <20151101203036.GA9793@localhost.localdomain>
	<744357E9AAD1214791ACBA4B0B9092633A909D91@SHSMSX101.ccr.corp.intel.com>
	<20151103171341.GA4277@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35085 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbbKCVOH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 16:14:07 -0500
In-Reply-To: <20151103171341.GA4277@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

HI,

On Tue, Nov 3, 2015 at 6:13 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> Rui, Rafael,
>
> On Tue, Nov 03, 2015 at 03:10:28AM +0000, Zhang, Rui wrote:
>>
>> > Javi Merino (2):
>> >       PM / OPP: get the voltage for all OPPs
>>
>> I think this patch should be took by Rafael, right?
>>
>> Thanks,
>> Rui
>>
>> >  drivers/base/power/opp.c                           |   4 +-
>
> Well, yes. I included it here because the devfreq support has a
> (functional) dependency on this change. As it is a small change, and
> I did not notice any break in linux-next, I included it in my pull
> request.
>
> Rafael, I think it is your call. Do you want collect this one and send
> it via your tree, or are you fine having it going through Ruis?

It can go in through the Rui's tree as far as I'm concerned.

Thanks,
Rafael
