From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3 2/4] power: supply: core: Introduce properties to
 present the battery OCV capacity table
Date: Sun, 14 Oct 2018 14:53:19 +0800
Message-ID: <CAMz4kuKo0jZ8YS7zx-t8hESedTYb094VLzdzNOpQd04M3kE4Dw@mail.gmail.com>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
 <7dccec1694a05a524710e59a63859974b4cdae89.1538033078.git.baolin.wang@linaro.org>
 <20181012143530.GA28145@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012143530.GA28145@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 12 October 2018 at 22:35, Rob Herring <robh@kernel.org> wrote:
> On Thu, Sep 27, 2018 at 03:26:55PM +0800, Baolin Wang wrote:
>> Some battery driver will use the open circuit voltage (OCV) value to look
>> up the corresponding battery capacity percent in one certain degree Celsius.
>> Thus this patch provides some battery properties to present the OCV table
>> temperatures and OCV capacity table values. Moreover it also provides some
>> helper functions to use the OCV capacity table for users.
>>
>> Suggested-by: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes from v2:
>>  - Use type __be32 to calculate the table length.
>>  - Update error messages.
>>  - Add some helper functions.
>>
>> Changes from v1:
>>  - New patch in v2.
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   |   14 +++
>
> Please split binding patches.

Sure.

>
>>  drivers/power/supply/power_supply_core.c           |  125 +++++++++++++++++++-
>>  include/linux/power_supply.h                       |   19 +++
>>  3 files changed, 157 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 938d027..cad38df 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -23,6 +23,16 @@ Optional Properties:
>>   - constant-charge-current-max-microamp: maximum constant input current
>>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>>   - factory-internal-resistance-micro-ohms: battery factory internal resistance
>> + - ocv-capacity-table-0: An array providing the battery capacity percent
>> +   with corresponding open circuit voltage (OCV) of the battery, which
>> +   is used to look up battery capacity according to current OCV value.
>> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
>> + ......
>> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
>
> So it is tubles of (percent, voltage)? What's the units for voltage?

Yes. The units for voltage is microvolt, and I will add some words to
make it clear in next version.

>
> What determines the # of entries for each table? Do all tables have the
> same number of entries?

Not same, that depends on the battery drivers' requirement.

>> + - ocv-capacity-table-temperatures: An array containing the temperature
>> +   in degree Celsius, for each of the battery capacity lookup table.
>> +   The first temperature value specifies the OCV table 0, and the second
>> +   temperature value specifies the OCV table 1, and so on.
>
> This should have unit suffix. Perhaps just "ocv-capacity-celsius" to
> avoid being too long.

I am fine with this. Thanks for your comments.

Sebastian and Linusw, what do you think about Rob's suggestion? Thanks.

-- 
Baolin Wang
Best Regards
