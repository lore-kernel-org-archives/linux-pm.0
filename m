From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH] power: supply: sysfs: parse string as enum when writing
 property
Date: Tue, 11 Apr 2017 11:38:40 -0500
Message-ID: <f695eb57-d6b9-a1a6-a47f-347a5663478a@lechnology.com>
References: <1491249177-8945-1-git-send-email-david@lechnology.com>
 <20170411161222.t23gsn4pvxofhnrh@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:53890 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdDKQil (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 12:38:41 -0400
In-Reply-To: <20170411161222.t23gsn4pvxofhnrh@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/11/2017 11:12 AM, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Apr 03, 2017 at 02:52:57PM -0500, David Lechner wrote:
>> This fixes the TODO to parse strings and convert them to enum values
>> when writing to a power_supply class property sysfs attribute.
>>
>> There is at least one driver that has a writable enum property that
>> previously could only be written as an integer, so a fallback to writing
>> enums as integers instead of strings is provided so we don't break existing
>> userspace programs.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>> ---
>>  drivers/power/supply/power_supply_sysfs.c | 124 ++++++++++++++++++++----------
>>  1 file changed, 85 insertions(+), 39 deletions(-)
>
> drivers/power/supply/power_supply_sysfs.c: In function ‘power_supply_store_property’:
> drivers/power/supply/power_supply_sysfs.c:138:9: error: implicit declaration of function ‘sysfs_match_string’ [-Werror=implicit-function-declaration]

This is something I found in linux-next. I did not realize it was new. 
It looks like it is part of a patch series for USB-C connectors.[1]

It greatly simplifies things, so I think we should wait for that patch 
to land.


[1]: https://patchwork.kernel.org/patch/9636485/
