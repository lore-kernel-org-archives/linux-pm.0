From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RESEND][PATCH 1/3] thermal: mediatek: Add cpu dynamic power
 cooling model.
Date: Thu, 21 Apr 2016 19:53:08 +0200
Message-ID: <CAJZ5v0h_W6CW6Z-kux-kbur_NE3XZH-hKZazXV5TX3tET-6cAg@mail.gmail.com>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
	<CAJZ5v0hpkyMCVhvYy4JzR1A5OZKs7dqDOB64aQXmjXiLM0F=BQ@mail.gmail.com>
	<57176ECF.6020705@gmail.com>
	<12007858.UuqVGafLHV@vostro.rjw.lan>
	<20160421030141.GA4845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32949 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbcDURxK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 13:53:10 -0400
In-Reply-To: <20160421030141.GA4845@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.comSascha

On Thu, Apr 21, 2016 at 5:01 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Thu, Apr 21, 2016 at 02:41:24AM +0200, Rafael J. Wysocki wrote:
>> On Wednesday, April 20, 2016 01:58:07 PM Matthias Brugger wrote:
>> > Hi Rafael,
>> >
>> > On 13/04/16 06:52, Rafael J. Wysocki wrote:
>> > > On Tue, Apr 12, 2016 at 7:38 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > >> Hi Rafael,
>> > >>
>> > >> On 15-03-16, 16:10, Dawei Chien wrote:
>> > >>> MT8173 cpufreq driver select of_cpufreq_power_cooling_register registering
>> > >>> cooling devices with dynamic power coefficient.
>> > >>>
>> > >>> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
>> > >>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > >>
>> > >> Can you please apply this patch from Dawei ?
>> > >
>> > > I can, but I'm traveling this week, so that's rather going to happen next week.
>> > >
>> >
>> > I don't see the patch in linux-next, did you forget to pick/push it?
>>
>> No, I didn't.  I just didn't have the time to get to them before.
>>
>> Now, given that they are thermal patches, they really should go in via
>> linux-soc-thermal.git.
>>
>> Eduardo, any chance to take care of these?
>
> Yes I can add this one, given that they have the proper acked-by. I was
> a bit hesitant to just get them because they are touching
> drivers/cpufreq.

Generally, ACKs from Viresh are sufficient for ARM cpufreq drivers
unless the maintainers of the platform in question disagree.

> Anyways, I am adding this to my branch to the next merge window.

Thanks!
