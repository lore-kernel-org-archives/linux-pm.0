From: Chander Kashyap <k.chander@samsung.com>
Subject: Re: [PATCH 0/2] cpuidle fixes and cleanup
Date: Wed, 2 Jul 2014 08:41:56 +0530
Message-ID: <CADWw7OgCgg8aE4W6LwmU3axDdmt-5uH=a+0fSSErfqDci3nNUA@mail.gmail.com>
References: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
	<20140701145244.GX32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140701145244.GX32514@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chander Kashyap <k.chander@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 1, 2014 at 8:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jul 01, 2014 at 08:02:36PM +0530, Chander Kashyap wrote:
>> This patch series fixes the cpuidle for different states. Also removes arm
>> diagnostic and power register save/restore code as it is made generic.
>>
>> Based on:
>> ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
>>  http://www.spinics.net/lists/arm-kernel/msg340506.html
>
> As there is an outstanding issue with this patch, we can't proceed with
> this set of changes until we know what's going on there.

Sure, I will wait for the conclusion.

>
> Also, bear in mind that I have changes which conflict with this in my
> tree (which I've just updated.)

I will resend after your changes are posted.

Thanks
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
