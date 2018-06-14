From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 4/5] thermal: tsens: Add support for SDM845
Date: Thu, 14 Jun 2018 13:24:28 +0300
Message-ID: <CAHLCerOn=_29CAx0sdmyxt62duWOb5LfUvrAcWf7bBsE8OR_1g@mail.gmail.com>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
 <CAFp+6iEnep3ogEkdfmaSOn_2w+09huae2NOwBF1o7-vn3iQMCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFp+6iEnep3ogEkdfmaSOn_2w+09huae2NOwBF1o7-vn3iQMCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: open list <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 14, 2018 at 9:48 AM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Hi Amit,
>
> On Tue, Jun 12, 2018 at 4:24 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> SDM845 uses the TSENS v2 IP block
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---

<snip>

>> +
>> +static const struct tsens_ops ops_sdm845 = {
>> +       .init           = init_common,
>> +       .get_temp       = get_temp_tsens_v2,
>> +};
>> +
>> +const struct tsens_data data_sdm845 = {
>
> Just a minor nit. 'static' here?

Thanks for the review.

This file just went away in favour of a common tsens-v2.c that will
support all v2 SoCs. I'll be sending out an updated patchset soon.

>
>> +       .ops            = &ops_sdm845,
>> +};
>
> [snip]
>
> Thanks & Regards
> Vivek
