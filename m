From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 1/2] thermal: tsens: Add support for SDM845 platform
Date: Tue, 12 Jun 2018 13:39:49 +0300
Message-ID: <CAHLCerPOp7_60JF-jJ+wZR9jq-z_wypheE=g_GV7Nn=M2OCP5Q@mail.gmail.com>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
 <7a0f33cff94f41110bdbff14d28d36074fae2a7d.1527937396.git.amit.kucheria@linaro.org>
 <20180604150319.GC510@tuxbook-pro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180604150319.GC510@tuxbook-pro>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 4, 2018 at 6:03 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Sat 02 Jun 04:11 PDT 2018, Amit Kucheria wrote:
>> diff --git a/drivers/thermal/qcom/tsens-sdm845.c b/drivers/thermal/qcom/tsens-sdm845.c
> [..]
>> +#define TRDY_OFFSET     0xe4
>> +#define TRDY_READY_BIT  BIT(1)
>
> This is bit 0.

Oops, fixed.

>> +
>> +#define STATUS_OFFSET        0xa0
>> +#define LAST_TEMP_MASK       0xfff
>> +#define STATUS_VALID_BIT     BIT(21)
>> +#define CODE_SIGN_BIT                BIT(11)
>> +
>> +static int get_temp_sdm845(struct tsens_device *tmdev, int id, int *temp)
>> +{
>> +     struct tsens_sensor *s = &tmdev->sensor[id];
>> +     u32 code;
>> +     unsigned int sensor_addr;
>> +     int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
>> +
>> +     ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
>> +     if (ret)
>> +             return ret;
>> +     if (code & TRDY_READY_BIT)
>> +             return -ENODATA;
>
> This section is the only difference from 8996, but this register is
> identical to 8996 and 8998. So I think you should add this to
> tsens-8996.c and we can use that for 8996, 8998 and sdm845.
>
> Perhaps we should name it tsens-v2, as that seems to be the common
> denominator for these, according to the documentation.

Thanks for confirming that the block is identical^Wsimilar across
8996, 8998, sdm845 (and possible others). I suspected as much but
didn't check in a lot of detail.

I expected the 845 to gain more features over time, hence the reason
for a separate file and a custom get_temp(). Now, I'll fold all of
them into a common tsens-v2 function.

We'll also need to change how we regmap the 8998 and sdm845 tsens
registers because the offsets are not the same and hence not handled
corrently by tsens-common.c/init_common().
