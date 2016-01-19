From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] power: Add support for TI BQ24261 charger
Date: Tue, 19 Jan 2016 09:02:32 +0200
Message-ID: <CAHp75VcBAHg3trt45xVr6m9ppDyv+TSZEEVsWra3QVRWGKfC1g@mail.gmail.com>
References: <1446136455-20752-1-git-send-email-ramakrishna.pallala@intel.com>
	<1446136455-20752-3-git-send-email-ramakrishna.pallala@intel.com>
	<CAHp75Vde8ZFXZC9SzKSaXS8TThJd1u=+UMHPOiTWZvY1P4xKqw@mail.gmail.com>
	<D854C92F57B1B347B57E531E78D05EAD57A22F3D@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D854C92F57B1B347B57E531E78D05EAD57A22F3D@BGSMSX104.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 19, 2016 at 3:26 AM, Pallala, Ramakrishna
<ramakrishna.pallala@intel.com> wrote:
>> On Thu, Oct 29, 2015 at 6:34 PM, Ramakrishna Pallala
>> <ramakrishna.pallala@intel.com> wrote:
>> > Add new charger driver support for TI BQ24261 charger IC.
>> >
>> > TI BQ24261 charger driver relies on extcon notifications to get the
>> > charger cable type and based on that it will set the charging parameters.

>> > +/* BQ24261 registers */
>> > +#define BQ24261_STAT_CTRL0_ADDR                0x00
>> > +#define BQ24261_CTRL_ADDR              0x01
>> > +#define BQ24261_BATT_VOL_CTRL_ADDR     0x02
>> > +#define BQ24261_VENDOR_REV_ADDR                0x03
>> > +#define BQ24261_TERM_FCC_ADDR          0x04
>> > +#define BQ24261_VINDPM_STAT_ADDR       0x05
>> > +#define BQ24261_ST_NTC_MON_ADDR                0x06
>> > +
>> > +#define BQ24261_RESET_ENABLE           BIT(7)
>> > +
>>
>> Might be a good idea to put comment line preceded each group to refer which
>> register it covers.
> Ok.
>
>>
>> > +#define BQ24261_FAULT_MASK             GENMASK(2, 0)
>>
>> Either use GENMASK in each case, or put plain number.
>>
> Ok.

Looking to your definitions again I can say that GENMASK is more
readable. Regarding to BIT() macro you have to do smart choice in each
case separately.

-- 
With Best Regards,
Andy Shevchenko
