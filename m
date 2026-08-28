Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454F35E92F;
	Fri, 28 Aug 2026 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787944346; cv=none; b=A6w27s0UR+nhqpdqPAGb0T4eUPU+UEEjoseljJYn+4GzesKsflU5bY2l6B7KwLvsnWxMomem1X1/aX3KmibOXNb48gmCzCDx9SpistMUGVEov5bJpnYwSWv8PXOP1rZ/dDk2r3xhb4ZrAEfCfylnF15FzFw5CxQKTyQnn3LZsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787944346; c=relaxed/simple;
	bh=w4nQpbW2SJfEH8/UMUa+zqT9BEUAGKdaa63d0JTf3Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWILURSDEwyieALPWD4gPIfcUfYfTTVD3yMdWwH6szDblI302teW6Dxu+1ItvA8Z9ypticIqjfV5NVs/M+e3HL5QFpM4d5DMrNsUy6Qdx9lmpoDuVcSj4M43n8Cv+EFwVmN7A7L9ujF8XhxexLMtObDHY9acyl9f7lmAwz9mSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=MCku4eFE; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="MCku4eFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1787944337; x=1788203537;
	bh=FeJlaW2B8oO576wp67QQ5FK5OyHGETUHK344nwqMpYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MCku4eFEFfnuU4wTKnRsvfHFKD9y0nP4mJ8meIJAAV5WwadywMYJu18hVP3D1GIcQ
	 RLj7CcybbRpYMPgQwQ90aBxYne1p96UAy0EGD/qe+W8fKQ2CBKhgh/sjhCAE0rOKx6
	 rV30iq5XHWCpJcP2s/rcYdXiY97CPtv01IofiOz+As89ttOIi/iIMoSbV3kLvFLSDH
	 17JtkybS0JuGH/ivSEtkhjrpMIhxYwR3oQf+TuL1XRbFD8BKZPkPmNKzK0bJyjy7Oa
	 rSMBBNsVZsph4CTYNj7wOGW8YiSUkt6xdNAeWZ9/F28zDykCZQtYFvelR1R1B/yxTY
	 7uF4RquQFcfvg==
X-Pm-Submission-Id: 4hWp0t3wnKz2Scht
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: cpufreq: reject NULL from cpufreq_cpu_get()
Date: Fri, 28 Aug 2026 22:11:45 +0300
Message-ID: <20260828191213.45530-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260828161834.29539-1-mehmet.mkoseoglu@gmail.com>
References: <20260828161834.29539-1-mehmet.mkoseoglu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Aug 2026 19:16:57 +0300=0D
Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com> wrote:=0D
=0D
Hi Mehmet,=0D
=0D
> cpufreq_cpu_get() returns either a referenced policy or NULL.=0D
> PolicyCpu::from_cpu() passed its return value to from_err_ptr(), which=0D
> rejects ERR_PTR values but accepts NULL.=0D
> =0D
> If the lookup fails, Policy::from_raw_mut() therefore constructs a mutabl=
e=0D
> reference from NULL. Dropping the resulting PolicyCpu then passes the=0D
> invalid pointer to cpufreq_cpu_put(), causing an oops in kobject_put().=0D
> =0D
> Reject NULL with NonNull before constructing the Policy reference. Return=
=0D
> ENODEV instead.=0D
> =0D
> A KUnit negative-control run reproduced the oops with the original=0D
> conversion. The same test passed with this change. The reproducer is=0D
> available on request.=0D
> =0D
> Fixes: 6ebdd7c93177 ("rust: cpufreq: Extend abstractions for policy and d=
river ops")=0D
> Assisted-by: LLM=0D
> Signed-off-by: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>=0D
=0D
This should be tagged for stable:=0D
=0D
	Cc: stable@vger.kernel.org=0D
=0D
LGTM otherwise.=0D
=0D
> ---=0D
> Changes in v2:=0D
> - Format modified imports using the kernel's vertical import style.=0D
> =0D
>  rust/kernel/cpufreq.rs | 18 ++++++++++++++----=0D
>  1 file changed, 14 insertions(+), 4 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs=0D
> index affa2b9490ef..4b992ea9a0f0 100644=0D
> --- a/rust/kernel/cpufreq.rs=0D
> +++ b/rust/kernel/cpufreq.rs=0D
> @@ -14,7 +14,13 @@=0D
>      cpumask,=0D
>      device::{Bound, Device},=0D
>      devres,=0D
> -    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABL=
E_DEFAULT_ERROR},=0D
> +    error::{=0D
> +        code::*,=0D
> +        from_result,=0D
> +        to_result,=0D
> +        Result,=0D
> +        VTABLE_DEFAULT_ERROR, //=0D
> +    },=0D
>      ffi::{c_char, c_ulong},=0D
>      prelude::*,=0D
>      types::ForeignOwnable,=0D
> @@ -29,7 +35,10 @@=0D
>      marker::PhantomData,=0D
>      ops::{Deref, DerefMut},=0D
>      pin::Pin,=0D
> -    ptr,=0D
> +    ptr::{=0D
> +        self,=0D
> +        NonNull, //=0D
> +    },=0D
>  };=0D
>  =0D
>  use macros::vtable;=0D
> @@ -687,12 +696,13 @@ fn clear_data<T: ForeignOwnable>(&mut self) -> Opti=
on<T> {=0D
>  impl<'a> PolicyCpu<'a> {=0D
>      fn from_cpu(cpu: CpuId) -> Result<Self> {=0D
>          // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CP=
U.=0D
> -        let ptr =3D from_err_ptr(unsafe { bindings::cpufreq_cpu_get(u32:=
:from(cpu)) })?;=0D
> +        let ptr =3D=0D
> +            NonNull::new(unsafe { bindings::cpufreq_cpu_get(u32::from(cp=
u)) }).ok_or(ENODEV)?;=0D
>  =0D
>          Ok(Self(=0D
>              // SAFETY: The `ptr` is guaranteed to be valid and remains v=
alid for the lifetime of=0D
>              // the returned reference.=0D
> -            unsafe { Policy::from_raw_mut(ptr) },=0D
> +            unsafe { Policy::from_raw_mut(ptr.as_ptr()) },=0D
>          ))=0D
>      }=0D
>  }=0D
> -- =0D
> 2.55.0=0D
