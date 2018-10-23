From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] thermal: bcm2835: enable hwmon explicitly
Date: Tue, 23 Oct 2018 23:20:18 +0200
Message-ID: <12ca4f71-8ba9-91dd-f5a0-0c72c91401ef@gmail.com>
References: <20181021215848.5827-1-matthias.bgg@kernel.org>
 <459136891.184150.1540296101955@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <459136891.184150.1540296101955@email.1und1.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, matthias.bgg@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, eric@anholt.net
Cc: geert+renesas@glider.be, pmladek@suse.com, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
List-Id: linux-pm@vger.kernel.org

Hi Stefan,

On 23/10/2018 14:01, Stefan Wahren wrote:
> Hi Matthias,
> 
>> matthias.bgg@kernel.org hat am 21. Oktober 2018 um 23:58 geschrieben:
>>
>>
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> By defaul of-based thermal driver do not enable hwmon.
>> This patch does this explicitly, so that the temperature can be read
>> through the common hwmon sysfs.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> I'm just curious which board and config did you use for your tests?
> 

I use the RPi3 B+. I suppose when asking about the config, you want to know if I
also enable the RASPBERRYPI_HWMON, yes I enable that as well. Actually this
patch is for openSUSE Leap. You can find the whole config (if you are
interested) here:
https://kernel.suse.com/cgit/kernel-source/tree/config/arm64/default?h=SLE15

Regards,
Matthias
