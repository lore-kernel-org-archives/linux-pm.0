From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC v1 2/3] interconnect: Add Qualcomm msm8916 interconnect
 provider driver
Date: Tue, 16 May 2017 17:59:02 +0300
Message-ID: <5bd5fbd9-ee12-a414-88ce-32b286318616@linaro.org>
References: <20170515153527.27649-1-georgi.djakov@linaro.org>
 <20170515153527.27649-3-georgi.djakov@linaro.org>
 <CAMuHMdXM3f+P8ZyydxnO5z2g3F2n2c3KzfDFbC6jYgZJt+1ULw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35138 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbdEPO7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2017 10:59:06 -0400
Received: by mail-wr0-f177.google.com with SMTP id z52so78729415wrc.2
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2017 07:59:05 -0700 (PDT)
In-Reply-To: <CAMuHMdXM3f+P8ZyydxnO5z2g3F2n2c3KzfDFbC6jYgZJt+1ULw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Greg KH <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, skannan@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, seansw@qti.qualcomm.com, davidai@quicinc.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On 05/15/2017 07:01 PM, Geert Uytterhoeven wrote:
> Hi Georgi,
> 
> On Mon, May 15, 2017 at 5:35 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/interconnect_msm8916.c
> 
>> +struct qcom_interconnect_node {
>> +       struct interconnect_node node;
>> +       unsigned int id;
> 
> 4 byte gap due to alignment rules on 64-bit.
> 
>> +       unsigned char *name;
>> +       struct interconnect_node *links[8];
>> +       int num_links;
>> +       int port;
>> +       int buswidth;
> 
> 4 byte gap due to alignment rules.
> 
>> +       u64 ib;
>> +       u64 ab;
>> +       u64 rate;
>> +};
> 
> You can avoid the gaps by putting members of the same size and alignment
> together.

Thanks Geert, i will rearrange this to reduce the padding bytes!

BR,
Georgi
