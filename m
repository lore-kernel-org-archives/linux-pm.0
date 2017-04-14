From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 08/13] power: max17042_battery: Add support for the
 TECHNOLOGY attribute
Date: Fri, 14 Apr 2017 20:06:56 +0200
Message-ID: <db9a63d9-fd36-a19c-c24d-8c69027929c4@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-8-hdegoede@redhat.com>
 <20170414162632.7r3id7lkzbcjp3wj@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbdDNSG7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:06:59 -0400
In-Reply-To: <20170414162632.7r3id7lkzbcjp3wj@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

Hi,

On 14-04-17 18:26, Krzysztof Kozlowski wrote:
> On Fri, Apr 14, 2017 at 02:59:14PM +0200, Hans de Goede wrote:
>> The max17042 is intended for LiOn or LiPo batteries, add a TECHNOLOGY
>> attribute to reflect this. Note this is hardcoded to LiOn as there is
>> no way to tell the difference, this is done by many drivers and is
>> better then not providing any technology info at all.
>
> Same as Wolfgang's try:
> https://patchwork.kernel.org/patch/9349945/
> but with better explanation. :)

Hehe.

> Yet still I am not convinced that providing a wrong information (Li-Ion
> in case of LiPo battery) is better than not providing any info at all.

Well lithium-ion polymer batteries to use their full name are a subset
of the Li-Ion battery family so returning TECHNOLOGY_LION for them is
technically correct. The technology attribute gets read by for example
upower and then shown by for example mate-power-manager to the user:

https://github.com/mate-desktop/mate-power-manager/tree/master/src#L390

It would be nice to actually show something there, even if we're not
correctly identifying what sub-family of lithium-ion battery we are
actually dealing with.

Regards,

Hans
