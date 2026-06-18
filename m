Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0243D6CAA;
	Thu, 18 Jun 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769542; cv=none; b=YZt4QXLBp3vqZLi1sYWIp6va+PQnlDQ21otIAGbtGdYRIn4r9UqMS2rPGe1ta49BvQAo1MFiPJY4Of6/e/QhNe5G5BVDuD5qoD7P5DZHlR7FsVR5SgKcHyEefUDIMfgPAM9OYw0MXTJKONIgMXkcjSDGjznQqgGarwPcSZmt0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769542; c=relaxed/simple;
	bh=YJM6wrmGhKXn+d/Bq+J5FDixvimrwMNCUE20hZ3q+jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXJrQVihPO4dBfLMWI2Nr8Yg3YbFdhULARfLcMONG1p+dZruOx/EFEj/S7U0349RJ55vslCkRvnKFezFOr8lc3uuwxeRF2Eh9xX+3UmDvEzHNGCgbJu5LXNlhIg2wSRjQK1uuqHbZEQgxsfVzVue3vNGCz/5NplMU16OzxcvBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=bu5voEUH; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="bu5voEUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781769537; x=1782028737;
	bh=FQ9h1CNqtUIN9Ufq0CQyLuGN5g3JqgqYIsoSVJmPyDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bu5voEUHxZ16s5NR8RCnQZSzKOtOARepFItcD+renzYYsuo0H9OMI/sh+bvQb8WYR
	 kcl8QhRR6Lk/89oPQ+kCcVsecOdlEjmbIXH3ScoNfbtC0p5/MYwjUkewI2/VOq7Cq3
	 1de2jMTVMIVu00IhN1HxtAbwLH4D1u/ZTvSssC+QmH59KiF1IFKsQT+gGcIJPQbogT
	 iZpROoSfiW/M0lurXIzcW9AXtETcxUXGelZkEu5t4oG/UE/wdFkAdZbvKOux/+52Ts
	 6z89OgPGkxuAmYKvyT1Akt9meuGh61PJebzFQsGydcKaQioBdDyRD1nmdrUL7HlM20
	 1RNW0/QdxAy4A==
X-Pm-Submission-Id: 4ggtQf3jNcz2ScmS
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
	Boris Brezillon <boris.brezillon@collabora.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v4 3/3] rust: clk: use 'kernel vertical style' for imports
Date: Thu, 18 Jun 2026 10:58:47 +0300
Message-ID: <20260618075848.28017-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com> <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jun 2026 00:46:37 -0300=0D
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
>  rust/kernel/clk.rs | 56 ++++++++++++++++++++++++++++++++++++++++++++----=
------=0D
>  1 file changed, 46 insertions(+), 10 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs=0D
> index 692ee88ca772..1412a2f0aedf 100644=0D
> --- a/rust/kernel/clk.rs=0D
> +++ b/rust/kernel/clk.rs=0D
> @@ -80,12 +80,23 @@ fn from(freq: Hertz) -> Self {=0D
>  mod common_clk {=0D
>      use super::Hertz;=0D
>      use crate::{=0D
> -        device::{Bound, Device},=0D
> -        error::{from_err_ptr, to_result, Result},=0D
> -        prelude::*,=0D
> +        device::{=0D
> +            Bound,=0D
> +            Device, //=0D
> +        },=0D
> +        error::{=0D
> +            from_err_ptr,=0D
> +            to_result,=0D
> +            Result, //=0D
> +        },=0D
> +        prelude::*, //=0D
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
> @@ -189,8 +200,15 @@ impl<State: ClkState> From<Error<State>> for kernel:=
:error::Error {=0D
>          /// original [`Clk`], e.g.:=0D
>          ///=0D
>          /// ```=0D
> -        /// use kernel::clk::{Clk, Enabled, Unprepared};=0D
> -        /// use kernel::device::{Bound, Device};=0D
> +        /// use kernel::clk::{=0D
> +        ///     Clk,=0D
> +        ///     Enabled,=0D
> +        ///     Unprepared, //=0D
> +        /// };=0D
> +        /// use kernel::device::{=0D
> +        ///     Bound,=0D
> +        ///     Device, //=0D
> +        /// };=0D
>          /// use kernel::error::Result;=0D
>          ///=0D
>          /// fn get_enabled(dev: &Device<Bound>) -> Result<Clk<Enabled>> =
{=0D
> @@ -240,8 +258,17 @@ fn from(err: Error<State>) -> Self {=0D
>      /// The following example demonstrates how to obtain and configure a=
 clock for a device.=0D
>      ///=0D
>      /// ```=0D
> -    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};=0D
> -    /// use kernel::device::{Bound, Device};=0D
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
>      /// use kernel::error::Result;=0D
>      ///=0D
>      /// fn configure_clk(dev: &Device<Bound>) -> Result {=0D
> @@ -287,7 +314,11 @@ fn from(err: Error<State>) -> Self {=0D
>      /// and move between the variants:=0D
>      ///=0D
>      /// ```=0D
> -    /// use kernel::clk::{Clk, Enabled, Prepared};=0D
> +    /// use kernel::clk::{=0D
> +    ///     Clk,=0D
> +    ///     Enabled,=0D
> +    ///     Prepared, //=0D
> +    /// };=0D
>      /// use kernel::error::Result;=0D
>      ///=0D
>      /// enum DeviceClk {=0D
> @@ -481,7 +512,12 @@ pub fn enable(self) -> Result<Clk<Enabled>, Error<Pr=
epared>> {=0D
>          /// clock or threading it through an intermediate state, e.g.:=0D
>          ///=0D
>          /// ```=0D
> -        /// use kernel::clk::{Clk, Enabled, Hertz, Prepared};=0D
> +        /// use kernel::clk::{=0D
> +        ///     Clk,=0D
> +        ///     Enabled,=0D
> +        ///     Hertz,=0D
> +        ///     Prepared, //=0D
> +        /// };=0D
>          /// use kernel::error::Result;=0D
>          ///=0D
>          /// fn read_rate(clk: &Clk<Prepared>) -> Result<Hertz> {=0D
> =0D
> -- =0D
> 2.54.0=0D
> =0D
