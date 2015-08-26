From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
Date: Wed, 26 Aug 2015 09:25:29 +0800
Message-ID: <CALx668UvkYhLoU8rxLG70RqTzsnaiV5-ybDYTKqb4MEJS8pmRw@mail.gmail.com>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
	<CALx668VWg2xVxzy8P7f5QFWRzm+TDJXUghL-_rbvRLsLYjtnng@mail.gmail.com>
	<1617873.VRHfat3V76@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34242 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220AbbHZBZa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2015 21:25:30 -0400
Received: by ykdt205 with SMTP id t205so172932747ykd.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2015 18:25:29 -0700 (PDT)
In-Reply-To: <1617873.VRHfat3V76@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org

Hi Rafael,

On Wed, Aug 26, 2015 at 7:01 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, August 25, 2015 10:10:44 AM Pi-Cheng Chen wrote:
>> On Mon, Aug 17, 2015 at 5:24 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> > MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
>> > share the same power and clock domain. This series tries to add cpufreq support
>> > for MT8173 SoC. The v6 of this series is resent with Acks added.
>>
>> Hi Rafael,
>>
>> Not sure if I has missed the merge window.
>> Do I have chance to have this series merged for 4.3?
>
> Yes, it should make it.
>
>> Would you please take [1,2] of this series?

Thanks.

>
> I'm not sure what you mean.  Are you withdrawing the [3/3]?

The [3/3] is based on Mediatek SoC maintainer tree[1] and the patch which
introduce a new clock type[2] consumed by MT8173 cpufreq driver. So it will
cause some conflicts if it goes through your tree. I am not sure how this
should be handled, but should it be merged through Mediatek SoC maintainer
tree?

@Matthias?

Thanks

Best Regards,
Pi-Cheng

[1] https://github.com/mbgg/linux-mediatek.git v4.2-next/arm64
[2] http://article.gmane.org/gmane.linux.kernel/2021379

>
> Thanks,
> Rafael
>
