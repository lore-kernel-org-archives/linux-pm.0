Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BA41A4FF;
	Mon, 27 Jul 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164474; cv=none; b=WG/hur06nQqfe10Tz9p6RFwpSSPfPonp4lHOSyF+NazcRao0pusV7uix8b8k5W1gpbyA64vxdM2J515G3JQdMbQf7lOGyPn14c32UDmnJE0Rq4LJ1VBUX+V453f0NS1gkxLntSs4XTNA0F43qyak04NDrAVfetnFFBIvWDWG4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164474; c=relaxed/simple;
	bh=27EHdEt35ZheJcL38IuQKua0sul4Z0TtdzoX5DlegRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=On6wiFdLQaS7uxxNf0LFBrwn1qphBxO1NYTbf45V6Dpu0RDp3X82GaW3dCbofnVrxlYFMLNZUU22kuRnoNM+CGDB+/Q7oPyap7odyY2MSW6unf0OCrUvXQjs/p8AggZ4Ijg79sNuoM+1jIgsh3K4c1qrnacz0kSMMNU/g4aOUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=bGlul/y1; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="bGlul/y1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1785164467; x=1785423667;
	bh=sYXke8xyh0IlDla6ifm2Up3zcRfK34++bvTcms70Yv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bGlul/y1S4/teuFlNq0lXR2tQMlELjhOahXUfyTMHn88Tzh81kqUUQP5pna2hHwPG
	 IiXjGB1QeqbNcPMpOO1CpFWxAnZCdUBPQ/iPBqR1IVVL7oM5xFS4m6nijFHWw/Ffid
	 9nHBLzXOPlwFYdCJDwkTWqcQD+5Z2Jzi6p1JcUoHQ2Qx2iZ3ZQDoeUeyMokjMgneAk
	 lur///NnPpREG5zYdXghrB2L52uwqwYPulYtXJDNv9YfDne4k1AA7aBxzZbXiBhRAa
	 w6GtH4sOTcQ29tnLEYJ+4APIDe79Ijc5AgyTpesS4pnhkbLbc6CBYOjbUcMXtmZIak
	 QD8vfPdv36MMg==
X-Pm-Submission-Id: 4h81xr6pqzz1DFF7
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	boris.brezillon@collabora.com,
	samitolvanen@google.com,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/tyr: enable runtime PM
