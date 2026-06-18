Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670A3D6CCF;
	Thu, 18 Jun 2026 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770250; cv=none; b=tV0HXI6EUO1ILkhT0Y0Mnnj01nN4BgUxssx0uP5De0Jb3BLfhGn6swvvdZ/Hv/tjI0Kyl9OX8I0c0ONSeDDYeqvcDsIUMrUgW1WxvJxYOymluuu4OwqzlcS6OVsHHA6+V9cCOvN/YDf3OrZPxPRqzvI6zPaYJzttv9kKd+hUZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770250; c=relaxed/simple;
	bh=KEOOS/s/am57CV3qCbmRplrQNf+VLf3i3XAvXZtygWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVYr1L6sQ8kBvzZy7YTEwGTgilUfpDQfYzlryeFR32RqmXn1AoqcV+enDzkHEnS7jzumktiXEcWilHAUdfwS8jVFwhvyP/jjRhtxdG5QdFwPRcyPlG/ZAj9fCRK8EQkPgU146freGPmyC6DsPO+CANDbPPpqteoZ7HrE/aA/EPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Wv+neOsH; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Wv+neOsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781770246; x=1782029446;
	bh=il13JZXSJpfwDVrhPAiRTVZ2CIyzBfQKH8+hwIpyxAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Wv+neOsHPNFrzUzR1T6c+Nm8SMdjfWY/pQfGR4t8YaGoAPK8NA8VKqx2HaH/wZ1ke
	 pEpTES0lpXf26srd6UW5QjMNjBl6UrqTGa7T7eyoe8uuq03xqMqIfzYA97u7h//1Qz
	 f1Oo0G5s8ab/+EWJvJBkFZy8JcwVELKGhDfhoHeUCf4RIqVOMe6gf7wBcpLMZd0UPa
	 LzZSecvPDXmSCGXid1Qqd4EwF8p0ldlilDHkgwoW1nSi2FA6Vj4LYEdyEwNKANN4Kd
	 SlEeVYtVVa3ALpHPpUanOg9Z1jhiKm95uzRmnrfnSsPNCzqNmYSwTIbddi2YoC/q+F
	 HuVuTEba7BFTw==
X-Pm-Submission-Id: 4ggthG5v2fz2ScNJ
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Brian Masney <bmasney@redhat.com>,
	Boqun Feng <boqun@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v4 1/3] rust: clk: use the type-state pattern
