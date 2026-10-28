Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202861;
	b=nqRA5AKKS00cSIhW9YwRmtb1WXMNeN/JoryfQu+/x6WUYlGrY7AOiJMBRqmRSBHWkUtH
	 Lr9iGxiU+QcdP7akCEqrxUiOOQgkLpBraLxreisxt/ZWz0QoS71PLc/k1ThxH0t5XGvGG
	 jNVMiRLmwnqTN3qxJDRnnWMzCEanOiRhJYnvnEhoohRzdoLURTXdxmn74PkI/ZJpM6etK
	 W7OYZJW5ltFpRp2NU1M8VR6HbEWfQQCI9bOsBHY/YAutgTrgwM/mhvVG7RFFkwtCYbsZq
	 6tvfXBdMQSA5e3IvVPXuemGZg/2EPP6oTOXL8gSPpsEiq7bCUNN3zHnnufC1pLlTK2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202861;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gANX9w/0wruJvkwVULFIrrl4yranIWLJJeagbYk81/w=;
	b=dndOZD4Ywlt1uVx+CVraYn2B75fhPK10wguOiNhOV7+m8h3Tz9+/uWlhfGgcBEHCvp+x
	 cwCWHuX9ysqNR6Dp4fVuxSyZMkZYp+BvXacFWu9MMwgiFoXfo1XvWOY8pslcqOpKPfnCX
	 3I7nM8UWj96rb2mIeDcXfQ8Yl71s47wEPfWCaRhO0lgHfr6dsVlqi/ib1QUvor2SLadiV
	 3nmqnL8vnH3rJSxG3LvkDgqiyvACFT4AnSlCsB0QGjnoDbRg5hR7YWhryoK+9Et+kCLaX
	 OsHlKlw46n8M+5ujUnW6d/PEqxpMFdnHuB6Q70ga4lr3KzAeE9fkRST6Y9NbhpTivBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUug+QZV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE0606A336
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUug+QZV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142A11F031F4
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202861;
	bh=gANX9w/0wruJvkwVULFIrrl4yranIWLJJeagbYk81/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CUug+QZVCctl0wiSptzHfiUvSnNJOdKbn/BOEyCFL2AyFSBZHq3uluQ1cyrQ+1k8H
	 VNJQlI0XoBnqFQ7UJjYM07XqOhv5uaHApY4WQaHdETlQEe4LFCHJXtUhhgSEv3Ff9y
	 ezz40K5db8MlennFMiimDJiul7kLrxGKWO3ICExEAa74aAh7q1Sr3QhtENnnmF0OAU
	 trAsV5LQURowif2lfe9YjsSn2W2wbDbfJWgxyz2BFdP/9i23/7CU7MN2c68hKhKQe1
	 Tzq/e60tmNQ0UdsOoAEBBrNL0BOF2H8ocxxskCd+7p/1hvziNeqJwkJTuU3l6H/ctG
	 h6K8XbXmgmh4g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso1093829e87.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:54:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwO+MrUBrWavgTzpTlobuwjarwyNuwxxqgrLFDa2dU4JqlC582QLTNOQ6QU3SD4hoiQJy8s76eF5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0cobazpz3HTQJ1GYpFIeLYPoP4hJUXLRbTMDLOejQiWecD9a2
	BAOnL/cmb/sFCAbEkKJBn+NI93QpnykStIjShwRKqLp6kc6ds/b6gMjX2PEpNouyIliW43RIUKW
	vHaE5FSq0Q892nO87p5BZ51gzzuL3dDM=
X-Received: by 2002:a05:6512:688b:20b0:5bf:d063:608 with SMTP id
 2adb3069b0e04-5bfd06308afmr270261e87.17.1793202859544; Wed, 28 Oct 2026
 08:54:19 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
 <001101dd6631$6167dbd0$24379370$@telus.net> <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
 <004401dd665c$97eda060$c7c8e120$@telus.net>
In-Reply-To: <004401dd665c$97eda060$c7c8e120$@telus.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 28 Oct 2026 16:54:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gvruWF7VhVuLrn4AgV9_n6Ayektrh+jB=eLY79ufw4UA@mail.gmail.com>
X-Gm-Features: AclHuK-Icinm4JvJ45RiL5mDQBZ5mfoMZRC5LyoKV_3cvcCC7oWf9BvwWeYFo_Y
Message-ID: <CAJZ5v0gvruWF7VhVuLrn4AgV9_n6Ayektrh+jB=eLY79ufw4UA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume
 without HWP
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Zak <zakbrightonknight@gmail.com>, 
	linux-pm@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 10:46=E2=80=AFPM Doug Smythies <dsmythies@telus.net=
> wrote:
>
> On 2026.10.27 Rafael wrote:
> > On Tue, Oct 27, 2026 at 5:36=E2=80=AFPM Doug Smythies <dsmythies@telus.=
net> wrote:>
> >> On 2026.10.27 07:37 Zak Brighton Knight wrote:
>
> ...
>
> >> I confirm your findings and tested your proposed patch. It all worked =
fine.
> >> I had not seen Rafaels's reply about a possible race condition until n=
ow.
> >>
> >> Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled.
> >
> > Passive or active mode?
>
> Apologies for the incomplete report.

No worries.

> Passive mode has the issue. Active mode was fine without the need for the=
 patch.

Thanks for the update.

Please check the patch I've just posted if poss.
