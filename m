Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6D348C60
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197670; cv=pass; b=eMlTCvoab6K1p3gJi5Tcy4tA9lqLPp91D2KfAk7VqNxepyENktsMr7NC4NDhat/6Of0iRL5Qia6AsNZFwDKxv4lkpDMDvrbrRMYNkNYheJs6uCmSjyLg8Ca2+k3LzZQYZ4FzMqM4O/YyPdJKp6j22ZhLhlq7B6lYT76JTbC+IVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197670; c=relaxed/simple;
	bh=naF+eFIBVaPQxxaOGNrVUV2zt+dbyRkLeG9JHqTunLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghcEnogt2OitBNsYdXMz627IpPLM8JyuYs4aw95Q4JBM8Qxz2aaMYmWckKXkyAQcqpDHy9Iu0dk0sN0dnc+1Q1MHj/akkZ+rsbP1voJxjSfUcTM0wY6WvsVQjc1aOty9fkoBxnYfpNshm6PaO9xFLVnHpt5p/MQdM5SguOYduQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3QKAkOH; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3QKAkOH"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f6e6a0a215so213658eec.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 06:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197668; cv=none;
        d=google.com; s=arc-20240605;
        b=d1iAC59pJVoH7A30eN8VgBAxgirJKAbBbqb+5x9PSe0gLvOrRCs7qI+7c9lxUAUbfn
         0SUPko41xRtugRRPTjLskp91DpwoP472XHYxBbLdcGp/M28lxiL5D4J4o9a0RickblfU
         sDVywedb1NP/LGIn50WjardWgFo5kicijbOBs7AYEzTHB9i2OVRiyePk2q0b7iMJ9uOw
         H2QtqkDnQFMSVGJnYYQ8gDK3Hpu9A20du7G95qnbvHcyWGRyAVK+TeUGwtC/4prJTUAV
         q6raChU4KYYqhyH+FiqJPy8afS8yhdZjm1ZEiRL1kgJFY9AHVMfbzP+xAkDPyFDFiWHc
         e61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        fh=QsMorWmOjKO0H5Psba7VJp63MEHEbgn/xeAiJDB/RFk=;
        b=PU95TvbbZLdLWbVTm9Jb9qrdNGnE2JBIYiFWkkH9r5hSuMf0D8zGa4yQKUmiyuxtb3
         kO1VNOG2jmVzJpxN4lauby5oS1sOwUGfCQE3qmnLnHkpYGmcmlVYr8YORNtbVJvYmG/r
         XH0KhcTp+zMvwNBrIb9INcWHyqD0b90JwVdnvpcwzRG51zpH2vU9nwbB047y16mLE7Vk
         SvjsiodgwhDsKKt6bXy90UH9awZwuhuR7sRCd3EOdpwnfr+IS7z7bakD6T6EN+mPNzb3
         r+7ytIxNvTT41479KsQCv6rCF6jMa0zw0DjzP5SmoHEhc2Ugh73HRBTVaBDH7dzkfQY2
         g9LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779197668; x=1779802468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        b=Y3QKAkOHC6LcGS5ofPga3r5bKLfejRPRa5knoWuBdjIQPROhsMlxoCgtWmEDooiLsm
         0+80J+YEhGUXdmi5bn8r2tmzxbHS18gfwjoF9FB1iKPEfkqvByO7GeN85Ge6jjDuaS/B
         UGejyckurv4npWtPDzpzm1RJ87DSXK2HvX+PxJ4BDXkVpSEZfe18oGhU0vJBd3EkhHsO
         ZULy6yrBlR05xc4N5tXJXxbjda/Jwd4iYxb4A6OPBsDNsUc35u62UEuzkwYz2yVcpC2c
         Sj8IexBkLvoJvITBQ2aWGpVgscMHQcWLFEYxaAtCXBVe6CU7A77UligOFth+txU3f362
         0trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197668; x=1779802468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        b=foNPrKrPxeXLA75X/8HcQ5jM7cqSpc8s5Yn1/SWbpDlKWHRbSkIYAeJJedfQpDksyc
         AtkkvAwO4IT68x1gIrlSeLYhz3TOCgVmi4kyULj4N13A2w7WRurNhRxwpzzhQjMk9JmC
         2UL6B6u7llQN98VV6L+O06Ep0bJf76CuBcoQ8ayhmqKB94pxeCTfGz8YyVqY5mX7O6X1
         0dNEBQWewwEy5PDJpRl8nCNvaJWQSEk5adLF31DQUQWi+WC2j1bvItbRd4DqKZxZU4no
         AcmeiGN72PJOqz58yn5BXl/YQTuzDh4hJ4orj6+7yXPFT4hLzCpvIAD9pRF5Y8PCtKwj
         NIzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8L2HbhjV6j7m7sGdrVQvDQ2cG7RjQj/WcVn0eA6rFBwjJDU+6xJjmXKU9obwcQmxeFx9cITBvfyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzBDWmJdaWC6kKu9xA1AqwPRumTb0firOghenMy1zeAuJxtfV
	QpdutLfN9u4PrtYN5Ho4joLKgI+8uvWPEq/dBoGXEBJ8UyeKpU05KpMLYmqagZaYRKdPjSNSw8B
	FRwJPvliPpz0VT+PFQ6bfhplj5+M+o/c=
