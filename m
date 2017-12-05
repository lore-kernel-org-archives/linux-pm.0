From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal/drivers/hisi: disable multi alarm support for
 hi3660 SoC
Date: Mon, 4 Dec 2017 18:02:13 -0800
Message-ID: <20171205020212.GB4949@localhost.localdomain>
References: <20171017043941.GE7954@localhost.localdomain>
 <1508318150-108444-1-git-send-email-kevin.wangtao@hisilicon.com>
 <9685721b-4593-029b-b8e8-d721526b7119@linaro.org>
 <6f39a5ed-0db6-4600-19d0-f9e9c5c43b1f@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:46525 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLECCS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Dec 2017 21:02:18 -0500
Content-Disposition: inline
In-Reply-To: <6f39a5ed-0db6-4600-19d0-f9e9c5c43b1f@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, Kevin Wangtao <kevin.wangtao@linaro.org>

Hello,

On Thu, Oct 19, 2017 at 09:31:24AM +0800, Wangtao (Kevin, Kirin) wrote:
> 
> 
> 在 2017/10/18 23:54, Daniel Lezcano 写道:
> >On 18/10/2017 11:15, Tao Wang wrote:
> >>From: Kevin Wangtao <kevin.wangtao@linaro.org>
> >>
> >>multi alarm interrupt forced a re-trigger of power_allocator_throttle
> >>which changes the PID's actual sampling rate, this isn't optimal for
> >>IPA, it is best to disable multi alarm support now and sort out this
> >>issue later.
> >>
> >>Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
> >
> >Did you test the series with this change?
> Yes

Is this patch still valid with the latest linus master?
