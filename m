From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v9 1/5] thermal: rockchip: add driver for thermal
Date: Tue, 14 Oct 2014 22:03:00 +0800
Message-ID: <543D2D14.7000706@rock-chips.com>
References: <1413012563-7690-1-git-send-email-caesar.wang@rock-chips.com>	<1413012563-7690-2-git-send-email-caesar.wang@rock-chips.com> <CAD=FV=XHe65wwf8Q9RA0ZDgb5oQLdyjuZDFy4mD01_t6G6WnHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=XHe65wwf8Q9RA0ZDgb5oQLdyjuZDFy4mD01_t6G6WnHQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Arnd Bergmann <arnd@arndb.de>, zyf <zyf@rock-chips.com>, linux-rockchip@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Eddie Cai <cf@rock-chips.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Derek Basehore <dbasehore@chromium.org>, Tao Huang <huangtao@rock-chips.com>, =?UTF-8?B?6ZmI5riQ6aOe?= <cjf@rock-chips.com>, Shunqian Zheng <zhengsq@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Doug,

=E5=9C=A8 2014=E5=B9=B410=E6=9C=8814=E6=97=A5 00:11, Doug Anderson =E5=86=
=99=E9=81=93:
> Caesar,
>
> On Sat, Oct 11, 2014 at 12:29 AM, Caesar Wang
> <caesar.wang@rock-chips.com> wrote:
>
>> +static void rk_tsadcv2_initialize(int reset_mode, int chn, void __i=
omem *regs,
>> +                                 unsigned long hw_shut_temp)
>> +{
>> +       u32 shutdown_value;
>> +
>> +       shutdown_value =3D rk_tsadcv2_temp_to_code(hw_shut_temp);
>> +
>> +       /* Enable measurements at ~ 10 Hz */
>> +       writel_relaxed(0 | TSADCV2_AUTO_TSHUT_POLARITY_HIGH, regs +
>> +                      TSADCV2_AUTO_CON);
>> +       writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO=
_PERIOD);
>> +       writel_relaxed(TSADCV2_AUTO_PERIOD_HT_TIME, regs +
>> +                      TSADCV2_AUTO_PERIOD_HT);
>> +       writel_relaxed(shutdown_value, regs + TSADCV2_COMP_SHUT(chn)=
);
>> +       writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_TIME, regs +
>> +                      TSADCV2_HIGHT_INT_DEBOUNCE);
>> +       writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_TIME, regs +
>> +                      TSADCV2_HIGHT_TSHUT_DEBOUNCE);
>> +
>> +       if (reset_mode =3D=3D GPIO)
>> +               writel_relaxed(TSADCV2_SHUT_2GPIO_SRC_EN(chn) |
>> +                              TSADCV2_INT_SRC_EN(chn), regs +
>> +                              TSADCV2_INT_EN);
>> +       else
>> +               writel_relaxed(TSADCV2_SHUT_2CRU_SRC_EN(chn) |
>> +                              TSADCV2_INT_SRC_EN(chn) , regs +
>> +                              TSADCV2_INT_EN);
>> +
>> +       writel_relaxed(TSADCV2_AUTO_SRC_EN(chn) | TSADCV2_AUTO_EN, r=
egs +
>> +                      TSADCV2_AUTO_CON);
> Aren't you clobbering the polarity here?
>
> NOTE: I didn't do a full review of this driver, just noticed that
> while looking at another patch and figure'd I'd respond here, too.
>
=46ixed. Maybe I should fix as follows:

/**
  * rk_tsadcv2_get_tshut_polarity - get the tshut polarity
  * the bit 8 is tshut polarity,default is low active.
  * 0: low active, 1: high active
  */
static bool rk_tsadcv2_get_tshut_polarity(void __iomem *regs)
{
     u32 val;
     bool tshut_polarity;

     val =3D readl_relaxed(regs + TSADCV2_AUTO_CON);
     tshut_polarity =3D (val & BIT(8))? 1 : 0;

     return tshut_polarity;
}
=2E..
=2E...

writel_relaxed(TSADCV2_AUTO_SRC_EN(chn) & (tshut_polarity << 8) |
		       TSADCV2_AUTO_EN, regs + TSADCV2_AUTO_CON);

>

--=20
Best regards,
Caesar


