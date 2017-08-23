From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 3/3] cpufreq: dt: add support for rockchip rv1108
Date: Wed, 23 Aug 2017 08:49:31 +0800
Message-ID: <9923a1d0-2794-834b-855e-4131287e4b75@rock-chips.com>
References: <1503407515-13943-1-git-send-email-andy.yan@rock-chips.com>
 <1503407722-14056-1-git-send-email-andy.yan@rock-chips.com>
 <1949899.3GLvcOh6S6@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:39305 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752913AbdHWAth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 20:49:37 -0400
In-Reply-To: <1949899.3GLvcOh6S6@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Rafael:


On 2017年08月22日 21:44, Rafael J. Wysocki wrote:
> On Tuesday, August 22, 2017 3:15:22 PM CEST Andy Yan wrote:
>> Add the compatible string to support the generic device tree
>> cpufreq-dt driver on rockchip rv1108 soc.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> This is a [3/3] in a series, so presumably it depends on something, so I guess
> it should be applied along with the thing it depends on.  Right?

     The other two are dts parts [1] [2], they have been taken to 
arm-soc by Heiko.
And Heiko also gave a Reviewed-by for this patch in v1[3].

     [1] https://patchwork.kernel.org/patch/9915139/
     [2] https://patchwork.kernel.org/patch/9915145/
     [3] https://patchwork.kernel.org/patch/9911907/
>
> Thanks,
> Rafael
>
>
>
>
