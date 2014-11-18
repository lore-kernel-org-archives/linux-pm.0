From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 18 Nov 2014 11:39:47 -0800
Message-ID: <CAJAp7OgjOiKNzPxBWYPNt15QCHqMd36w5xysRXRv_2iCMFrQZQ@mail.gmail.com>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
	<1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
	<546A6962.9090801@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53241 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295AbaKRTjt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 14:39:49 -0500
Received: by mail-lb0-f169.google.com with SMTP id 10so18104975lbg.14
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2014 11:39:47 -0800 (PST)
In-Reply-To: <546A6962.9090801@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Nov 17, 2014 at 1:32 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 10/25/2014 01:40 AM, Lina Iyer wrote:
>
> Hi Lina,
>
> [ ... ]
>
>> +static inline void spm_register_write(struct spm_driver_data *drv,
>> +                                       enum spm_reg reg, u32 val)
>> +{
>> +       if (drv->reg_data->reg_offset[reg])
>> +               writel_relaxed(val, drv->reg_base +
>> +                               drv->reg_data->reg_offset[reg]);
>
>
> Why not use writel and don't use 'wmb' below ?
>

Hi Daniel,

writel() provides ordering before the write, not after. Please have a
look at the definition.

Regards,
Bjorn
