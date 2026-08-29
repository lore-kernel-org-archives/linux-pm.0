Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D380379ED4
	for <linux-pm@vger.kernel.org>; Sat, 29 Aug 2026 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788033191; cv=none; b=FNMB/CjOtMUHxSlQj0zD+qpntDNgKjLhTN4lbE/xB6jP0tVWOZVKcLwV9NAw4xMqIGEsU0CMwFx30OfA0oSk+yBFy70FGbMNNwE77Us/XWAtGVKNWS3fTuJEIV3q/r340GhVhhhngJW/RfTFsDh4uQL1nRUvh7CkV2p2vlB9U/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788033191; c=relaxed/simple;
	bh=UrzGbiUpmLrHNiKTBB99Yi6K10TIVUQB17wqWsBIXaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YviY51hXHhqmUBDBdL0+LlSziQ4WSaRFfr6KDtwL7rsLcSGk43KWLV51Q5bUw0RWISVuSOjI1O6Xzns2TrjbkhcX4W97LfAI8c/aWcyxmQweDkd9peq6PcYUr5b8c6qZPvXNP7kTqo8Ok2MOvzqBLDKjfl6ONgmQT+nZ1j7FMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Ji0kb+hz; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Ji0kb+hz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1788033176; x=1788292376;
	bh=/dEiKOIuv+SZQFcpv7PhRYypxPlBSUlnYBm5pdQOQRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ji0kb+hzhZttPBszUxW85mbpMZST7a8OFyDAne2OXLUNDN4uB4hI8Me5kFUKmuDz6
	 BvPX21StRW6wcqSjcPxvpD/kF52A7bLU9gy64VytZM5UWxSsCVFKcVis+DGXkiDXM3
	 UwztLIUkdegaJI5hE4zArsDwIttVzbIXMvyI7JG9iE8jG5QIil96HhYj3zWdFb2dR4
	 vfrshmHDCWVElUjT48DyTdUxGzQqSMb9bpOBiFa5xFKW7vfiy1lRQMrB8+B6xY8fxB
	 /WSDk+4r4wPKWuya3Be/+BIOhhIdV1U6KfOTx5clPpPuTCM0WMPpcnRGFAKgVtzGpG
	 rXMkXhpV+pfOw==
X-Pm-Submission-Id: 4hXQsH4xqyz1DFFg
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
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v3] rust: cpufreq: reject NULL from cpufreq_cpu_get()
Date: Sat, 29 Aug 2026 22:52:45 +0300
Message-ID: <20260829195250.24625-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260829161013.102967-1-mehmet.mkoseoglu@gmail.com>
References: <20260829161013.102967-1-mehmet.mkoseoglu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Aug 2026 19:10:13 +0300=0D
Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com> wrote:=0D
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
> Cc: stable@vger.kernel.org=0D
> Assisted-by: LLM=0D
> Signed-off-by: Mehmet Koseoglu <mehmet.mkoseoglu@gmail.com>=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> ---=0D
> Changes in v3:=0D
> - Add Cc: stable@vger.kernel.org.=0D
> =0D
> Changes in v2:=0D
> - Format modified imports using the kernel's vertical import style.=0D
> =0D
> v2: https://lore.kernel.org/r/20260828161834.29539-1-mehmet.mkoseoglu@gma=
il.com=0D
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
