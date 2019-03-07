From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: Suspend all devices on system shutdown
Date: Thu, 7 Mar 2019 10:27:02 +0900
Message-ID: <5621c652-6786-6bbb-ffbd-71567d8d882e@samsung.com>
References: <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@eucas1p2.samsung.com>
        <20190125135403.10228-1-m.szyprowski@samsung.com>
        <20190306231014.GE7915@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306231014.GE7915@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

On 19. 3. 7. 오전 8:10, Pavel Machek wrote:
> On Fri 2019-01-25 14:54:03, Marek Szyprowski wrote:
>> This way devfreq core ensures that all its devices will be set to safe
>> operation points before reboot operation. There are board on which some
>> aggressive power saving operation points are behind the capabilities of
>> the bootloader to properly reset the hardware and boot the board. This
>> way one can avoid board crash early after reboot.
>>
>> Similar pattern is used in CPUfreq subsystem.
> 
> This looks somehow dangerous to me. I guess this will break someone's
> shutdown, and on battery-powered devices, that's quite bad thing to
> do.

This patch executes the devfreq_suspend() for all devfreq devices.
The devfreq_suspend() does the following:
	1. (mandatory) stop the polling of governor.
	2. (optional)  If devfreq device specifies the 'opp-suspend'
	property in DT, the devfreq changes the frequency by using
	the devfreq->suspend_freq.

If the user of devfreq device doesn't want to change the frequency
during the system shutdown, just don't add the 'opp-suspend' property
in DT. And the devfreq_suspend() will just stop the polling for governor.

Even if on battery-powered devices, I think it is not problem
to stop the polling of governor during the system shutdown.

In my case, I don't know what is dangerous.
Could you explain it more detailed.

> 
> Could we explicitely do it only for devices that need it?
> 								Pavel
> 								
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
