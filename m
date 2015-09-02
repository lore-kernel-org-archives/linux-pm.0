From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
Date: Wed, 2 Sep 2015 14:45:56 +0800
Message-ID: <CAGS+omAtiALWTjVJS4wNatXVLqZRSOk3m29QQvW=fQWs7Hs5ng@mail.gmail.com>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150826021659.GD8784@linux> <CALx668V2herrp6XOtCDR7nNvFhd7DLLMjXmr86cjfCOQ_cgmrw@mail.gmail.com>
 <22538895.vrRgZUmQTV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22538895.vrRgZUmQTV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Pi-Cheng Chen <pi-cheng.chen@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Matthias,

On Fri, Aug 28, 2015 at 10:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, August 26, 2015 02:53:39 PM Pi-Cheng Chen wrote:
>> On Wed, Aug 26, 2015 at 10:16 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 26-08-15, 09:25, Pi-Cheng Chen wrote:
>> >> The [3/3] is based on Mediatek SoC maintainer tree[1] and the patch which
>> >> introduce a new clock type[2] consumed by MT8173 cpufreq driver. So it will
>> >> cause some conflicts if it goes through your tree. I am not sure how this
>> >> should be handled, but should it be merged through Mediatek SoC maintainer
>> >> tree?
>> >
>> > Just get that applied to MTK tree, it doesn't have any dependency on
>> > rest of the patches for build/boot. The only thing is that cpufreq
>> > wouldn't work and it will work as soon as Rafael's and MTK's trees are
>> > merged by Linus.
>>
>> Thanks for your explanation.
>>
>> @Rafael, Would you please apply [1,2] to your tree?
>
> Applied, thanks!

Can you please apply [3] from this set to your dts tree?

> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
