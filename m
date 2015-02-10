From: Chris Zhong <zyw@rock-chips.com>
Subject: Re: [PATCH 2/2] power: gpio-charger: support disable the wakeup event
Date: Tue, 10 Feb 2015 18:50:32 +0800
Message-ID: <54D9E278.2030205@rock-chips.com>
References: <1423555945-24289-1-git-send-email-zyw@rock-chips.com>	<1423555945-24289-3-git-send-email-zyw@rock-chips.com> <CALT56yO5JNB7bucSn53wcnoUWFzkLCCpWe13JhsG1ty7L5v3zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALT56yO5JNB7bucSn53wcnoUWFzkLCCpWe13JhsG1ty7L5v3zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: heiko@sntech.de, dianders@chromium.org, dtor@chromium.org, djkurtz@chromium.org, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 02/10/2015 04:42 PM, Dmitry Eremin-Solenikov wrote:
> Hello,
>
> 2015-02-10 11:12 GMT+03:00 Chris Zhong <zyw@rock-chips.com>:
>> Support disable the wakeup event of gpio-charger by setting device tree.
> I have the feelink, that this should be a userspace setting, rather than
> a kernel/device-tree policy. In the end, the device tree is a hardware
> description
> and a hardware is capable of waking up the device.
Ah, you are right, I think I should modify it in userspace.
Thank you.
>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>
