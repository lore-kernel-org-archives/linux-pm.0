Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F659421887
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819721; cv=pass; b=mwXMVjfrmmGV3bNt/YD1XkU4OgBLCESA7awjkGTzEDFhqpu8vEoK43BuF1TinBmZbpGu4ZvmIsHIA3yms4BnU7RVH9M4rAslxqJcakp7CDVu7NbpJhTHf8z71K7uf3YKv87WkWI2aj/QZBdKUXPGcmoozIZ2SFUNq8yo/za9kBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819721; c=relaxed/simple;
	bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qporlGSYJzSLteor+sYRYpO689miOV3ekCckOHHhOy5JSLlGJj0zkSQvBm+SavlGCtL6h2lpW/RqbXEGd0FwsJbbd5i987zn8d9rL0XWtsoEZrZEmboYqE8dRKQ3fKjopg41hMPIZrGyCJEWfS+7HZLtoVTo++n3IHPKzG+TyEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlXrT3lW; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlXrT3lW"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f114d129c0so899851eec.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779819719; cv=none;
        d=google.com; s=arc-20240605;
        b=M5DUn5UK2CnaG/HOShMEjqXhRU6f2ghL0GH8DmFeK/wz4mzK/uLgtHFcw4TaDqMp4+
         ZpRngUkEhdVqPZXSTGG1tiFXLyJzguMD07lXXpGPPj4oOH/0PW9xlQJTFbjbHqe4hD3T
         86Y8KFvdN4w+HnV/DAxaJDjEC1NDv6rJRyKhC2Go0AdygSq5tTi43b7oG7p5ECHuvhvY
         j25jWZX1iQICwyTOPatby5y9nXIMOj6ADR6AukFcpa4+ULg+Ste5fk4Ue7VNS/I/t32D
         dxAH4RUYjQwI1YCpo6kyuHnXsf1TE5gSoKsuA6dhOZrn9jIYSyWKUKTV3WrEHEzBdl6K
         7sZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        fh=W5mR1JwZh/o8EvdO5BdZqNnvNZZ8b9G7k0Oz9n+PprA=;
        b=IyFz04h++3mWegAKvR+zm/ASmBjHobULG5k3TlaOm9jyms0Era5EtoGds+uThKwrry
         JrGdZIoKGBXpNPeFFGiqjrw5rjaFoQbR56HYItbgWHXPS4ZNkx8Uu9Vjaobl2y6lht8g
         G1rY5I2Squdn6m0n6rdQfOHER8xs4W7EQxS+2u0boAX9KN7ZNdt53XhfbrryBasTkk7g
         PVvOSUDiMX75A3c/lkGKqbEXToqZ2bzmYCeCT4onxDt0LlwGQ6VduTZ78L4xhs/JndwR
         h5vx5DD+Ilrqs1PvDMEGnJWNgXi0X4swxob3NpQvDTMqPPMb4ztzG+JNvRWnN+S2FYm7
         F0rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779819719; x=1780424519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        b=qlXrT3lWn7CREfHFK9zMeIZFg0kNvix1PpPz9wUMf+cvc2WDwVU0o4MscpxyJZhsGI
         CwXWZ/zyfXOhEd55gNKMGYb1D6RsPL5KQCZ8ZPTolJcNjHcvsCeR/O0ha9c4quLkTHBp
         9a1881kAzfVfGOoLWAv/H1W7QLffXVCpSuc+KeweCYGVMxhYtGMys6zfzis06qTG7lgh
         q7IJs5llE5+fvdiKNtaVooKmVgF2yaUjVRdYtljW1wmVs4FAjMBJed3TUB3bpB3Tpl+7
         J4O28IKYG47fna6IZj6UJ8i/pJH4mQHEAvWcbe6pTRn3yFCJi07wFqJsve15L+6ZnUv1
         9C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779819719; x=1780424519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        b=OR8LPi+Ueg5O0nH5d2pCCKYfubcy0r3u24aS/7QY00oFLR0ZOU9Mh4jffX0gpIfKbo
         TviTeQn5s/ZklObU1csdLKzcyxyeNaQJtGaB0w0MFtStj7BhDUCkI0hpEIcpkB38MWGo
         jZI0IojBI+pXzScZEy4ZD6HOGZeGl50eBfF/YtJ1o2xV6Jbq1sECaXil+2GFY41YS/P8
         DwXGLMeO28zHDsh55uCwGCI38/m8ZRbrZ7RdVq5qYnmNnEucOnXO5kaccB9DNroJ97mv
         xyiQVwuxBk9gAxTO8PNLu5Eb4A7wt3ComT17MUxwcacObV5XSs8SD7OvPmyf77ZcW9Gu
         XwAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ewRNa37gSZr3pvf5okN0UOhe3vjrrTAxka2s4NcSLftbZGmXkP6E6qrjLkdJu6LUi3KOVu3F7Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6aQurOVjVcHaty29TQ6y3l8AIRWtLBblqGB2bbbWFqHCK4h4O
	fezUfyfbitnX9/r35wbI6to6PodjY+WsZSQETgxHcWEZavx1Q/JvAfCJbHMFGFHh1D+12074gQY
	kSLYyZKAng0u65J8lReCS8hhvIrzbtC4=
X-Gm-Gg: Acq92OFEFVQSHDhnuDfV+GMiMN3vw1zLJduSQUiS5sEcjLaBOL4izfYIwSmaJf5X24N
	wYfeljb6CuEx8mgZWrj7mgZ6eCueHW7L6VeL0oCVVtfSCjlsbjZv+0rgIavy8FkH07+sfGSAOG6
	vk13ShXn3PuQkjETUJHWsV1mfRcqqtTG+MLlN0aO2LMND32fUVRa4yQBR4Nx7XINjDSkC8rveWH
	JnqP0qof2zdK+eVoWtxh8kf0/yOMPtUw56mgJyxGogwC85YV5eDkqdPYo7Yg47le4Oy1xyeWPoG
	krPie847sNp8xHXy1qBORVAjL82h4YKrVhabmUlaFzqCybR2J3mLmAIPtcRWclr/LCeqB5AQVvr
	42tTAaIN129qDKloPh3oPVSY=
X-Received: by 2002:a05:7301:2b06:b0:304:2af3:5fef with SMTP id
 5a478bee46e88-3044921564fmr4123223eec.8.1779819719412; Tue, 26 May 2026
 11:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525202921.124698-1-dakr@kernel.org> <20260525202921.124698-3-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-3-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 20:21:47 +0200
X-Gm-Features: AVHnY4LERaGUubmcoHWuZ6pDVh-Er4DRAsv1wa0D_Oc3ExDNDH2ULqOUOsIQmwA
Message-ID: <CANiq72mNqdOmQ3Va=EF-Fg+-BXW=O=px4z4+YQTS6wzL87=ZHQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/24] rust: alloc: remove `'static` bound on `ForeignOwnable`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com, 
	ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 10:29=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> The `'static` bound is currently necessary because there's no
> restriction on the lifetime of the GAT. Add a `Self: 'a` bound to
> restrict possible lifetimes on `Borrowed` and `BorrowedMut`, and lift
> the `'static` requirement.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
