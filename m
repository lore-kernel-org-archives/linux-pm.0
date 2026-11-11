Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416098;
	b=Ppp4aPirZB3ZUjxTnnejucHR4jwndTvQd+R16VR2xeJiFTmIBQ/H3DYzxvFaFPRznmUz
	 obcaren5xmhFJLcO8RIhTElxRhbY6ciiVYo0ZFwyOqDnPvuxVsXcToD69FTRTPwADSZtD
	 XNFMBChZYc+2ANAKArRZFSrfGXRt+EDcQ7z3IrdxtRqAqcTVmiRDvQz0RI3I8+IclXOr8
	 GirCJDQ5A3eZQfkBQxtgPZYyX9pVKvByqdyNf3e5LyhOQ8bfgEWCqYUjfv+XFK90U1Uvv
	 w5n+tFHU74l6Hr1jmi4jcBEmDdNbYzlrHxQzhIPiAdQiGVDHY8m+RtyAIpS0TeziSyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416098;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=anBX1iahvKt8bwlS8JRUYhxSTZUTNVrvDroUXrWSpb8=;
	b=lXaxgHlQHIrJn1d+inkax5TX+UefExrlZ7ZEY/uz/+CQuem6btV8Lb1eEYpBNgfVPnYw
	 GRDbqz0zzU3u0dje9uoSRCepdL2kLV9JsWeII56z/Psh2aIpTDYyQf36900Z/LRerfTdc
	 lKbiBcudUxhrUHvGsc29tgPiGDwD3/ngxDoYPHd0e3Mq/ks9kNIeF95NQEvDdsDu6c81q
	 qP8XFKB3AjzclwcAE094DmraYf/1Z9DLg+Vj96lgjrZR22GKlcI7Vv5DhAD9qqeo52+2c
	 /De/j6IsCsvuvJVt0xwT47bfM0a3u49N+cj+/dXv/F4RD8uUR70adNp2U2ragEZOF0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="YrRCI/SC";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB2606A338;
	Wed, 11 Nov 2026 16:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66EB2606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=YrRCI/SC
ARC-Seal: i=1; a=rsa-sha256; t=1794416045; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MtTGZx4kbRO7jubVIf2+B7jKJWmy8aP1wK1Az6LPjajCTNhMbkLd2PNQiwCvjmGlnzknYrpNeEHEc5du38u8KKGdwpW6CjFFyFPn5qO2oXmaiiVmb271fBaTUVqMoV/n7JEbyc98/PwElPfLfyX0AGWBlGbynLWgPE839jFaF3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794416045; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=anBX1iahvKt8bwlS8JRUYhxSTZUTNVrvDroUXrWSpb8=; 
	b=bIrPcfQGvmUstLvfOrclgBBgRWPfxLaVD8Gu3ouqkSC7SaumggN/2V0dyH8QeCY3NHw+8FXywTw229MAegdvhYAmTCf/oUjnwcQGHkR8ib5Rt5EhwbGsvlaCYJ1vD5RaNEk3q/80HpqBblqnG4zXAM5cIE/w8ztTG733YYDcx10=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=YrRCI/SCYZnWGK6UWC56IKByqgiyk5EnemJkzINpCd5B08tLFoIuKCQ4HvHJlIywJ3bo9w3FD73tl7qFmbP0rtHWWra6odsIjsk0KLa/caLmx6vXuq4DhElAxyPoPFyWKiSDoNajrGIDJ6XJdNd5zbXjK7HC0Ltv2YDoMnRHQ6I=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=anBX1iahvKt8bwlS8JRUYhxSTZUTNVrvDroUXrWSpb8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1794416041785477.2653723756649; Wed, 11 Nov 2026 08:54:01 -0800 (PST)
Date: Wed, 11 Nov 2026 13:54:01 -0300
From: Daniel Almeida <daniel.almeida@collabora.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Viresh Kumar" <viresh.kumar@linaro.org>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"David Airlie" <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>,
	"Michal Wilczynski" <m.wilczynski@samsung.com>,
	"Drew Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>,
	"Fu Wei" <wefu@redhat.com>,
	=?UTF-8?Q?=22Uwe_Kleine-K=C3=B6nig=22?= <ukleinek@kernel.org>,
	"Stephen Boyd" <sboyd@kernel.org>,
	"Brian Masney" <bmasney+clk@redhat.com>,
	"Jerome Brunet" <jbrunet+clk@baylibre.com>,
	"Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?Q?=22Bj=C3=B6rn_Roy_Baron=22?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Tamir Duberstein" <tamird@kernel.org>,
	"Alexandre Courbot" <acourbot@nvidia.com>,
	"linux-pm" <linux-pm@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"linux-riscv" <linux-riscv@lists.infradead.org>,
	"linux-pwm" <linux-pwm@vger.kernel.org>,
	"linux-clk" <linux-clk@vger.kernel.org>,
	"rust-for-linux" <rust-for-linux@vger.kernel.org>,
	"Boris Brezillon" <boris.brezillon@collabora.com>,
	=?UTF-8?Q?=22Onur_=C3=96zkan=22?= <work@onurozkan.dev>,
	"Maurice Hieronymus" <mhi@mailbox.org>
