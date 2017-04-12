From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] power: supply: max17047: Add Maxim MAX17047 Fuel Gauge
 battery driver
Date: Wed, 12 Apr 2017 09:11:54 +0200
Message-ID: <a66cd721-2e44-ac3e-d9a3-174fa3d2b442@redhat.com>
References: <20170403111647.30500-1-hdegoede@redhat.com>
 <20170411144204.5xk3jq24zmkytcn5@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbdDLHL4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 03:11:56 -0400
In-Reply-To: <20170411144204.5xk3jq24zmkytcn5@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org

Hi,

On 11-04-17 16:42, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Apr 03, 2017 at 01:16:47PM +0200, Hans de Goede wrote:
>> This commit adds support for the Maxim MAX17047 Fuel Gauge chip.
>>
>> This was tested on a GPDwin x86 Cherry Trail machine which uses the
>> Maxim MAX17047 Fuel Gauge in combination with a TI bq24292i charger.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> ---
>>  drivers/power/supply/Kconfig            |   7 +
>>  drivers/power/supply/Makefile           |   1 +
>>  drivers/power/supply/max17047_battery.c | 286 ++++++++++++++++++++++++++++++++
>>  3 files changed, 294 insertions(+)
>>  create mode 100644 drivers/power/supply/max17047_battery.c
>
> max17047 is already supported by drivers/power/supply/max17042_battery.c

Ah I checked but somehow missed that. The existing driver is not going
to work for the ACPI/X86 system I'm working with due to lack of platform_data
but that can be fixed by providing some minimal default pdata for that
case, I will write a patch for this.

Regsrds,

Hans
