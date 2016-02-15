From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Mon, 15 Feb 2016 10:14:12 +0800
Message-ID: <CAGS+omArr0_-ziBXWjEcKS0bqnruNzZc2aq2s3zkghUC7_HfGw@mail.gmail.com>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
 <20151217193332.GB7999@localhost.localdomain> <20160104141940.GI13058@pengutronix.de>
 <20160119072917.GA13237@pengutronix.de> <1454295246.22151.6.camel@mtksdaap41> <CAGS+omD9U8tKmb02d_gMMAGX18MJZhz0RrugpBK2EuqgZrBy6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33021 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbcBOCOc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Feb 2016 21:14:32 -0500
Received: by mail-vk0-f46.google.com with SMTP id k196so97451050vka.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Feb 2016 18:14:32 -0800 (PST)
In-Reply-To: <CAGS+omD9U8tKmb02d_gMMAGX18MJZhz0RrugpBK2EuqgZrBy6g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 15, 2016 at 10:11 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi Eduardo, Sascha,
>
> On Mon, Feb 1, 2016 at 10:54 AM, Eddie Huang <eddie.huang@mediatek.com> wrote:
>>
>> On Tue, 2016-01-19 at 15:29 +0800, Sascha Hauer wrote:
>> > Eduardo,
>> >
>> > On Mon, Jan 04, 2016 at 03:19:40PM +0100, Sascha Hauer wrote:
>> > > Hi Eduardo,
>> > >
>> > > >
>> > > > That should remove the policy of computing the maximum from this driver.
>> > > > Please have a look on the work being done [1] to add grouping and
>> > > > aggregation of thermal zones. With that in place, you should be a matter
>> > > > of configuring the grouping and selecting max as the aggregation function,
>> > > > from the thermal core, instead in the driver. Which should give the
>> > > > system engineer, more flexibility to compose whatever policy based on
>> > > > the exposed sensors.
>> > >
>> > > I think the aggregation of thermal zones is quite useful when it comes
>> > > to putting different chips together to a system. I am not so sure how
>> > > useful it is to expose different thermal zones of a single SoC to the
>> > > device tree.
>> > > Currently the only control knob we have is the CPU frequency. When any
>> > > of the sensors on the SoC gets too hot then the only thing we can do is
>> > > to decrease the CPU frequency. This does not leave much space for
>> > > configuration in the device tree.
>> > > What I need to be able is to attach multiple sensors to one thermal
>> > > zone. The aggregation patch series only partly solves that and I think
>> > > is inconsistent, but I commented on the series directly.
>> >
>> > Any input on this? I really like to get this driver upstream as it is
>> > currently blocking other Mediatek drivers.
>> >
>>
>> Hi Eduardo,
>>
>> Do you have any comment about Sascha's response ? We really hope get
>> your comment since Mediatek thermal driver already reviewed in public
>> over half years, and we have other patches [0] [1] depend on thermal
>> driver.
>>
>> [0]:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394084.html
>> [1]:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401055.html
>
> Friendly ping on the Mediatek thermal driver.
> The "EFUSE" dependency has now landed in v4.5-rc4.

Actually, it landed in char-misc-next, not v4.5-rc4.

> So, AFAICT, the only thing left that may be blocking landing Mediatek
> thermal driver is resolution of this discussion about thermal zones.
> Can we kindly resolve this soon so we have a chance to land it in v4.6.
>
> Thanks,
> -Dan
