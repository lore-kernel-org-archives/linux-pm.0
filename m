Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23148400987;
	Wed, 29 Jul 2026 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316405; cv=none; b=chsvdoPVdG9e+s6asYCkONPQNuHNyNBrGHRfk3c3VOe1fmLEGflIfHxDiOsOBO3JOaqL1ZRd+anFMq7xAkL5KHjOFWc8l2JZYalOqGB3Cb+V8uHvSbtrxIALB7HkltEQOrGa9m691RBhYDUC6iq25j9sWGViE8oi7n3+1yKfEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316405; c=relaxed/simple;
	bh=VYQZ0uG1eFXy8yMV1VZlUvDn9/3JYu6JowqhAG6Q8zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNE5kW/Z41dptOpnn09KD59ba0HK44zylS9Ws5oQz2KdpYNMDnn1qNMXZBp9VoXdBCMmjMbxhLrdK1E0/+FN6WZ2ckPCWwXkYB8xneikN2vTkbPnCFVLSsurTGl4ka9SMi/P4fOVnb46/YKiql3SqoQDNeF/vmolJrUa8Fcj3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sC8pnaKO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sC8pnaKO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B9E2169C;
	Wed, 29 Jul 2026 02:13:18 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BEB3F86F;
	Wed, 29 Jul 2026 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785316402; bh=VYQZ0uG1eFXy8yMV1VZlUvDn9/3JYu6JowqhAG6Q8zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sC8pnaKOXOW9PiMM+cepFdavbPzNJ8lwCc4oah3F42u3PVE8ZhuClwypJN3GMefOV
	 izG2Ni0B/uN7+hepaK7e/5Gxf6dZkxTUFkAuQ9xXJWC5GE09f77f0d8kASBuq90k6g
	 5pO2j5Da6kxHAjboEiBI/OeG+yAOhlMJIp6BGkP4=
Date: Wed, 29 Jul 2026 11:13:15 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, boris.brezillon@collabora.com,
	samitolvanen@google.com, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/tyr: enable runtime PM
Message-ID: <amnEK2oHziBq2q2a@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com>
 <20260721153617.869933-4-beata.michalska@arm.com>
 <20260727150103.911533-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727150103.911533-1-work@onurozkan.dev>

