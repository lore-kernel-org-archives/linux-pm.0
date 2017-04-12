From: Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Subject: Re: [PATCH v1 1/7] mfd: intel_soc_pmic_bxtwc: fix TMU interrupt index
Date: Wed, 12 Apr 2017 10:59:19 -0700
Message-ID: <CAENHMvO7KYFcEvGeCnA9bBYC3qTn7o8f1B6-maS5Z6n_d1Z=DQ@mail.gmail.com>
References: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170412104551.g2xkpihz2n2hju4m@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35963 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbdDLR7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 13:59:20 -0400
In-Reply-To: <20170412104551.g2xkpihz2n2hju4m@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, Andy Shevchenko <andy@infradead.org>, Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Lee,

Thanks. Will remove the code segment in next version.

On Wed, Apr 12, 2017 at 3:45 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 10 Apr 2017, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel=
.com>
>>
>> TMU interrupts are registered as a separate interrupt chip, and
>> hence it should start its interrupt index(BXTWC_TMU_IRQ) number
>> from 0. But currently, BXTWC_TMU_IRQ is defined as part of enum
>> bxtwc_irqs_level2 and its index value is 11. Since this index
>> value is used when calculating .num_irqs of regmap_irq_chip_tmu,
>> it incorrectly reports number of irqs as 12 instead of actual
>> value of 1.
>>
>> static const struct regmap_irq bxtwc_regmap_irqs_tmu[] =3D {
>>       REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
>> };
>>
>> static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu =3D {
>>       .name =3D "bxtwc_irq_chip_tmu",
>>       .status_base =3D BXTWC_TMUIRQ,
>>       .mask_base =3D BXTWC_MTMUIRQ,
>>       .irqs =3D bxtwc_regmap_irqs_tmu,
>>       .num_irqs =3D ARRAY_SIZE(bxtwc_regmap_irqs_tmu),
>>       .num_regs =3D 1,
>> };
>>
>> This patch fixes this issue by creating new enum of tmu irqs and
>> resetting its starting index to 0.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@li=
nux.intel.com>
>> ---
>>  drivers/mfd/intel_soc_pmic_bxtwc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Patch looks fine, but please remove the code segment from the commit
> log.
>
> For the code:
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
>> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_=
pmic_bxtwc.c
>> index 699c8c7..bb18e20 100644
>> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
>> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
>> @@ -94,7 +94,10 @@ enum bxtwc_irqs_level2 {
>>       BXTWC_GPIO0_IRQ,
>>       BXTWC_GPIO1_IRQ,
>>       BXTWC_CRIT_IRQ,
>> -     BXTWC_TMU_IRQ,
>> +};
>> +
>> +enum bxtwc_irqs_tmu {
>> +     BXTWC_TMU_IRQ =3D 0,
>>  };
>>
>>  static const struct regmap_irq bxtwc_regmap_irqs[] =3D {
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Sathya
