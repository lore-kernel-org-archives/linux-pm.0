From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
Date: Wed, 9 Jan 2013 16:55:37 +0530
Message-ID: <CAKohpo=UdnMrrTWHdC9qor+gmqJp9dCp_GV=1wDjsUqhNZwwpA@mail.gmail.com>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
	<1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
	<CAOh2x=mv9_iWt+y9cP0oA4WKs86Ne9nRP6CgKy_1COnPm57YOA@mail.gmail.com>
	<20130108143554.GC19534@S2101-09.ap.freescale.net>
	<CAKohpomQuoUgPVp6e9_UrK0sk+z26cG36DoxH91LWSmBHD36BQ@mail.gmail.com>
	<20130108150357.GD19534@S2101-09.ap.freescale.net>
	<CAKohpo=yahfREsWvCPN6BjoxiifKZWCM19-mLEvao0e4UCT6Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:39604 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757344Ab3AILZj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jan 2013 06:25:39 -0500
Received: by mail-ob0-f179.google.com with SMTP id x4so2073654obh.10
        for <linux-pm@vger.kernel.org>; Wed, 09 Jan 2013 03:25:38 -0800 (PST)
In-Reply-To: <CAKohpo=yahfREsWvCPN6BjoxiifKZWCM19-mLEvao0e4UCT6Vg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Sascha Hauer <s.hauer@pengutronix.de>

On 8 January 2013 20:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 8 January 2013 20:34, Shawn Guo <shawn.guo@linaro.org> wrote:
>> I'm seeing that the .init() will be called on cpu1 when removing the
>> module.
>
> Hmm... Can you give me sometime to think about how to fix that?
> You can go ahead with keeping this change in v2.

Hi Shawn,

I have sent a fix for this and cc'd you. Can you please give it a try?

cpufreq: Simplify __cpufreq_remove_dev()

patches are present here.

http://git.linaro.org/gitweb?p=arm/big.LITTLE/mp.git;a=shortlog;h=refs/heads/cpufreq-fixes-v2