On Mon, Jul 27, 2026 at 06:00:58PM +0300, Onur Özkan wrote:
> On Tue, 21 Jul 2026 17:34:04 +0200
> Beata Michalska <beata.michalska@arm.com> wrote:
> 
> > Add runtime PM support to the Tyr platform driver. Move the clocks and
> > regulators used by runtime suspend and resume into the PM payload, register the
> > PM callbacks, configure autosuspend, and let DRM paths take a PM usage
> > reference while querying device state.
> > 
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >  drivers/gpu/drm/tyr/driver.rs | 112 ++++++++++++++++++++++++++++------
> >  drivers/gpu/drm/tyr/file.rs   |   7 ++-
> >  2 files changed, 98 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> > index 8348c6cd3929..89fe216be0de 100644
> > --- a/drivers/gpu/drm/tyr/driver.rs
> > +++ b/drivers/gpu/drm/tyr/driver.rs
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0 or MIT
> >  
> >  use kernel::{
> > +    bindings,
> >      clk::{
> >          Clk,
> >          OptionalClk, //
> > @@ -20,16 +21,16 @@
> >          poll,
> >          Io, //
> >      },
> > -    new_mutex,
> >      of,
> >      platform,
> > +    pm,
> > +    pm::*,
> >      prelude::*,
> >      regulator,
> >      regulator::Regulator,
> >      sizes::SZ_2M,
> >      sync::{
> >          aref::ARef,
> > -        Mutex, //
> >      },
> >      time, //
> >  };
> > @@ -55,18 +56,21 @@
> >  pub(crate) struct TyrPlatformDriverData<'bound> {
> >      _device: ARef<TyrDrmDevice>,
> >      _reg: drm::Registration<'bound, TyrDrmDriver>,
> > +    // This needs to be dropped after drm::Registration as this one borrows
> > +    // borrows PMContext.
> > +    pub(crate) pm: pm::Registration<'bound, TyrPlatformDriver>,
> > +
> > +}
> > +
> > +#[pin_data]
> > +pub(crate) struct TyrRuntimePM<'bound> {
> > +    pub(crate) pm: PMContext<'bound, TyrPlatformDriver>,
> >  }
> >  
> >  #[pin_data]
> >  pub(crate) struct TyrDrmDeviceData {
> >      pub(crate) pdev: ARef<platform::Device>,
> >  
> > -    #[pin]
> > -    clks: Mutex<Clocks>,
> > -
> > -    #[pin]
> > -    regulators: Mutex<Regulators>,
> > -
> >      /// Some information on the GPU.
> >      ///
> >      /// This is mainly queried by userspace, i.e.: Mesa.
> > @@ -101,6 +105,7 @@ impl platform::Driver for TyrPlatformDriver {
> >      type IdInfo = ();
> >      type Data<'bound> = TyrPlatformDriverData<'bound>;
> >      const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> > +    const PM_OPS: Option<&'static bindings::dev_pm_ops> = Some(&PMContext::<Self>::PM_OPS);
> >  
> >      fn probe<'bound>(
> >          pdev: &'bound platform::Device<Core<'_>>,
> > @@ -117,6 +122,25 @@ fn probe<'bound>(
> >          let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
> >          let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
> >  
> > +	let runtime_payload = TyrRuntimePMPayload {
> > +            clks: Clocks {
> > +                core: core_clk,
> > +                stacks: stacks_clk,
> > +                coregroup: coregroup_clk,
> > +            },
> > +            _regulators: Regulators {
> > +                    _mali: mali_regulator,
> > +                    _sram: sram_regulator,
> > +            }
> > +        };
> > +
> > +        let mut pm_configs = KVec::<PMConfig>::with_capacity(2, GFP_KERNEL)?;
> > +        pm_configs.push(PMConfig::AutoSuspend(true), GFP_KERNEL)?;
> > +        pm_configs.push(PMConfig::AutoSuspendDelay(300), GFP_KERNEL)?;
> > +
> > +        let pm_registration = pm::Registration::new(pdev.as_ref(), None, Some(pm_configs), Some(runtime_payload))?;
> > +        let pm_context = pm_registration.ctx().clone();
> > +
> >          let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
> >          let iomem = request.iomap_sized::<SZ_2M>()?;
> >  
> > @@ -138,28 +162,26 @@ fn probe<'bound>(
> >  
> >          let data = try_pin_init!(TyrDrmDeviceData {
> >                  pdev: platform.clone(),
> > -                clks <- new_mutex!(Clocks {
> > -                    core: core_clk,
> > -                    stacks: stacks_clk,
> > -                    coregroup: coregroup_clk,
> > -                }),
> > -                regulators <- new_mutex!(Regulators {
> > -                    _mali: mali_regulator,
> > -                    _sram: sram_regulator,
> > -                }),
> >                  gpu_info,
> >          });
> >  
> >          let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
> >          // SAFETY: `reg` is stored in `TyrPlatformDriverData` and dropped when the driver is
> >          // unbound; it is never forgotten.
> > -        let reg = unsafe { drm::Registration::new(pdev.as_ref(), tdev, (), 0)? };
> > +        let reg = unsafe { drm::Registration::new(
> > +            pdev.as_ref(),
> > +            tdev,
> > +            pin_init!(TyrRuntimePM { pm: pm_context, }),
> > +            0
> > +        )? };
> >  
> >          let driver = TyrPlatformDriverData {
> >              _device: reg.device().into(),
> >              _reg: reg,
> > +            pm: pm_registration,
> >          };
> >  
> > +        driver.pm.ctx().enable(RuntimePMState::RESUMED)?;
> >          // We need this to be dev_info!() because dev_dbg!() does not work at
> >          // all in Rust for now, and we need to see whether probe succeeded.
> >          dev_info!(pdev, "Tyr initialized correctly.\n");
> > @@ -185,7 +207,7 @@ fn drop(self: Pin<&mut Self>) {}
> >  #[vtable]
> >  impl drm::Driver for TyrDrmDriver {
> >      type Data = TyrDrmDeviceData;
> > -    type RegistrationData<'a> = ();
> > +    type RegistrationData<'a> = TyrRuntimePM<'a>;
> >      type File = TyrDrmFileData;
> >      type Object = drm::gem::shmem::Object<BoData>;
> >      type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
> > @@ -216,3 +238,55 @@ struct Regulators {
> >      _mali: Regulator<regulator::Enabled>,
> >      _sram: Regulator<regulator::Enabled>,
> >  }
> > +
> > +pub(crate) struct TyrRuntimePMPayload {
> > +    clks: Clocks,
> > +    _regulators: Regulators,
> > +}
> > +
> > +#[vtable]
> > +impl PMOps for TyrPlatformDriver {
> > +    type DeviceType = platform::Device<kernel::device::Bound>;
> > +    type RuntimePayloadType = TyrRuntimePMPayload;
> > +
> > +    fn runtime_suspend<'a>(
> > +        _dev: &'a Self::DeviceType,
> > +        payload: Option<TyrRuntimePMPayload>,
> > +    ) -> Result<Option<TyrRuntimePMPayload>, (Option<TyrRuntimePMPayload>, Error)>  {
> > +
> > +        let Some(payload) = payload else {
> > +          return Err((None, EINVAL));
> > +        };
> > +
> > +        payload.clks.coregroup.disable_unprepare();
> > +        payload.clks.stacks.disable_unprepare();
> > +        payload.clks.core.disable_unprepare();
> 
> "impl Drop for Clocks" calls these as well, are they safe to re-call
> when they already called?
Apparently I did forget to tag this one as "DO NOT MERGE"
as it is only supposed to illustrate the use of pm framework.
Other than that: this will trigger warnings.

---
BR
Beata
> 
> > +        Ok(Some(payload))
> > +    }
> > +    fn runtime_resume<'a>(
> 
> Missing newline before new function (this appears at multiple lines in this
> series).
> 
> > +        _dev: &'a Self::DeviceType,
> > +        payload: Option<TyrRuntimePMPayload>,
> > +    ) -> Result<Option<TyrRuntimePMPayload>, (Option<TyrRuntimePMPayload>, Error)> {
> > +
> > +      let Some(payload) = payload else {
> > +          return Err((None, EINVAL));
> > +      };
> > +
> > +      if let Err(e) = payload.clks.core.prepare_enable() {
> > +          return Err((Some(payload), e));
> > +      }
> > +
> > +      if let Err(e) = payload.clks.stacks.prepare_enable() {
> > +          payload.clks.core.disable_unprepare();
> > +          return Err((Some(payload), e));
> > +      }
> > +
> > +      if let Err(e) = payload.clks.coregroup.prepare_enable() {
> > +          payload.clks.stacks.disable_unprepare();
> > +          payload.clks.core.disable_unprepare();
> > +          return Err((Some(payload), e));
> > +      }
> > +
> > +      Ok(Some(payload))
> > +   }
> > +}
> > diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> > index b686041d5d6b..d9371ddfb5f3 100644
> > --- a/drivers/gpu/drm/tyr/file.rs
> > +++ b/drivers/gpu/drm/tyr/file.rs
> > @@ -5,6 +5,7 @@
> >          self,
> >          Registered, //
> >      },
> > +    pm::PMProfile,
> >      prelude::*,
> >      uaccess::UserSlice,
> >      uapi, //
> > @@ -12,7 +13,8 @@
> >  
> >  use crate::driver::{
> >      TyrDrmDevice,
> > -    TyrDrmDriver, //
> > +    TyrDrmDriver,
> > +    TyrRuntimePM,//
> >  };
> >  
> >  #[pin_data]
> > @@ -32,10 +34,11 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
> >  impl TyrDrmFileData {
> >      pub(crate) fn dev_query(
> >          ddev: &TyrDrmDevice<Registered>,
> > -        _reg_data: &(),
> > +        reg_data: &TyrRuntimePM<'_>,
> >          devquery: &mut uapi::drm_panthor_dev_query,
> >          _file: &TyrDrmFile,
> >      ) -> Result<u32> {
> > +        let _pm_scope = reg_data.pm.get(PMProfile::new())?;
> >          if devquery.pointer == 0 {
> >              match devquery.type_ {
> >                  uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
> > -- 
> > 2.43.0
> > 