X-Gm-Gg: Acq92OE9RbJmSBqmyCnka9zSBqVhpQGyMgvHJ+gaMTZRKN5M7LDU1uKmDPdfbe+XA8l
	Dc826OV/ASoQXL+AuvIIH7sB31tGaaN30halSvdYFlM+UwUezfUUCoindhVhv6uX7RDJhCsEyQU
	R3t5lLy13Va9YaO3B8ULdLdM0LEp7ncqejNWn8qulfmxO4eRPW4vsK4JfPJ3yhtcYCNS5zzWlS2
	SPQ53lXgKwtKpxGR0sQY8Q/5xspD824s2AQ0AssLb6cET7JJwEuG7cBnN6lqmBu+5VXAjPiM6d6
	mGHd7fpAOW0voOeSgqDOoRH20EON0DM0Prl/puMpyVDQX6AYlvPBHcBOxrIdkyxpmzlAQdjxbrB
	M2wI6fUkBfaur5w0AyaOnnH0=
X-Received: by 2002:a05:7300:dc14:b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-30397b88952mr3989391eec.0.1779197667973; Tue, 19 May 2026
 06:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517000149.3226762-1-dakr@kernel.org> <20260517000149.3226762-17-dakr@kernel.org>
 <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com> <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
 <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
In-Reply-To: <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 15:34:12 +0200
X-Gm-Features: AVHnY4K5vpbJGhCh2fM0bDGLH-gDIENRDMeBQsxYOoXtqTcl9WixZ1bWmTIZnkI
Message-ID: <CANiq72myVDq9oLyyZqUf3Se9-JLDp=qGhBJy01nOxMaZBRxADA@mail.gmail.com>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Alexandre Courbot <acourbot@nvidia.com>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, aliceryhl@google.com, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, viresh.kumar@linaro.org, 
	m.wilczynski@samsung.com, ukleinek@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, abdiel.janulgue@gmail.com, robin.murphy@arm.com, 
	markus.probst@posteo.de, ojeda@kernel.org, boqun@kernel.org, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:03=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
>       That said, I expect LLMs to be (heavily) used to write drivers, and=
 LLMs
>       are typically trained to be compliant. So, I could imagine that a p=
rompt
>       along the lines of "Can't we make this work without unsafe somehow?=
" leads
>       to an LLM abusing this, while going unnoticed for the user.

Could we steer LLMs to avoid that? e.g. adding a line about `Unsafe*`
items to Sashiko's prompts.

Also, a `checkpatch.pl` (or similar) warning may be doable too, since
false positives are OK there.

It could go to the ASH (Acknowledged Soundness Holes) list we
discussed some times if we end up adding it.

Cheers,
Miguel