Date: Mon, 27 Jul 2026 18:00:58 +0300
Message-ID: <20260727150103.911533-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260721153617.869933-4-beata.michalska@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com> <20260721153617.869933-4-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jul 2026 17:34:04 +0200=0D
Beata Michalska <beata.michalska@arm.com> wrote:=0D
=0D
> Add runtime PM support to the Tyr platform driver. Move the clocks and=0D
> regulators used by runtime suspend and resume into the PM payload, regist=
er the=0D
> PM callbacks, configure autosuspend, and let DRM paths take a PM usage=0D
> reference while querying device state.=0D
> =0D
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>=0D
> ---=0D
>  drivers/gpu/drm/tyr/driver.rs | 112 ++++++++++++++++++++++++++++------=0D
>  drivers/gpu/drm/tyr/file.rs   |   7 ++-=0D
>  2 files changed, 98 insertions(+), 21 deletions(-)=0D
> =0D
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s=0D
> index 8348c6cd3929..89fe216be0de 100644=0D
> --- a/drivers/gpu/drm/tyr/driver.rs=0D
> +++ b/drivers/gpu/drm/tyr/driver.rs=0D
> @@ -1,6 +1,7 @@=0D
>  // SPDX-License-Identifier: GPL-2.0 or MIT=0D
>  =0D
>  use kernel::{=0D
> +    bindings,=0D
>      clk::{=0D
>          Clk,=0D
>          OptionalClk, //=0D
> @@ -20,16 +21,16 @@=0D
>          poll,=0D
>          Io, //=0D
>      },=0D
> -    new_mutex,=0D
>      of,=0D
>      platform,=0D
> +    pm,=0D
> +    pm::*,=0D
>      prelude::*,=0D
>      regulator,=0D
>      regulator::Regulator,=0D
>      sizes::SZ_2M,=0D
>      sync::{=0D
>          aref::ARef,=0D
> -        Mutex, //=0D
>      },=0D
>      time, //=0D
>  };=0D
> @@ -55,18 +56,21 @@=0D
>  pub(crate) struct TyrPlatformDriverData<'bound> {=0D
>      _device: ARef<TyrDrmDevice>,=0D
>      _reg: drm::Registration<'bound, TyrDrmDriver>,=0D
> +    // This needs to be dropped after drm::Registration as this one borr=
ows=0D
> +    // borrows PMContext.=0D
> +    pub(crate) pm: pm::Registration<'bound, TyrPlatformDriver>,=0D
> +=0D
> +}=0D
> +=0D
> +#[pin_data]=0D
> +pub(crate) struct TyrRuntimePM<'bound> {=0D
> +    pub(crate) pm: PMContext<'bound, TyrPlatformDriver>,=0D
>  }=0D
>  =0D
>  #[pin_data]=0D
>  pub(crate) struct TyrDrmDeviceData {=0D
>      pub(crate) pdev: ARef<platform::Device>,=0D
>  =0D
> -    #[pin]=0D
> -    clks: Mutex<Clocks>,=0D
> -=0D
> -    #[pin]=0D
> -    regulators: Mutex<Regulators>,=0D
> -=0D
>      /// Some information on the GPU.=0D
>      ///=0D
>      /// This is mainly queried by userspace, i.e.: Mesa.=0D
> @@ -101,6 +105,7 @@ impl platform::Driver for TyrPlatformDriver {=0D
>      type IdInfo =3D ();=0D
>      type Data<'bound> =3D TyrPlatformDriverData<'bound>;=0D
>      const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&OF_TA=
BLE);=0D
> +    const PM_OPS: Option<&'static bindings::dev_pm_ops> =3D Some(&PMCont=
ext::<Self>::PM_OPS);=0D
>  =0D
>      fn probe<'bound>(=0D
>          pdev: &'bound platform::Device<Core<'_>>,=0D
> @@ -117,6 +122,25 @@ fn probe<'bound>(=0D
>          let mali_regulator =3D Regulator::<regulator::Enabled>::get(pdev=
.as_ref(), c"mali")?;=0D
>          let sram_regulator =3D Regulator::<regulator::Enabled>::get(pdev=
.as_ref(), c"sram")?;=0D
>  =0D
> +	let runtime_payload =3D TyrRuntimePMPayload {=0D
> +            clks: Clocks {=0D
> +                core: core_clk,=0D
> +                stacks: stacks_clk,=0D
> +                coregroup: coregroup_clk,=0D
> +            },=0D
> +            _regulators: Regulators {=0D
> +                    _mali: mali_regulator,=0D
> +                    _sram: sram_regulator,=0D
> +            }=0D
> +        };=0D
> +=0D
> +        let mut pm_configs =3D KVec::<PMConfig>::with_capacity(2, GFP_KE=
RNEL)?;=0D
> +        pm_configs.push(PMConfig::AutoSuspend(true), GFP_KERNEL)?;=0D
> +        pm_configs.push(PMConfig::AutoSuspendDelay(300), GFP_KERNEL)?;=0D
> +=0D
> +        let pm_registration =3D pm::Registration::new(pdev.as_ref(), Non=
e, Some(pm_configs), Some(runtime_payload))?;=0D
> +        let pm_context =3D pm_registration.ctx().clone();=0D
> +=0D
>          let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?;=0D
>          let iomem =3D request.iomap_sized::<SZ_2M>()?;=0D
>  =0D
> @@ -138,28 +162,26 @@ fn probe<'bound>(=0D
>  =0D
>          let data =3D try_pin_init!(TyrDrmDeviceData {=0D
>                  pdev: platform.clone(),=0D
> -                clks <- new_mutex!(Clocks {=0D
> -                    core: core_clk,=0D
> -                    stacks: stacks_clk,=0D
> -                    coregroup: coregroup_clk,=0D
> -                }),=0D
> -                regulators <- new_mutex!(Regulators {=0D
> -                    _mali: mali_regulator,=0D
> -                    _sram: sram_regulator,=0D
> -                }),=0D
>                  gpu_info,=0D
>          });=0D
>  =0D
>          let tdev =3D drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, =
data)?;=0D
>          // SAFETY: `reg` is stored in `TyrPlatformDriverData` and droppe=
d when the driver is=0D
>          // unbound; it is never forgotten.=0D
> -        let reg =3D unsafe { drm::Registration::new(pdev.as_ref(), tdev,=
 (), 0)? };=0D
