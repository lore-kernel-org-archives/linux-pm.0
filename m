Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAD3B7B66;
	Sat,  1 Aug 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606295; cv=none; b=dVcjNc7+d0ZWYtNI3ympPSRdBuoa6i4X5Y0wxC3Ryp1O+2F6L/R+7RHuUGZzKTml42EsISJFi76URu+HrdhUOHakQIb2oZgXgawqC9DEZ+H133k6aYFekEHAh9h4see+3rQu9wc6sZONt0FIHTDM7VD3v6C2RwX/mu6XdNz8A74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606295; c=relaxed/simple;
	bh=1lkuxakc/9+zFDLtSsm4Kb/GRESUDWvNHeHbUcHfk28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHX3ZXMitIY6RFxolV3TBp03aFt+v+lCGkfD5O8maAEzcMX1UdQyWE+dVH5mBtUBcmUGLeWiJ5sOqvQbafzLuuuqMFp50VymY6fo7N9AJGssXVQI3+OFT4eS+Lo+MShePDc5ZfXMfVSUKd333iKSVEY18mWfXiDpGWsVRjpY+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=J0Xo2fx5; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="J0Xo2fx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1785606275; x=1785865475;
	bh=GEnf/aEUeF5h5noLn7GPe6Z4ZE8ClVmcGqH+KCbBXJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=J0Xo2fx5hC6OiriflfmKS/PP8suzBKCpm0cqcbRCFfQhn8RF7TDrqDJhPpLr2liYb
	 /aeDXqSSr/sNF+/UwhjmCfpTm40X4B0fxWLHez1Tow1p1eSEdc1ZNfwznOnzaNc/uH
	 PiVpB+uewXSrDqA9eglw8Jx7TVajRxvCBQMp0OX0s/yCJZcB4iJc5A0uNofWToRFty
	 nWE/xV9JVDfgYrZxaq0fonCTDwmPojO3sIXJGvfjeEoCVzkTd7gAe47owTgZbmtPK3
	 UgZaRIWDoxCmrJWTjCazKL+a6jsku2/Nay2sSmF1YS/G/w5QBGW7Xjc0t8TkCj3YyI
	 VD8oEKEnzMlnw==
X-Pm-Submission-Id: 4hC9L32F1Tz1DDrb
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
	Boqun Feng <boqun@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Maurice <mhi@mailbox.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v5 4/4] rust: clk: use 'kernel vertical style' for imports
