From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 22 Nov 2016 18:33:26 -0800
Message-ID: <20161123023325.GB122654@google.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
 <1479818088-6007-4-git-send-email-wxt@rock-chips.com>
 <20161122205737.GB45366@google.com>
 <20161122215240.GA52900@google.com>
 <7168a98b-be91-8180-f9c0-8d54f5535075@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34243 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbcKWCd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 21:33:29 -0500
Received: by mail-pg0-f47.google.com with SMTP id x23so63522pgx.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 18:33:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7168a98b-be91-8180-f9c0-8d54f5535075@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: heiko@sntech.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, rui.zhang@intel.com

On Wed, Nov 23, 2016 at 10:06:15AM +0800, Caesar Wang wrote:
> 在 2016年11月23日 05:52, Brian Norris 写道:
> >On Tue, Nov 22, 2016 at 12:57:37PM -0800, Brian Norris wrote:

> >>>+	if (temp < table->id[low].temp || temp > table->id[high].temp)
> >>>  		goto exit;
> >I was revisiting the logic here though, and I don't understand your
> >error case. You're treating "too low" and "too high" the same, and in
> >either case, you're choosing a value of ->data_mask. That doesn't make
> >sense to me, especially for ADC_DECREMENT cases like rk3288. In that
> >case, you're programming the trip to the lowest possible temperature.
> 
> I admit that's not perfect, but that should conform to reality.
> 
> Whichever is the adc value, 12it or 10bit.
> #define TSADCV2_DATA_MASK            0xfff
> #define TSADCV3_DATA_MASK            0x3ff
> 
> The "too low" and "too high" are same, that should indicate that temperature is
> invalid or over table range.
> 
> The currect code will return the max analog value to warn it.
> ---
> 
> The temperature {-40C, 125C} is for rockchip SoCs, that should be
> similar with real world's temperature {-INT_MAX, INT_MAX}.

IIUC, "too high" should not be interpreted as TSADCV2_DATA_MASK on
rk3288, should it? That corresponds to -40C, which means you'll be
triggering the alarm temperature at a very *low* temperature, not a very
high one, no?

Brian