> +        let reg =3D unsafe { drm::Registration::new(=0D
> +            pdev.as_ref(),=0D
> +            tdev,=0D
> +            pin_init!(TyrRuntimePM { pm: pm_context, }),=0D
> +            0=0D
> +        )? };=0D
>  =0D
>          let driver =3D TyrPlatformDriverData {=0D
>              _device: reg.device().into(),=0D
>              _reg: reg,=0D
> +            pm: pm_registration,=0D
>          };=0D
>  =0D
> +        driver.pm.ctx().enable(RuntimePMState::RESUMED)?;=0D
>          // We need this to be dev_info!() because dev_dbg!() does not wo=
rk at=0D
>          // all in Rust for now, and we need to see whether probe succeed=
ed.=0D
>          dev_info!(pdev, "Tyr initialized correctly.\n");=0D
> @@ -185,7 +207,7 @@ fn drop(self: Pin<&mut Self>) {}=0D
>  #[vtable]=0D
>  impl drm::Driver for TyrDrmDriver {=0D
>      type Data =3D TyrDrmDeviceData;=0D
> -    type RegistrationData<'a> =3D ();=0D
> +    type RegistrationData<'a> =3D TyrRuntimePM<'a>;=0D
>      type File =3D TyrDrmFileData;=0D
>      type Object =3D drm::gem::shmem::Object<BoData>;=0D
>      type ParentDevice<Ctx: DeviceContext> =3D platform::Device<Ctx>;=0D
> @@ -216,3 +238,55 @@ struct Regulators {=0D
>      _mali: Regulator<regulator::Enabled>,=0D
>      _sram: Regulator<regulator::Enabled>,=0D
>  }=0D
> +=0D
> +pub(crate) struct TyrRuntimePMPayload {=0D
> +    clks: Clocks,=0D
> +    _regulators: Regulators,=0D
> +}=0D
> +=0D
> +#[vtable]=0D
> +impl PMOps for TyrPlatformDriver {=0D
> +    type DeviceType =3D platform::Device<kernel::device::Bound>;=0D
> +    type RuntimePayloadType =3D TyrRuntimePMPayload;=0D
> +=0D
> +    fn runtime_suspend<'a>(=0D
> +        _dev: &'a Self::DeviceType,=0D
> +        payload: Option<TyrRuntimePMPayload>,=0D
> +    ) -> Result<Option<TyrRuntimePMPayload>, (Option<TyrRuntimePMPayload=
>, Error)>  {=0D
> +=0D
> +        let Some(payload) =3D payload else {=0D
> +          return Err((None, EINVAL));=0D
> +        };=0D
> +=0D
> +        payload.clks.coregroup.disable_unprepare();=0D
> +        payload.clks.stacks.disable_unprepare();=0D
> +        payload.clks.core.disable_unprepare();=0D
=0D
"impl Drop for Clocks" calls these as well, are they safe to re-call=0D
when they already called?=0D
=0D
> +        Ok(Some(payload))=0D
> +    }=0D
> +    fn runtime_resume<'a>(=0D
=0D
Missing newline before new function (this appears at multiple lines in this=
=0D
series).=0D
=0D
> +        _dev: &'a Self::DeviceType,=0D
> +        payload: Option<TyrRuntimePMPayload>,=0D
> +    ) -> Result<Option<TyrRuntimePMPayload>, (Option<TyrRuntimePMPayload=
>, Error)> {=0D
> +=0D
> +      let Some(payload) =3D payload else {=0D
> +          return Err((None, EINVAL));=0D
> +      };=0D
> +=0D
> +      if let Err(e) =3D payload.clks.core.prepare_enable() {=0D
> +          return Err((Some(payload), e));=0D
> +      }=0D
> +=0D
> +      if let Err(e) =3D payload.clks.stacks.prepare_enable() {=0D
> +          payload.clks.core.disable_unprepare();=0D
> +          return Err((Some(payload), e));=0D
> +      }=0D
> +=0D
> +      if let Err(e) =3D payload.clks.coregroup.prepare_enable() {=0D
> +          payload.clks.stacks.disable_unprepare();=0D
> +          payload.clks.core.disable_unprepare();=0D
> +          return Err((Some(payload), e));=0D
> +      }=0D
> +=0D
> +      Ok(Some(payload))=0D
> +   }=0D
> +}=0D
> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs=0D
> index b686041d5d6b..d9371ddfb5f3 100644=0D
> --- a/drivers/gpu/drm/tyr/file.rs=0D
> +++ b/drivers/gpu/drm/tyr/file.rs=0D
> @@ -5,6 +5,7 @@=0D
>          self,=0D
>          Registered, //=0D
>      },=0D
> +    pm::PMProfile,=0D
>      prelude::*,=0D
>      uaccess::UserSlice,=0D
>      uapi, //=0D
> @@ -12,7 +13,8 @@=0D
>  =0D
>  use crate::driver::{=0D
>      TyrDrmDevice,=0D
> -    TyrDrmDriver, //=0D
> +    TyrDrmDriver,=0D
> +    TyrRuntimePM,//=0D
>  };=0D
>  =0D
>  #[pin_data]=0D
> @@ -32,10 +34,11 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<P=
in<KBox<Self>>> {=0D
>  impl TyrDrmFileData {=0D
>      pub(crate) fn dev_query(=0D
>          ddev: &TyrDrmDevice<Registered>,=0D
> -        _reg_data: &(),=0D
> +        reg_data: &TyrRuntimePM<'_>,=0D
>          devquery: &mut uapi::drm_panthor_dev_query,=0D
>          _file: &TyrDrmFile,=0D
>      ) -> Result<u32> {=0D
> +        let _pm_scope =3D reg_data.pm.get(PMProfile::new())?;=0D
>          if devquery.pointer =3D=3D 0 {=0D
>              match devquery.type_ {=0D
>                  uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_G=
PU_INFO =3D> {=0D
> -- =0D
> 2.43.0=0D
> =0D
