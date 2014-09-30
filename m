From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v2] thermal: Add QPNP PMIC temperature alarm driver
Date: Tue, 30 Sep 2014 10:36:46 +0300
Message-ID: <1412062606.5395.10.camel@iivanov-dev>
References: <1411651825-14240-1-git-send-email-iivanov@mm-sol.com>
	  <54254C4E.3070807@smartplayin.com> <1411998865.5395.5.camel@iivanov-dev>
	 <542A31DF.7020402@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <542A31DF.7020402@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kiran Padwal <kiran.padwal@smartplayin.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-09-30 at 10:00 +0530, Kiran Padwal wrote:
> On Monday 29 September 2014 07:24 PM, Ivan T. Ivanov wrote:
> > On Fri, 2014-09-26 at 16:51 +0530, Kiran Padwal wrote:
> >> On Thursday 25 September 2014 07:00 PM, Ivan T. Ivanov wrote:
> >>> Add support for the temperature alarm peripheral found inside
> >>> Qualcomm plug-and-play (QPNP) PMIC chips.  The temperature alarm
> >>> peripheral outputs a pulse on an interrupt line whenever the
> >>> thermal over temperature stage value changes.  Implement an ISR
> >>> to manage this interrupt.
> >>>
> >>
> >> <snip>
> >>
> >>> + * This function updates the internal temp value based on the
> >>> + * current thermal stage and threshold as well as the previous s=
tage
> >>> + */
> >>> +static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
> >>> +{
> >>> +	unsigned int stage;
> >>> +	int rc;
> >>> +	u8 reg;
> >>> +
> >>> +	rc =3D qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> >>> +	if (rc < 0)
> >>> +		return rc;
> >>> +
> >>> +	stage =3D reg & STATUS_STAGE_MASK;
> >>
> >> During compilation, getting a waring as below,
> >>
> >> drivers/thermal/qpnp-temp-alarm.c: In function =E2=80=98qpnp_tm_up=
date_temp_no_adc=E2=80=99:
> >> drivers/thermal/qpnp-temp-alarm.c:135:8: warning: =E2=80=98reg=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>   stage =3D reg & STATUS_STAGE_MASK;
> >=20
> > Could you share compiler version and options which you are using.
> > I am unable to trigger this warning. Looking code I can not=20
> > see how this could happen.
>=20
> I have Linaro cross tool chain with version-4.8.3 and I am simply doi=
ng "make zImage" without any option.

Hm, no warnings with arm-unknown-linux-gnueabi-gcc (GCC) 4.6.3 and
arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.9-2014.09, but
indeed arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.8-2014.03.

I will say that this is false positive :-). Please update your tool-cha=
in.

Regards,
Ivan
