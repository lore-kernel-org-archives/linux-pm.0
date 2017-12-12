From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 1/3] interconnect: Add generic on-chip interconnect API
Date: Tue, 12 Dec 2017 17:46:53 +0200
Message-ID: <3e94a4fa-d3b6-488c-7247-f769cec2ab82@linaro.org>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
 <20170908171830.13813-2-georgi.djakov@linaro.org>
 <CAHLCerOgm+T6S1pxjo5hFajyU+vqUgBFcwfuBCsphgECRMf3Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42672 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdLLPq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 10:46:57 -0500
Received: by mail-wr0-f194.google.com with SMTP id s66so21623511wrc.9
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2017 07:46:56 -0800 (PST)
In-Reply-To: <CAHLCerOgm+T6S1pxjo5hFajyU+vqUgBFcwfuBCsphgECRMf3Yw@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, robh+dt@kernel.org, khilman@baylibre.com, Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, seansw@qti.qualcomm.com, davidai@quicinc.com, LKML <linux-kernel@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi Amit,

On 12/08/2017 08:38 PM, Amit Kucheria wrote:
> On Fri, Sep 8, 2017 at 10:48 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>> This patch introduce a new API to get requirements and configure the
>> interconnect buses across the entire chipset to fit with the current demand.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) between endpoints and
>> set the desired constraints on this data flow path. The providers receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

[..]

>> +inline int interconnect_set(struct interconnect_path *path,
>> +                           struct interconnect_creq *creq);
> 
> Remove the semi colon

Thanks! Fixed.

> 
>> +{
>> +       return -ENOTSUPP
> 
> return ERR_PTR(-ENOTSUPP);

I do not agree here. It should be left as is, because the function
returns int.

> 
>> +}
>> +
> 
> This breaks the build with INTERCONNECT disabled in Kconfig.

Ok, i have fixed this as well.

Thanks,
Georgi