Message-ID: <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com>
In-Reply-To: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
Subject: Re: [PATCH v6 0/7] Clk improvements
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail


Hi all,

 > This series contains a few improvements that simplify clock handling for
 > drivers.
 > 
 > Patch 1 converts clk.rs to the kernel-vertical style for imports.
 > 
 > Patch 2 replaces OptionalClk with Clk::get_optional(). There is no struct
 > optional_clk in C, and Clk already allows a NULL pointer.
 > 
 > Patch 3 implements the same typestate pattern that has been used
 > successfully for Regulators. This is needed because otherwise drivers
 > will be responsible for unpreparing and disabling clocks themselves and
 > ultimately handling the reference counts on their own. This is
 > undesirable. The patch automatically encodes this information using the
 > type system so that no misuse can occur.
 > 
 > Patch 4 adds guards that prepare and/or enable a clock for the lifetime
 > of the guard without consuming the Clk, so that a driver can keep a
 > long-lived Clk<Prepared> and enable it for scoped sections.
 > 
 > Patch 5 makes things more convenient by offering devres-managed APIs. This
 > lets drivers set clock parameters once and forget about lifetime
 > management.
 > 
 > Patch 6 adds ExclusiveClk<T>, which holds rate exclusivity over a Clk<T>
 > in any state until it is dropped.
 > 
 > Patch 7 uses it in pwm-th1520 to lock the clock rate for the lifetime of
 > the driver data.
 > 
 > ---
 > Changes in v6:
 > - Rebased onto the latest clk-next.
 > - Moved the import style conversion to the front (Alexandre, Onur).
 > - Kept Alexandre's and Onur's Reviewed-by on the imports patch, and
 >   Alexandre's on the devres patch. Dropped Alexandre's Reviewed-by on the
 >   type-state patch, which changed too much since v5.
 > - Split the OptionalClk removal into its own patch (Gary).
 > - Replaced "rust: clk: implement Clone for Clk<T>" with EnabledGuard,
 >   PreparedGuard and PrepareEnabledGuard (Alexandre, Gary). Clones shared
 >   a single struct clk, so per-consumer state such as the rate
 >   exclusivity taken by clk_rate_exclusive_get() was shared between them.
 > - Dropped Clk::<Prepared>::with_enabled(), superseded by EnabledGuard.
 > - Named the ClkState constants ENABLED and PREPARED from the start
 >   (Alexandre).
 > - Implemented Debug for Error<State> (Alexandre).
 > - Documented that dropping a prepared or enabled Clk may sleep
 >   (Alexandre).
 > - Used a different connection id for the second clock in the example
 >   (Alexandre).
 > - Used `?` in the per-state get() and get_optional() shortcuts.
 > - Dropped the trailing `//` from doctest imports (Alexandre).
 > - Removed the intra-doc links from SAFETY comments (Onur) and reworded
 >   the devm_enable_optional() documentation (Alexandre).
 > - Expanded the devres commit message (Gary).
 > - Added ExclusiveClk and its pwm-th1520 user, based on Maurice
 >   Hieronymus's series [1], with ExclusiveClk made generic over the clock
 >   state, ExclusiveClk::new() in place of Clk::rate_exclusive_get(), and
 >   a new ExclusiveClk::into_inner().
 > - Link to v5: https://patch.msgid.link/20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com
 > 
 > [1] https://lore.kernel.org/rust-for-linux/20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org/
 > 
 > Changes in v5:
 > - Rebased onto the latest clk-next.
 > - New patch: "rust: clk: implement Clone for Clk<T>". Each clone is an
 >   independent view of the same underlying clock, owning its own
 >   prepare/enable counts; the raw pointer is shared through an Arc so
 >   clk_get()/clk_put() stay balanced. Follows the v3 discussion with
 >   Boris Brezillon and Gary Guo.
 > - Moved rate() and set_rate() from Clk<Enabled> to all states; the C API
 >   does not restrict these to enabled clocks, and some clocks can only
 >   change rate before being prepared.
 > - Made Clk::<Enabled>::disable() infallible, matching unprepare() and
 >   the void C API (Onur).
 > - Fixed a typo in the "# Invariants" section, fixed SAFETY comments
 >   that referred to the non-existent `self.0` field, and added missing
 >   INVARIANT comments on the state transitions.
 > - Added the missing rustdoc link definitions for clk_unprepare and
 >   clk_put (Maurice).
 > - Dropped the redundant `Result` import and the `use
 >   kernel::error::Result;` lines from the doctests; the prelude already
 >   provides it (Miguel).
 > - Added #[inline] to the devm_* helpers.
 > - Link to v4: https://patch.msgid.link/20260618-clk-type-state-v4-0-8be082786080@collabora.com
 > 
 > Changes in v4:
 > - Rebased onto clk-next. Alice Ryhl's "rust: clk: implement Send and Sync"
 >   series is now merged upstream, so it is no longer carried as a dependency.
 > - Fixed the build with CONFIG_CPUFREQ_DT_RUST=y. The generic DT cpufreq
 >   driver only has the (unbound) per-CPU device, so it cannot hand a
 >   &Device<Bound> to Policy::set_clk(). Added a pub(crate) Clk::get_unbound()
 >   for the few in-tree abstractions that operate on a device outside a bind
 >   scope; set_clk() now takes &Device and uses it. Clk::get()/get_optional()
 >   and the devm_* helpers still require &Device<Bound>.
 > - Added impl From<Error<State>> for kernel::error::Error, so the fallible
 >   state transitions can be used with `?` (and chained) instead of
 >   .map_err(|e| e.error).
 > - Added Clk::<Prepared>::with_enabled(), which runs a closure with the clock
 >   temporarily enabled, scoping the Enabled state without giving up the
 >   prepared clock.
 > - Documented how to change a clock's state at runtime via an enum, for
 >   drivers that enable/disable across resume/suspend.
 > - Link to v3: https://lore.kernel.org/r/20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com
 > 
 > Changes in v3:
 > - Rebased on top of 6.19-rc4
 > - Dropped patch 1 (from Alice), added her series as a dependency instead
 > - Fixed Tyr, PWM_TH1520 drivers
 > - Changed clk.rs imports to kernel-vertical style
 > - Added support get_optional shortcut for Prepared and Enabled (i.e.:
 >   Clk::<Enabled>::get_optional())
 > - Fixed misplaced #[inline] tag
 > 
 > Thanks, Danilo {
 >   - Moved the devres changes into its own patch
 >   - Require &Device<Bound> for all functions where a &Device is used
 >   - Account for con_in in SAFETY comments where applicable
 >   - Added backticks
 > }
 > 
 > - Link to v2: https://lore.kernel.org/r/20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com
 > 
 > Changes in v2:
 > - Added Alice's patch as patch 1, since it is a dependency.
 > - Added devm helpers (like we did for Regulator<T>)
 > - Fixed missing clk_put() call in Drop (Danilo)
 > - Fixed missing parenthesis and wrong docs (Viresh)
 > - Removed extra "dev" parameter from "shutdown" example (Danilo)
 > - Removed useless type annotation from example (Danilo)
 > - Link to v1: https://lore.kernel.org/rust-for-linux/20250729-clk-type-state-v1-1-896b53816f7b@collabora.com/#r
 > 
 > ---
 > Daniel Almeida (6):
 >       rust: clk: use 'kernel vertical style' for imports
 >       rust: clk: replace `OptionalClk` with `Clk::get_optional()`
 >       rust: clk: use the type-state pattern
 >       rust: clk: add guards for scoped prepare and enable
 >       rust: clk: add devres-managed clks
 >       rust: clk: add `ExclusiveClk`
 > 
 > Maurice Hieronymus (1):
 >       pwm: th1520: Lock clock rate with clk_rate_exclusive_get
 > 
 >  drivers/cpufreq/rcpufreq_dt.rs |   7 +-
 >  drivers/gpu/drm/tyr/driver.rs  |  32 +-
 >  drivers/pwm/pwm_th1520.rs      |  25 +-
 >  rust/kernel/clk.rs             | 834 +++++++++++++++++++++++++++++++++++------
 >  rust/kernel/cpufreq.rs         |   8 +-
 >  5 files changed, 748 insertions(+), 158 deletions(-)
 > ---
 > base-commit: d3645b43ad60fe1ab3b4a869f6908414d5831a65
 > change-id: 20250909-clk-type-state-c01aa7dd551d
 > 
 > Best regards,
 > --  
 > Daniel Almeida <daniel.almeida@collabora.com>
 > 
 > 


Gentle ping here.
There's been no further comments, should I assume this is good?

-- Daniel