Date: Thu, 18 Jun 2026 11:10:34 +0300
Message-ID: <20260618081037.35784-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260618-clk-type-state-v4-1-8be082786080@collabora.com>
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com> <20260618-clk-type-state-v4-1-8be082786080@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jun 2026 00:46:35 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> The current Clk abstraction can still be improved on the following issues=
:=0D
> =0D
> a) It only keeps track of a count to clk_get(), which means that users ha=
ve=0D
> to manually call disable() and unprepare(), or a variation of those, like=
=0D
> disable_unprepare().=0D
> =0D
> b) It allows repeated calls to prepare() or enable(), but it keeps no tra=
ck=0D
> of how often these were called, i.e., it's currently legal to write the=0D
> following:=0D
> =0D
> clk.prepare();=0D
> clk.prepare();=0D
> clk.enable();=0D
> clk.enable();=0D
> =0D
> And nothing gets undone on drop().=0D
> =0D
> c) It adds a OptionalClk type that is probably not needed. There is no=0D
> "struct optional_clk" in C and we should probably not add one.=0D
> =0D
> d) It does not let a user express the state of the clk through the=0D
> type system. For example, there is currently no way to encode that a Clk =
is=0D
> enabled via the type system alone.=0D
> =0D
> In light of the Regulator abstraction that was recently merged, switch th=
is=0D
> abstraction to use the type-state pattern instead. It solves both a) and =
b)=0D
> by establishing a number of states and the valid ways to transition betwe=
en=0D
> them. It also automatically undoes any call to clk_get(), clk_prepare() a=
nd=0D
> clk_enable() as applicable on drop(), so users do not have to do anything=
=0D
> special before Clk goes out of scope.=0D
> =0D
> It solves c) by removing the OptionalClk type, which is now simply encode=
d=0D
> as a Clk whose inner pointer is NULL.=0D
> =0D
> It solves d) by directly encoding the state of the Clk into the type, e.g=
.:=0D
> Clk<Enabled> is now known to be a Clk that is enabled.=0D
> =0D
> The INVARIANTS section for Clk is expanded to highlight the relationship=
=0D
> between the states and the respective reference counts that are owned by=
=0D
> each of them.=0D
> =0D
> The examples are expanded to highlight how a user can transition between=
=0D
> states, as well as highlight some of the shortcuts built into the API.=0D
> =0D
> The current implementation is also more flexible, in the sense that it=0D
> allows for more states to be added in the future. This lets us implement=
=0D
> different strategies for handling clocks, including one that mimics the=0D
> current API, allowing for multiple calls to prepare() and enable().=0D
> =0D
> The users (cpufreq.rs/ rcpufreq_dt.rs) were updated by this patch (and no=
t=0D
> a separate one) to reflect the new changes. This is needed, because=0D
> otherwise this patch would break the build.=0D
> =0D
> Link: https://crates.io/crates/sealed [1]=0D
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
> ---=0D
>  drivers/cpufreq/rcpufreq_dt.rs |   2 +-=0D
>  drivers/gpu/drm/tyr/driver.rs  |  31 +--=0D
>  drivers/pwm/pwm_th1520.rs      |  17 +-=0D
>  rust/kernel/clk.rs             | 512 ++++++++++++++++++++++++++++++-----=
------=0D
>  rust/kernel/cpufreq.rs         |   8 +-=0D
>  5 files changed, 396 insertions(+), 174 deletions(-)=0D
> =0D
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt=
.rs=0D
> index f17bf64c22e2..9d2ec7df4bac 100644=0D
> --- a/drivers/cpufreq/rcpufreq_dt.rs=0D
> +++ b/drivers/cpufreq/rcpufreq_dt.rs=0D
> @@ -40,7 +40,7 @@ struct CPUFreqDTDevice {=0D
>      freq_table: opp::FreqTable,=0D
>      _mask: CpumaskVar,=0D
>      _token: Option<opp::ConfigToken>,=0D
> -    _clk: Clk,=0D
> +    _clk: Clk<kernel::clk::Unprepared>,=0D
>  }=0D
>  =0D
>  #[derive(Default)]=0D
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s=0D
> index 279710b36a10..a2230aebfea2 100644=0D
> --- a/drivers/gpu/drm/tyr/driver.rs=0D
> +++ b/drivers/gpu/drm/tyr/driver.rs=0D
> @@ -3,7 +3,7 @@=0D
>  use kernel::{=0D
>      clk::{=0D
>          Clk,=0D
> -        OptionalClk, //=0D
> +        Enabled, //=0D
>      },=0D
>      device::{=0D
>          Bound,=0D
> @@ -49,7 +49,7 @@ pub(crate) struct TyrPlatformDriverData {=0D
=0D
[...]=0D
=0D
> -        /// Disable and unprepare the clock.=0D
> -        ///=0D
> -        /// Equivalent to calling [`Clk::disable`] followed by [`Clk::un=
prepare`].=0D
> +        /// Behaves the same as [`Self::get`], except when there is no c=
lock=0D
> +        /// producer. In this case, instead of returning [`ENOENT`], it =
returns=0D
> +        /// a dummy [`Clk`].=0D
>          #[inline]=0D
> -        pub fn disable_unprepare(&self) {=0D
> -            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for=0D
> -            // [`clk_disable_unprepare`].=0D
> -            unsafe { bindings::clk_disable_unprepare(self.as_raw()) };=0D
> +        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) ->=
 Result<Clk<Enabled>> {=0D
> +            Clk::<Prepared>::get_optional(dev, name)?=0D
> +                .enable()=0D
> +                .map_err(|error| error.error)=0D
> +        }=0D
> +=0D
> +        /// Attempts to disable the [`Clk`] and convert it to the [`Prep=
ared`]=0D
=0D
nit: I wouldn't use the word "Attempts" for an infallible function.=0D
=0D
> +        /// state.=0D
> +        #[inline]=0D
> +        pub fn disable(self) -> Result<Clk<Prepared>, Error<Enabled>> {=
=0D
=0D
This is an infallible function, you can return Clk<Prepared> directly.=0D
=0D
Thanks,=0D
Onur=0D
=0D
> +            // We will be transferring the ownership of our `clk_get()` =
and=0D
> +            // `clk_enable()` counts to `Clk<Prepared>`.=0D
> +            let clk =3D ManuallyDrop::new(self);=0D
> +=0D
> +            // SAFETY: By the type invariants, `self.0` is a valid argum=
ent for=0D
> +            // [`clk_disable`].=0D
> +            unsafe { bindings::clk_disable(clk.as_raw()) };=0D
> +=0D
> +            Ok(Clk {=0D
> +                inner: clk.inner,=0D
> +                _phantom: PhantomData,=0D
> +            })=0D
>          }=0D
>  =0D
>          /// Get clock's rate.=0D
> @@ -251,82 +544,31 @@ pub fn set_rate(&self, rate: Hertz) -> Result {=0D
> +                // [`clk_unprepare`].=0D
=0D
[...]=0D
=0D
> +                unsafe { bindings::clk_unprepare(self.as_raw()) };=0D
> +            }=0D
>  =0D
> -        fn deref(&self) -> &Clk {=0D
> -            &self.0=0D
> +            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for=0D
> +            // [`clk_put`].=0D
> +            unsafe { bindings::clk_put(self.as_raw()) };=0D
>          }=0D
>      }=0D
>  }=0D
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs=0D
> index d8d26870bea2..e837bb1010e0 100644=0D
> --- a/rust/kernel/cpufreq.rs=0D
> +++ b/rust/kernel/cpufreq.rs=0D
> @@ -553,8 +553,12 @@ pub fn cpus(&mut self) -> &mut cpumask::Cpumask {=0D
>      /// The caller must guarantee that the returned [`Clk`] is not dropp=
ed while it is getting used=0D
>      /// by the C code.=0D
>      #[cfg(CONFIG_COMMON_CLK)]=0D
> -    pub unsafe fn set_clk(&mut self, dev: &Device, name: Option<&CStr>) =
-> Result<Clk> {=0D
> -        let clk =3D Clk::get(dev, name)?;=0D
> +    pub unsafe fn set_clk(=0D
> +        &mut self,=0D
> +        dev: &Device,=0D
> +        name: Option<&CStr>,=0D
> +    ) -> Result<Clk<crate::clk::Unprepared>> {=0D
> +        let clk =3D Clk::<crate::clk::Unprepared>::get_unbound(dev, name=
)?;=0D
>          self.as_mut_ref().clk =3D clk.as_raw();=0D
>          Ok(clk)=0D
>      }=0D
> =0D
> -- =0D
> 2.54.0=0D
> =0D
