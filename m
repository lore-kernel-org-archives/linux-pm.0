From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v5 0/4] BQ24190 charger fixes
Date: Wed, 10 May 2017 21:52:26 -0700
Message-ID: <CAKvHMgQp26fFAhxY0dOivU8bCDEMPbZ6HMQR7MpRJz+BurZd4A@mail.gmail.com>
References: <20170411115957.14253-1-liam@networkimprov.net> <20170412145218.ubhv4j7s3fkb3yah@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35547 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdEKEw2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 00:52:28 -0400
Received: by mail-io0-f195.google.com with SMTP id o12so2096383iod.2
        for <linux-pm@vger.kernel.org>; Wed, 10 May 2017 21:52:27 -0700 (PDT)
In-Reply-To: <20170412145218.ubhv4j7s3fkb3yah@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>

Hi Sebastian,

On Wed, Apr 12, 2017 at 7:52 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Tue, Apr 11, 2017 at 04:59:53AM -0700, Liam Breck wrote:
>> Here in one patchset are two patches I posted recently, and two more:
>>
>> Patch 1 is a replacement (as agreed) for
>>   "power: supply: bq24190_charger: Don't spam the logs on charger plug / unplug"
>> Patch 2 fixes up Hans' extcon patch. If you would like me to squash it with his
>>   original patch, let me know.
>> Patch 3 (repost) fixes some issues with PM runtime error handling.
>> Patch 4 fixes a nit in register_reset().
>>
>> Changed in v5:
>> * move condition in extcon OTG boost code
>> * document extcon client invocation of charger driver
>> * udelay -> usleep_range in register_reset()
>>
>> Changes in v4:
>> * fix definition of bq24190_reg_poc_chg_config_*
>> * revert to if (device_property_read... == 0)
>
> Thanks, queued.

Two of these (below) referenced another patch with
  Fixes: SHA ("...")
but the SHAs are wrong because the ref'd patches weren't in mainline
when I pasted them. Should they be fixed?

power: supply: bq24190_charger: Clean up extcon code
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=03add17fe338af82a28b41bda6afeb3b25c0a323
  Fixes should ref: da26580f4eb8

power: supply: bq24190_charger: Uniform pm_runtime_get() failure handling
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e3ebc381a966f7fb41b13c2823ff96f9d6d7a377
  Fixes should ref: f385e6e2a153