Date: Sat,  1 Aug 2026 20:44:24 +0300
Message-ID: <20260801174426.926785-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260706-clk-type-state-v5-4-67c5f326a16c@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com> <20260706-clk-type-state-v5-4-67c5f326a16c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 06 Jul 2026 11:37:15 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> Convert all imports to use the new import style. This will make it easier=
=0D
> to land new changes in the future.=0D
> =0D
> No change of functionality implied.=0D
> =0D
> Link: https://docs.kernel.org/rust/coding-guidelines.html#imports=0D
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> ---=0D
>  rust/kernel/clk.rs | 66 +++++++++++++++++++++++++++++++++++++++++-------=
------=0D
>  1 file changed, 50 insertions(+), 16 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs=0D
> index b9a44f83843a..e677156ffd21 100644=0D
> --- a/rust/kernel/clk.rs=0D
> +++ b/rust/kernel/clk.rs=0D
> @@ -80,13 +80,23 @@ fn from(freq: Hertz) -> Self {=0D
>  mod common_clk {=0D
>      use super::Hertz;=0D
>      use crate::{=0D
> -        device::{Bound, Device},=0D
> -        error::{from_err_ptr, to_result, Result},=0D
> +        device::{=0D
> +            Bound,=0D
> +            Device, //=0D
> +        },=0D
> +        error::{=0D
> +            from_err_ptr,=0D
> +            to_result, //=0D
> +        },=0D
>          prelude::*,=0D
> -        sync::Arc,=0D
> +        sync::Arc, //=0D
>      };=0D
>  =0D
> -    use core::{marker::PhantomData, mem::ManuallyDrop, ptr};=0D
> +    use core::{=0D
> +        marker::PhantomData,=0D
> +        mem::ManuallyDrop,=0D
> +        ptr, //=0D
> +    };=0D
>  =0D
>      mod private {=0D
>          pub trait Sealed {}=0D
> @@ -193,9 +203,15 @@ impl<State: ClkState> From<Error<State>> for kernel:=
:error::Error {=0D
>          /// original [`Clk`], e.g.:=0D
>          ///=0D
>          /// ```=0D
> -        /// use kernel::clk::{Clk, Enabled, Unprepared};=0D
> -        /// use kernel::device::{Bound, Device};=0D
> -        /// use kernel::error::Result;=0D
> +        /// use kernel::clk::{=0D
> +        ///     Clk,=0D
> +        ///     Enabled,=0D
> +        ///     Unprepared, //=0D
> +        /// };=0D
> +        /// use kernel::device::{=0D
> +        ///     Bound,=0D
> +        ///     Device, //=0D
> +        /// };=0D
>          ///=0D
>          /// fn get_enabled(dev: &Device<Bound>) -> Result<Clk<Enabled>> =
{=0D
>          ///     let clk =3D Clk::<Unprepared>::get(dev, Some(c"apb_clk")=
)?=0D
> @@ -245,9 +261,17 @@ fn from(err: Error<State>) -> Self {=0D
>      /// The following example demonstrates how to obtain and configure a=
 clock for a device.=0D
>      ///=0D
>      /// ```=0D
> -    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};=0D
> -    /// use kernel::device::{Bound, Device};=0D
> -    /// use kernel::error::Result;=0D
> +    /// use kernel::clk::{=0D
> +    ///     Clk,=0D
> +    ///     Enabled,=0D
> +    ///     Hertz,=0D
> +    ///     Prepared,=0D
> +    ///     Unprepared, //=0D
> +    /// };=0D
> +    /// use kernel::device::{=0D
> +    ///     Bound,=0D
> +    ///     Device, //=0D
> +    /// };=0D
>      ///=0D
>      /// fn configure_clk(dev: &Device<Bound>) -> Result {=0D
>      ///     // The fastest way is to use a version of `Clk::get` for the=
 desired=0D
> @@ -292,8 +316,11 @@ fn from(err: Error<State>) -> Self {=0D
>      /// and move between the variants:=0D
>      ///=0D
>      /// ```=0D
> -    /// use kernel::clk::{Clk, Enabled, Prepared};=0D
> -    /// use kernel::error::Result;=0D
> +    /// use kernel::clk::{=0D
> +    ///     Clk,=0D
> +    ///     Enabled,=0D
> +    ///     Prepared, //=0D
> +    /// };=0D
>      ///=0D
>      /// enum DeviceClk {=0D
>      ///     Suspended(Clk<Prepared>),=0D
> @@ -323,8 +350,11 @@ fn from(err: Error<State>) -> Self {=0D
>      /// enable a clone of it:=0D
>      ///=0D
>      /// ```=0D
> -    /// use kernel::clk::{Clk, Enabled, Prepared};=0D
> -    /// use kernel::error::Result;=0D
> +    /// use kernel::clk::{=0D
> +    ///     Clk,=0D
> +    ///     Enabled,=0D
> +    ///     Prepared, //=0D
> +    /// };=0D
>      ///=0D
>      /// fn use_clk(prepared_clk: &Clk<Prepared>) -> Result {=0D
>      ///     let enabled_clk: Clk<Enabled> =3D prepared_clk.clone().enabl=
e()?;=0D
> @@ -556,8 +586,12 @@ pub fn enable(self) -> Result<Clk<Enabled>, Error<Pr=
epared>> {=0D
>          /// clock or threading it through an intermediate state, e.g.:=0D
>          ///=0D
>          /// ```=0D
> -        /// use kernel::clk::{Clk, Enabled, Hertz, Prepared};=0D
> -        /// use kernel::error::Result;=0D
> +        /// use kernel::clk::{=0D
> +        ///     Clk,=0D
> +        ///     Enabled,=0D
> +        ///     Hertz,=0D
> +        ///     Prepared, //=0D
> +        /// };=0D
>          ///=0D
>          /// fn read_rate(clk: &Clk<Prepared>) -> Result<Hertz> {=0D
>          ///     clk.with_enabled(|clk: &Clk<Enabled>| clk.rate())=0D
> =0D
> -- =0D
> 2.54.0=0D
> =0D
