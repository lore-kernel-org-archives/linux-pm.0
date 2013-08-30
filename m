From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/3] thermal: ti-soc-thermal: Initialize counter_delay
 field for TI DRA752 sensors
Date: Fri, 30 Aug 2013 16:42:05 +0800
Message-ID: <1377852125.2652.3.camel@rzhang-lenovo>
References: <1377274103-27770-1-git-send-email-ranganath@ti.com>
	 <521F3C49.3020402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43143 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab3H3Ikm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Aug 2013 04:40:42 -0400
In-Reply-To: <521F3C49.3020402@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Ranganath Krishnan <ranganath@ti.com>, linux-pm@vger.kernel.org, Praneeth Bajjuri <praneeth@ti.com>

On =E5=9B=9B, 2013-08-29 at 08:19 -0400, Eduardo Valentin wrote:
> On 23-08-2013 12:08, Ranganath Krishnan wrote:
> > Initialize MPU, GPU, CORE, DSPEVE and IVA thermal sensors of DRA752=
 bandgap
> > with the counter delay mask.
> >=20
> > Signed-off-by: Ranganath Krishnan <ranganath@ti.com>
>=20
>=20
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
>=20
are you going to take this patch series?

thanks,
rui
> > ---
> >  .../thermal/ti-soc-thermal/dra752-thermal-data.c   |    5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b=
/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> > index e5d8326..a492927 100644
> > --- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> > +++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> > @@ -42,6 +42,7 @@ dra752_core_temp_sensor_registers =3D {
> >  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_CORE_MASK,
> >  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_CORE_MASK,
> >  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> > +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_=
MASK,
> >  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK,
> >  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_CORE_MASK,
> >  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_CORE=
_MASK,
> > @@ -77,6 +78,7 @@ dra752_iva_temp_sensor_registers =3D {
> >  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_2_MASK_HOT_IVA_MASK,
> >  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_2_MASK_COLD_IVA_MASK,
> >  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> > +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_=
MASK,
> >  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK,
> >  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_IVA_MASK,
> >  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_IVA_=
MASK,
> > @@ -112,6 +114,7 @@ dra752_mpu_temp_sensor_registers =3D {
> >  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_MPU_MASK,
> >  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_MPU_MASK,
> >  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> > +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_=
MASK,
> >  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK,
> >  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_MPU_MASK,
> >  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_MPU_=
MASK,
> > @@ -147,6 +150,7 @@ dra752_dspeve_temp_sensor_registers =3D {
> >  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_2_MASK_HOT_DSPEVE_MASK,
> >  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_2_MASK_COLD_DSPEVE_MASK,
> >  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> > +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_=
MASK,
> >  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK,
> >  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_DSPEVE_MASK,
> >  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_DSPE=
VE_MASK,
> > @@ -182,6 +186,7 @@ dra752_gpu_temp_sensor_registers =3D {
> >  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_GPU_MASK,
> >  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_GPU_MASK,
> >  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> > +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_=
MASK,
> >  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK,
> >  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_GPU_MASK,
> >  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_GPU_=
MASK,
> >=20
>=20
>=20


