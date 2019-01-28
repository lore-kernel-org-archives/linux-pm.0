From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] devfreq: Suspend all devices on system shutdown
Date: Mon, 28 Jan 2019 12:57:25 +0100
Message-ID: <d5506b03-e035-aca9-5e01-e642c2bc5111@samsung.com>
References: <20190125135403.10228-1-m.szyprowski@samsung.com>
        <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@epcms1p4>
        <20190128080535epcms1p44636143629448c4e24a6628e87a72bf2@epcms1p4>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128080535epcms1p44636143629448c4e24a6628e87a72bf2@epcms1p4>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

Hi MyungJoo,

On 2019-01-28 09:05, MyungJoo Ham wrote:
>> This way devfreq core ensures that all its devices will be set to safe
>> operation points before reboot operation. There are board on which some
>> aggressive power saving operation points are behind the capabilities of
>> the bootloader to properly reset the hardware and boot the board. This
>> way one can avoid board crash early after reboot.
>>
>> Similar pattern is used in CPUfreq subsystem.
>>
>> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
> You are invoking ALL devfreq suspend callbacks at shutdown
> with this commit.
>
> Can you make it invoke only devices explicitly saying their needs
> to handle "SHUTDOWN" event?
>
> For example, we can add a flag at struct devfreq_dev_profile:
> "uint32_t requirement"
> , where
> 0x1: need to operate at the initial frequency for suspend
> 0x2: need to operate at the initial frequency for shutdown
> 0x4: it forgets its status at resume, reconfigure frequency at resume.
> (or reverse 0x1's semantics for the backward compatibility)

Frankly speaking this looks like an over-engineering. Switching to safe
frequency during reboot shouldn't have any negative side-effects. IMHO
such flags can be always added later, once there will be a real use case
for them.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
