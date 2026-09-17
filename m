Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D800381EBB
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668418; cv=none; b=TrbNPBsZqNw17bjNGfHOd8Jf+xYQOuhwYp26OnzHJFIxd9vKm4ga2IoZEjjgo+UNyRA+wxcE0UGp+2N2ELr5GzneSfWTZj/v/3ZIBbQ6zm5s0E7QeOY6lC6RlkOswTetoKmjJ0hZNyFRqqF/K+JWmkhMB4uDAuQp8HC0auw2+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668418; c=relaxed/simple;
	bh=64D1SOZs1z+Fqk1kjLAlwqbRARSRCsuWUTGC6XwcN8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A03IfQ6mNDmP8uHozkdzsFYDDgTAtpmeHIFBvm9/4C1JwNJ8xUogyBhiBqyGReV/W9vhAjaw1gpcZIeUeJFsocM/plT1lJfh8D59vQd8aQPg4+Qci5dPIYLt40jMPuRqoKoYAfasEk2CSyeSoRO/M6tdmT77RF0u0MoCddzruKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqpj+RVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqpj+RVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7E51F00898
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789668417;
	bh=WMExV7D7e4YG7w6FCZdma/GMtTsthAG+zYUhp/+C9jQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Kqpj+RVRLKeJzCKhC5wQvXjXQZa8k+AcvQyNFYNFcJwAEBC5okLXoH6RZjaDgYECt
	 N0EGcyrmOaGgyhVi809XsPxyWzvin6qJ/VMhUEIPyDC8/UAU1+vLpMgFT8J0wG2tHH
	 Wtg+VheicWt+LpvfapoxS1lVKh0VwavMrOo0lVbQWq8hM3WipuEErwDByq1HgFg5Ld
	 65zy7JDqyxhOf4lD0l2efYtsLVUQGCy1Mr8YhV1p/RZQ7ydDKQrG1mQ4xxG1oDXVa0
	 1xFvcgANucsGeSyZC5t/EwVBVelYPSDJR7Jr0GUxM+8qbhT5kl9/OpmxXFN3rqwkPV
	 enikaQjjwesJg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a306a4f797so9418661fa.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 11:06:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxx4afEsEyDjTFMRyzcWUOX5euVHmXzYIf2vNGem8E+lnoVAxHHEdQr3QYFT1hBQwCVba3nlPEMDQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k/9W7NZKld+KDmpokgG218A/Sbko/brqvxaJju4o7hgSMmLthh
	trBlsIn9sv+2CDeYZCFXpp1aT3Om0iIuhhofE1aBQOnLAvuq/j0KzynRzR2nMexETmHfbujsJ1s
	8Hm/moc8ku0WmRutcgslUD8hGbToLHKU=
X-Received: by 2002:a2e:b8c8:0:b0:3a1:35f3:d2f2 with SMTP id
 38308e7fff4ca-3a5dc98b416mr14858381fa.12.1789668415460; Thu, 17 Sep 2026
 11:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910111329.2220-1-lirongqing@baidu.com> <20260910111329.2220-3-lirongqing@baidu.com>
 <CAJZ5v0iPPmrTtLRG23UYJ_ibn7VUceuN2qFXpjCsBYnBzDMzYA@mail.gmail.com> <d39fba05f2a945008a6a83b7a3ee83c5@baidu.com>
In-Reply-To: <d39fba05f2a945008a6a83b7a3ee83c5@baidu.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 20:05:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i7uh3pCWajAfVS2keS2OiRx_5zm-QktX-4hZkWNAQzpg@mail.gmail.com>
X-Gm-Features: AcwNN1UL6dQ6L8bN6Oh-BSzvJc-jhTvA742qLKNtfaIMTgL8R2oYKVQgn9Jux3k
Message-ID: <CAJZ5v0i7uh3pCWajAfVS2keS2OiRx_5zm-QktX-4hZkWNAQzpg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0ggdjQgMi8yXSBjcHVmcmVxOiBhY3BpLQ==?=
	=?UTF-8?B?Y3B1ZnJlcTogZml4IFAtc3RhdGUgaW5kZXggbWlzbWF0Y2ggaW4gZ2V0X2N1cl9mcmVxX29uX2NwdSgp?=
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"zhongqiu.han@oss.qualcomm.com" <zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 7:04=E2=80=AFAM Li,Rongqing <lirongqing@baidu.com> =
wrote:
>
>
>
> eq: acpi-cpufreq: fix P-state index
> > mismatch in get_cur_freq_on_cpu()
> >
> > On Thu, Sep 10, 2026 at 1:13=E2=80=AFPM lirongqing <lirongqing@baidu.co=
m> wrote:
> > >
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > get_cur_freq_on_cpu() uses perf->state, which is an index into
> > > perf->states[], to index policy->freq_table[]. However, freq_table[]
> > > is built by filtering _PSS entries that are not lower in frequency
> > > than the previous one, so its index space no longer matches
> > > perf->states[]. The original P-state index for each remaining
> > > freq_table entry is stored in driver_data.
> > >
> > > Once an entry has been skipped, using perf->state as an index into
> > > freq_table[] can therefore select the frequency of a different
> > > P-state.
> > >
> > > The reported current frequency itself remains correct because it is
> > > obtained from extract_freq(). The mismatch only affects the cached
> > > frequency used by get_cur_freq_on_cpu() to detect a firmware frequenc=
y
> > > change behind our back.
> > >
> > > If the wrong table entry contains a frequency different from the one
> > > the CPU is actually running at, the check falsely detects a frequency
> > > change and sets data->resume. The next ->target() call then performs =
a
> > > redundant control-register write even if the requested P-state is
> > > already the current P-state.
> > >
> > > Conversely, if the wrong table entry happens to contain the frequency
> > > to which firmware has changed the CPU, the frequency change is missed
> > > and data->resume remains clear. A subsequent ->target() call for the
> > > P-state that the cpufreq core believes to be current can then
> > > short-circuit without rewriting the control register, leaving the CPU
> > > at the firmware-selected frequency until a different P-state is
> > > requested.
> > >
> > > Fix this by taking the cached frequency directly from
> > > perf->states[perf->state].core_frequency. perf->state and states[] us=
e
> > > perf->the same P-state index space, and converting
> > > core_frequency to kHz yields the same value stored in the
> > > corresponding freq_table entry during initialization.
> >
> > Sashiko has comments on this patch and it has a point IMV:
> >
> > https://sashiko.dev/#/patchset/20260910111329.2220-1-lirongqing%40baid
> > u.com
> >
>
> The extract_msr() fallback issue should be valid , but it is a pre-existi=
ng problem that is
> orthogonal to the index mismatch fixed by this series. I would therefore =
prefer to keep this series scoped to that mismatch.
>
> If there is no interest in addressing it here, I will send a separate pat=
ch to fix it.

However, according to Sashiko (and if I understand its report
correctly) that problem interferes with the logic in the patch and may
render it ineffective in some cases.  Isn't that correct?
