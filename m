Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514219;
	b=egUi6GDUAzwyDKoN0WeMUO7ASTLlu7WfWOAFav2ipV+SRjDn7KaPazYSThjAnGTY7gWR
	 lxEVIaPc4rNoy4fOauXKA9+CmsPodpuykj1Q4BzFwfle+49VZT8apgE/TY/1LKk4VKNZR
	 BBEoQu0+eQQPa+W0IwB2Ty356c5PZwaUeGK1ZmRlen5YgGvo28VrW06/DmCj9Yim2UF/c
	 9LwpPyNtxgLnDs8e06Sw1+wdRU7TL0i5xPaMyUL1kqB/S3O65G0SBYDBnid3400oWcUUE
	 8TJDMn9FbZ0CRNgDEQf7na9xZwJtro3xwzfvqpJMHeDJa0qA7x84deQBE1Dq1wpmzIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514219;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wMV2nsSJl6xGkmfUvtbbR/+a8KpdpyQgadjZKqs++do=;
	b=JyS63qIROSLavudv98Y0dLS9aVFeDmyRwysHtdsz5fZ9UrLbQtpFXD8oczw35FwBanRH
	 e0LQmd9vb29yJzZc+PodyEN79trUrINyh5J6uickueEIE/ABPOYIm+i+0+Fq5Rq0cA7Y1
	 urLrINwqsoEsFeLgI9EmTe3axvntYdmdBqBXRmpp0KTMwNeUt9sSmkgXX6+RVrAQhiT08
	 njouAjV1ox1cvcpH9Ay/mCR5mo5VX3GUhWnf//R1xXXgFeMvvShboTEkvOmZPJgrVH1KW
	 IsaCRs/+8uxYZz0Ud4TsUDNpb2P34pdrwc537O5zf/lc1zHD8NDWEoxKHKdhIR/yLag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oea7d9WU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE7606A323
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oea7d9WU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7DD1F000C6
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514219;
	bh=wMV2nsSJl6xGkmfUvtbbR/+a8KpdpyQgadjZKqs++do=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oea7d9WUqHfzTiVDkeGIwXaDwNGtKAsIjeW8Srs0B6AWiHDKuEHRiwsRKjYojdpsx
	 7RaAYliRpnn+q32nc86uPyUgUH5kBGvd8lyGlID1GQi6PMuW3eJwD4q0fGY+eGxpxh
	 G/dVgcs4JmZvF6xdUO8R+AyC2RVfQ+FgzwHR8ps68aYqcRznRMwx6fKk1lzjsJb8w7
	 jvdDu5Hi7EEpXebatOZGC2xNsTwjrpnoPqXeWr4xsuE2t1hZeVJgXNv4ZHAvFlsxnn
	 dlkRUvKvDty2e0Izi/Q2byXB1ICX5ATqK8/Rv8E2z54xYityDhVNInLGhp3uCSkT2c
	 CV7gt3++aUZsw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ae25c84207so1135081fa.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 12:10:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEG/HN8OYgpJ2sIQJQ4dBkKdUEkXB9VdKtuf9rbhJOHxxHwBwRjsKMB2bKj8+mWamfhbHlIWE9zIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/DsYyVWP12reQ0iFpXtTzGf9ERw0gB8TJz2BJekgyVuH0CxjeS
	5v4jk3E+QwJBSM/RcQpPk7gMj3yXr4eDwDGh4oJRbx2e0bVR6ACAqUcCc/lLkyNgFb8pi4i0W/1
	sf1WbB1b3x/F6k613fwAMKhVHlGRwFL4=
X-Received: by 2002:a2e:a917:0:b0:3a8:bd3d:546d with SMTP id
 38308e7fff4ca-3ae2b4b615fmr2200351fa.5.1794514217867; Thu, 12 Nov 2026
 12:10:17 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <auzlLwlleGLPsLcw@google.com> <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
 <au0oKFb9CmNzc6Cg@google.com> <CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com>
 <avOw_4ZkqtKFHu1B@google.com> <2c3bda2b-ccc3-4430-8e09-81b25f6fcda7@rowland.harvard.edu>
 <avSa97F1Nu1LTSCA@google.com> <fc43eb13-816b-4cd0-9711-848fdab605ef@rowland.harvard.edu>
 <avUHG8mLuTOUMr8O@google.com> <CAJZ5v0j+8_fOc_EEGx4tquqcaH3-nmHd0YMJRb38t2Rw40iV3g@mail.gmail.com>
 <avXs826ikSctpUnA@google.com>
In-Reply-To: <avXs826ikSctpUnA@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 21:10:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0irBvT=cnK6qTwvoKr+G7cmyFsRFz8yrKo=P=W2euVujw@mail.gmail.com>
X-Gm-Features: AclHuK__4os0EMcsZRKi_kFGQIBcp-RMR8mLlriuERmrjM4SgFsglhioQkJ6M6o
Message-ID: <CAJZ5v0irBvT=cnK6qTwvoKr+G7cmyFsRFz8yrKo=P=W2euVujw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent to dependency
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:44=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> On Thu, Nov 12, 2026 at 05:13:09PM +0100, Rafael J. Wysocki (Intel) wrote=
:
> > On Thu, Nov 12, 2026 at 1:24=E2=80=AFAM Brian Norris <briannorris@chrom=
ium.org> wrote:
> > > I'll give this some time in case Rafael had any other thoughts/replie=
s,
> > > but unless something major changes, I'll plan to write/test/submit v3
> > > where rpm_idle() calls pm_runtime_mark_last_busy() (part of Rafael's
> > > proposal), and *not* make it conditional (i.e., no
> > > pm_runtime_use_autosuspend_always()).
> >
> > That will work for me.
> >
> > > (Or, Rafael is free to do so, since it's his idea. Just let me know s=
o I
> > > don't waste my time on it. But I figure he'd rather someone else do t=
he
> > > work.)
> >
> > I can cut that patch.  It is going to be a one-liner if I'm not
> > mistaken and I'd like to write a changelog for it.
>
> OK.
>
> There's potentially quite a bit of follow-up, including patch 5 of this
> series (to drop now-redundant .runtime_idle() callbacks), but I can roll
> that separately if you'd like. (Would you want to make an immutable
> branch for other subsystems to pick the 1-liner up? Or just apply such
> patches to your tree, as it seems the IIO maintainer was probably OK
> with that?)

Either of the above is workable in principle, depending on how the
cards will fall.

If need be, I can create an immutable branch.
