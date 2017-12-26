From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/16] power: supply: axp288_charger: Do not stop +
 restart charging at boot
Date: Tue, 26 Dec 2017 10:26:51 +0100
Message-ID: <5b6e6a0b-2687-4b7a-14d2-e7fc61e68fa5@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
 <CAGb2v64ReFdDkweEx77SfubudGCdBXuMREGifWDud3CbtMRDiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34449 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZJ0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 04:26:53 -0500
Received: by mail-wm0-f43.google.com with SMTP id y82so35239547wmg.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2017 01:26:53 -0800 (PST)
In-Reply-To: <CAGb2v64ReFdDkweEx77SfubudGCdBXuMREGifWDud3CbtMRDiA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Sebastian Reichel <sre@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

Hi,

On 26-12-17 08:29, Chen-Yu Tsai wrote:
> On Fri, Dec 22, 2017 at 8:37 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Before this commit we were relying solely on the extcon interface for
>> cable detection, including to determine if a cable providing vbus is
>> connected at all. This caused us to turn off charging at boot, because
>> when we run the initial state processing the axp288-extcon driver is still
>> running charger-type detection most of the time, so all charger cable
>> types read as disconnected when we run the initial state processing.
>>
>> This commit reworks the axp288_charger_extcon_evt_worker flow to use the
>> VBUS_VALID bit from the PWR_INPUT_STATUS register to determine if we
>> should turn charging on/off. Note this is the same bit as we use for the
>> online property.
>>
>> If VBUS_VALID is set, but the extcon code has not completed the charger
>> type detection yet, we now simply bail leaving things as configured by
>> the BIOS (we will get a notifier call when the extcon code is done and
>> reschedule the axp288_charger_extcon_evt_worker).
>>
>> The extcon code is the only one to trigger the worker (outside of the
>> initial run) and we can rely on it to only call us if things have changed,
>> so while we are completely refactoring axp288_charger_extcon_evt_worker,
>> also remove the code to check if the state has changed.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Other than the two patches I replied to, this looks good overall.
> For the remaining patches,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Hans, I don't have any devices with this PMIC, so I'm unlikely to spend
> much time on the axp288 specific drivers. Any chance you want to maintain
> them?

Yes that probably is a good idea, I will add a patch to v2 of the series
adding a MAINTAINERS entry for this.

Regards,

Hans
