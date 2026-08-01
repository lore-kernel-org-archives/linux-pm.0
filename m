Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB637DAD5;
	Sat,  1 Aug 2026 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583392; cv=none; b=hbRRfrRzpp2peHuaJM/FGfB6OHrlbQoRgzMaZzclgQv9DWLtShb7bYJFXoAc4CgRl6ggAieTOA6Or86tHuIFv07DSfa97M1/Tr4ULR+9TsokxwjYoQInl84H9B1d473x/OraKQJ2/VeWz4nVESiVuc6t//dLvlnK0CB0NkALVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583392; c=relaxed/simple;
	bh=65qyerLOMOizFkJF0mqetQ0ueVqUdZIXN/aKIcrO7lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Er2b4blIynXMzQAzXrFxPKMEJe5gnRrtTOTcDmA3io/4YRyQdXWbbiKGd5EKafa56BLzkglLv+Ct1tniGw/9diNw8cbaBvwcpEJJJltpHT/taxPwl21v6XSNft1E5PPUguJJlH+wcIhP7fxaTbhA76F3rCv5eowAa5avzdlftiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=GBjamspr; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="GBjamspr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1785583379; x=1785842579;
	bh=gNRt5vhm5rzA0r9SYRg4vpPJmSNy2rVVGJFfnD3HI1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GBjamsprGcj4PJ+2tZTITaCwpA1KPghVP4Ho1RdnnRiTjaoLl+mtI4hCDjYBkjLBD
	 82KdhJDeKUC6ujY02rLVX+E1evUhCj5oKPoxhK4rx6b+vSEy0MkLDc9QfVLW9CXQ/O
	 nTTnvcOMLqAxn1jP/gglcT78OMLop3pPKEj+mMgoNmbaTm2cEvHVaKNZeSSGIuDyj3
	 BacKGT25+a5IfltXpp5K+ufOdTr/zIaInIjO7KuOvmqeR0D0ueaHmsdtU7+kq6lQwk
	 kMgPlUQaPo3e10IA8o1AO0u5WjhU+Fuu5lzfIXz/MfaglekZclzpTiRTakMZdZzFC+
	 KKEqnuS5GK7CA==
X-Pm-Submission-Id: 4hC0sq5XCMz2Sd4d
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
	Maurice <mhi@mailbox.org>
Subject: Re: [PATCH v5 3/4] rust: clk: add devres-managed clks
Date: Sat,  1 Aug 2026 14:22:52 +0300
Message-ID: <20260801112254.313381-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com> <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 06 Jul 2026 11:37:14 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> The clk API allows fine-grained control, but some drivers might be=0D
> more interested in a "set and forget" API.=0D
> =0D
> Expand the current API to support this. The clock will automatically be=0D
> disabled, unprepared and freed when the device is unbound from the bus=0D
> without further intervention by the driver.=0D
> =0D
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
> ---=0D
>  rust/kernel/clk.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++=0D
>  1 file changed, 46 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs=0D
> index dd5fd656271e..b9a44f83843a 100644=0D
> --- a/rust/kernel/clk.rs=0D
> +++ b/rust/kernel/clk.rs=0D
> @@ -96,6 +96,52 @@ impl Sealed for super::Prepared {}=0D
>          impl Sealed for super::Enabled {}=0D
>      }=0D
>  =0D
> +    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound dev=
ice.=0D
> +    ///=0D
> +    /// [`devres`]: crate::devres::Devres=0D
> +    #[inline]=0D
> +    pub fn devm_enable(dev: &Device<Bound>, name: Option<&CStr>) -> Resu=
lt {=0D
> +        let name =3D name.map_or(ptr::null(), |n| n.as_char_ptr());=0D
> +=0D
> +        // SAFETY: It is safe to call [`devm_clk_get_enabled`] with a va=
lid=0D
=0D
Intra-doc links won't work in regular comments.=0D
=0D
> +        // device pointer.=0D
> +        from_err_ptr(unsafe { bindings::devm_clk_get_enabled(dev.as_raw(=
), name) })?;=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound dev=
ice.=0D
> +    ///=0D
> +    /// This does not print any error messages if the clock is not found=
.=0D
> +    ///=0D
> +    /// [`devres`]: crate::devres::Devres=0D
> +    #[inline]=0D
> +    pub fn devm_enable_optional(dev: &Device<Bound>, name: Option<&CStr>=
) -> Result {=0D
> +        let name =3D name.map_or(ptr::null(), |n| n.as_char_ptr());=0D
> +=0D
> +        // SAFETY: It is safe to call [`devm_clk_get_optional_enabled`] =
with a=0D
> +        // valid device pointer.=0D
> +        from_err_ptr(unsafe { bindings::devm_clk_get_optional_enabled(de=
v.as_raw(), name) })?;=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
> +    /// Same as [`devm_enable_optional`], but also sets the rate.=0D
> +    #[inline]=0D
> +    pub fn devm_enable_optional_with_rate(=0D
> +        dev: &Device<Bound>,=0D
> +        name: Option<&CStr>,=0D
> +        rate: Hertz,=0D
> +    ) -> Result {=0D
> +        let name =3D name.map_or(ptr::null(), |n| n.as_char_ptr());=0D
> +=0D
> +        // SAFETY: It is safe to call=0D
> +        // [`devm_clk_get_optional_enabled_with_rate`] with a valid devi=
ce=0D
> +        // pointer.=0D
> +        from_err_ptr(unsafe {=0D
> +            bindings::devm_clk_get_optional_enabled_with_rate(dev.as_raw=
(), name, rate.as_hz())=0D
> +        })?;=0D
=0D
Just fyi, there's currently a bug in the C implementation of=0D
devm_clk_get_optional_enabled_with_rate() which I caught while reviewing yo=
ur=0D
series. The fix patch is already on the list [1]. Other than that, this LGT=
M.=0D
=0D
[1]: https://lore.kernel.org/all/20260801111637.304590-1-work@onurozkan.dev=
=0D
=0D
Regards,=0D
Onur=0D
=0D
> +        Ok(())=0D
> +    }=0D
> +=0D
>      /// A trait representing the different states that a [`Clk`] can be =
in.=0D
>      pub trait ClkState: private::Sealed {=0D
>          /// Whether the clock is enabled in this state.=0D
> =0D
> -- =0D
> 2.54.0=0D
> =0D
