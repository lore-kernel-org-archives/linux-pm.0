From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv3 2/8] devfreq: exynos: Add documentation for generic
 exynos memory bus frequency driver
Date: Wed, 21 Jan 2015 08:47:20 +0530
Message-ID: <CAKohpontEntV48XqNcJq+euT9SdEjkgn5Pa=sSUpgM8mfKKCUA@mail.gmail.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
	<1420681257-3078-3-git-send-email-cw00.choi@samsung.com>
	<CAL_Jsq+5sdsm_-VW-ta+qV-NBao-XTHvsYWcbMdZmbP0Nw43Cw@mail.gmail.com>
	<CAKohpomqosqxeDANC=NLBVmOUHyUoqd7Zhph7r6f7+ufYN48EQ@mail.gmail.com>
	<54BE108F.8090506@samsung.com>
	<CAKohpokSuVhH3hHFF+mLtJXvjt=bmJy1oZRBOttCNXORBS1Y0A@mail.gmail.com>
	<54BE3E10.2080906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:43199 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbAUDRV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jan 2015 22:17:21 -0500
Received: by mail-oi0-f52.google.com with SMTP id h136so13657579oig.11
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2015 19:17:20 -0800 (PST)
In-Reply-To: <54BE3E10.2080906@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Rob Herring <robherring2@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mark Rutland <mark.rutland@arm.com>, a.kesavan@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, InKi Dae <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On 20 January 2015 at 17:07, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> If each bus-block has separate regulator independently, each bus-block can be registered
> separately. But, exynos bus-blocks in mem-bus-group share the same regulator.

This can be managed easily within the driver. Just stay the highest
voltage requested.
I don't think its not manageable. But it will be much more convenient
as that will show
the correct picture and get rid of unnecessarily virtualizing things..

--
viresh
