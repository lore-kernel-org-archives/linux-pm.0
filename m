Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2E3955F1
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637305; cv=none; b=coP1mx7sfzHZI9XwJREQiWeJtzUcx3JSQjFqXt1Az2CcZ9ejnCUjwsfAQ3GWLFT1Gw+Vp65kKFDT8xnu8r3OoX4b3JHA8p+mBBdlGw+AU1GVVjOop/0i5BNSt5mpsCHPqwYvySodlCjlqUTNW5HgShhb/LxOpKdkYm9DClU3UO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637305; c=relaxed/simple;
	bh=LP+8poHVh9zbjYuek8fKJ279TAcL7jm45h440IQz+Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrsDGw275DhXEzbOxfZ6ZbOU7mFYi+Qw25yEUwuFpxKis5KISWjpKkM13/52i1vR1tfvYWIusMzysyFJs3HrLA3L/q8lFgGdWDHdHfAVwJzVKPBups+9oDihyuXQUmEx81LoYqJV91A5vzCkXts7lptJBz7Tg95kcySpsw6ReS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id43rStp; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id43rStp"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-57516e08474so6898182e0c.3
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779637302; x=1780242102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QETOjP8nSu5eBP6GGmjCPAaYCLzkQOtWRPWzeg//2ZU=;
        b=id43rStpdcOaLZcDNy37UfEr59a42gmeG3VVvLGcTa8S6Ov6zd3YrWH9sxvqVRkUO0
         +OT3aCELIfz31AEniedNby/stq8YxBErjI8YHBLBwMUHoWopqOlizn59AOiiQdXNtljB
         LLwUDRpBiaN3llpORk7+Zbe62Brv5UdubSix/t8rmpsj7VWshNToFy4DNuSKbxStLLnP
         KSrJFn9PZlawILud6319J5FP38nB6hPM5r5KsiUEGiBFNr4TUSB+MowYslexAJazVHWz
         UzSACBGJz0SuJne6njsaVIKYX9dNIcbEWMoiXLX+rOENabJTUqbwX2KgBPJddU6vH3Us
         q/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779637302; x=1780242102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QETOjP8nSu5eBP6GGmjCPAaYCLzkQOtWRPWzeg//2ZU=;
        b=TGZ5dYZgH5CNyHs8xpBW2KlTOmBQi8gHDbDMdBEEoBZv5FB1jHhs6Hldvbaqs++wlG
         Vu1cbXaKgmgFB18UIPWGUFxDPimbIph6ZD5pmOsdIKtwIAKFVU0ZgOyIK0dtVu3iAE/a
         7hHZUMEIlfAQxttE2wfmfVd5bGiOW/k2XCAcXpdZgmfVAvtlydyzXSiv+9cKh4cvMC5v
         q7b3iNTImF3OwxRXI1MqKhfbUbnfaJ0eUVrUelVpFdYjIG02Y5Kb1KNSaKBWmd3GjVpP
         xFanbOswWANWXgCguTOmuLpoewBd5cGPIJ+cGiNdbWu/TKFfOGRJi0JPKlyNKg5iqXdV
         3WDg==
X-Forwarded-Encrypted: i=1; AFNElJ/XaxJzqlRGJPpp5qzFcGIH2jxwk8CtH06pYdgZCySxPTVFppo6TOu3FDiocRrrmRbCyKdvKNfzTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCKASbKi9a84PaZkQ0kucrx3JgwCf0/d37CqiopWw2tjGDC1p
	nV2J6SB9W7Ma3jQJDZ0Mm/P31fvo8MsWFBfAGFO0k97k0qv+z01JYrE=
X-Gm-Gg: Acq92OF3RwV9Nb89qtGNe8wZWODh4P5fzXvCsWBelrwV9qLuyz0Mks/9jpqWuYZzJCt
	YGHXanqnm9HrPRram5HzhVlItGWtwMKOsfNYZ6p+n+NEfZNFZpUs3W+regzSjzL9CFp504cFPHP
	rILoC+a5CT27xXUEvNd6u3A2nElN9hUtjX/AXrhyjYwNa/kJbaytylBlBr6YG1fiVfzfzRq909z
	BL+56FIVUzOHGWDcnJv6B6owyNor1c6uhXLkY+bMjSLHjwflYFYAYs6eKniT8KAx4seMzC1ayY3
	anhO/KRiGZd6wk1z1AjIJSuW2u8dL9a+pVFRYujSNpjwfW2dtRrHlqvZFx03GHoMBioAnrqeo/0
	PVrQv8xwf+477RP/R2sdUpCx9yMeMlAB/seUkW2ns6FyGys+gHWIRt1FZWvjHXbXoYfMvKghcf2
	39GEz+Zj+lBPHqjGdikXUZBPLUPFSn2dhJsSufN7J+Sgvj7MdWap1iFs7HQ+Kt
X-Received: by 2002:a05:6122:4317:b0:576:1a8d:8989 with SMTP id 71dfb90a1353d-58658a3d6f0mr6262665e0c.0.1779637300919;
        Sun, 24 May 2026 08:41:40 -0700 (PDT)
Received: from linux-dev ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f23ee48esm9115364e0c.3.2026.05.24.08.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 08:41:40 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] opp: rust: mark OPP methods as inline
Date: Sun, 24 May 2026 12:40:16 -0300
Message-ID: <20260524154021.34096-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building the kernel using llvm-19.1.7-rust-1.85.0-x86_64, the
following symbols are generated:

$ nm vmlinux | grep ' _R'.*OPP | rustfilt
ffffffff81801560 T <kernel::opp::OPP>::freq
ffffffff81801540 T <kernel::opp::OPP as kernel::sync::aref::AlwaysRefCounted>::dec_ref
ffffffff81801520 T <kernel::opp::OPP as kernel::sync::aref::AlwaysRefCounted>::inc_ref

However, these Rust symbols are trivial wrappers around the
`dev_pm_opp_get`, `dev_pm_opp_put` and `dev_pm_opp_get_freq_indexed`
functions. It doesn't make sense to go through a trivial wrapper for
these functions.

After applying this patch, the above command will produce no output.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 rust/kernel/opp.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index a760fac28765..62e44676125d 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -1042,11 +1042,13 @@ unsafe impl Sync for OPP {}
 
 /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
 unsafe impl AlwaysRefCounted for OPP {
+    #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::dev_pm_opp_get(self.0.get()) };
     }
 
+    #[inline]
     unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         // SAFETY: The safety requirements guarantee that the refcount is nonzero.
         unsafe { bindings::dev_pm_opp_put(obj.cast().as_ptr()) }
@@ -1095,6 +1097,7 @@ fn as_raw(&self) -> *mut bindings::dev_pm_opp {
     }
 
     /// Returns the frequency of an [`OPP`].
+    #[inline]
     pub fn freq(&self, index: Option<u32>) -> Hertz {
         let index = index.unwrap_or(0);
 
-- 
2.53.0

