From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 22 Nov 2016 20:36:43 -0800
Message-ID: <20161123043642.GA28948@google.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
 <1479818088-6007-4-git-send-email-wxt@rock-chips.com>
 <20161122205737.GB45366@google.com>
 <20161122215240.GA52900@google.com>
 <7168a98b-be91-8180-f9c0-8d54f5535075@rock-chips.com>
 <20161123023325.GB122654@google.com>
 <b2736d4e-120e-cbb9-3371-838c8f36c752@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35060 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755463AbcKWEhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 23:37:12 -0500
Received: by mail-pg0-f42.google.com with SMTP id p66so1241930pga.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 20:36:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b2736d4e-120e-cbb9-3371-838c8f36c752@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: heiko@sntech.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, rui.zhang@intel.com

On Wed, Nov 23, 2016 at 11:03:33AM +0800, Caesar Wang wrote:
> 在 2016年11月23日 10:33, Brian Norris 写道:
> >IIUC, "too high" should not be interpreted as TSADCV2_DATA_MASK on
> >rk3288, should it? That corresponds to -40C, which means you'll be
> >triggering the alarm temperature at a very *low* temperature, not a very
> >high one, no?
> 
> The "too high" will correspond to -40C on rk3288, but shouldn't
> trigger the alarm temperature.
> 
> Due to the alarm or tshut function will handle it.
> 
> e.g.:
> static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
>                   int chn, void __iomem *regs, int temp)
> {
>     u32 alarm_value, int_en;
> 
>     /* Make sure the value is valid */
>     alarm_value = rk_tsadcv2_temp_to_code(table, temp);
>     if (alarm_value == table->data_mask)
>         return;

Ah, right. I keep forgetting about this odd error handling.

That's still the wrong error handling though; the right response is
never to avoid doing anything (and therefore returning "success" to the
thermal core). You need to either program a high (or low) trip value, or
else report an error (i.e., allow rk_tsadcv2_alarm_temp() to return an
error code back to the calling function). Otherwise, this:

echo -45000 > trip_0_temp

will succeed without error, and:

cat trip_0_temp
-45000

will return the cached temperature from of-thermal, even though the trip
point is programmed to something else entirely.

Brian
