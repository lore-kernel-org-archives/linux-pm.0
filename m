From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 3/3] mfd: cros_ec_dev: Register cros_usbpd-charger
 driver as a subdevice.
Date: Wed, 2 May 2018 11:42:23 +0200
Message-ID: <fa4f27ca-00ab-22e5-a693-401344797eb9@collabora.com>
References: <20180430131403.14296-1-enric.balletbo@collabora.com>
 <20180430131403.14296-4-enric.balletbo@collabora.com>
 <20180501083229.GL5147@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501083229.GL5147@dell>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Lee,

On 01/05/18 10:32, Lee Jones wrote:
> On Mon, 30 Apr 2018, Enric Balletbo i Serra wrote:
> 
>> Check whether this EC instance has USBPD host command support and
>> instatiate the cros_usbpd-charger driver as a subdevice in such case.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2:
>> - [3/3] Use ARRAY_SIZE instead of hardcoded 1.
>>
>>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
> 
> Patch looks good to me.
> 
> Does it depend on any of the other patches in the series?
> 

No, it only depends on [1] to apply cleanly (mentioned in the cover letter). I
think that [1] is close to be picked. If this is not the case I can rebase
without this dependency.

[1] https://lkml.org/lkml/2018/4/18/229

Best regards,
 Enric

> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
