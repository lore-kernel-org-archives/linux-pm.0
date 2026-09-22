Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E594A3F14
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104986; cv=none; b=EcozTRojOiOOG8y9r+f8TyZxFCL4e7flp3ezqQWmmLT+9qkPdwiVU6JDi8eGfvGT1PndnTbJkorw/wRjI8AbXqdbbDW+IIOpZWt2YlqzwSj8Mcu4wb356Tsk16vqWf+8MF9b7FypKQRLJ+MEhLiYvwffPtf+ZLoxoGOBgzneeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104986; c=relaxed/simple;
	bh=6+jWmzAMpzZFHnkcLGjZJ1J8P6nJWosJEjYxYxNzf2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlYCqYBl39+aXrDKco2afsGsP8JCknQZGqmBNvimhA81KQDigxIXXKpTXSzTWuQ/ss8GajZei3fMVvDIt/ipRs2IWzmgLkETXYl/PDIyRePIejrLTvhktpfDIj+p1nBLKsucnkz7d5R/X1D7xfoSs+zMALhtR0abD0r23rrlY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwS1NeNU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwS1NeNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521641F0089C
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790104983;
	bh=afdFbb0Oxpswz4JQtJZyx58sYBBrJDryxTxTGWpHsUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cwS1NeNU/1megkIFwX7RWYEYgR6blyuYff+wv2z2HaJkf5i1I/6ykUVcoWIv9xERr
	 yso3akEDXwi02+tRu8BUn9ihzUBUpdjI9czzVajdXCxlkOZedOsk76aokQ5yP1/0PQ
	 uQ2In8SXt9CUDLFrKlLF8lcXQqHQN7s9awifazewZ8sFS18R7Jrg6EN7dleq/nxsbk
	 NufD8mryXvdPqaL3NjbpNkZnOuApjHBIDu95kZsojYid46p3QNFSJqObf2jX6SKAjm
	 TfFD9ngatyHZP2ZiCCHw03yx8PtH+WXVhf8xcUZDUYO4sKQjfQzRjs6OqM2SFqRJwl
	 f2Ig6uOwlq2eg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso161284e87.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:23:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJXZFoSvmQAY5T3QYbnvwApg/jdAsA6yttrUtnQcsdOrZ+FNgCW6eOwQq3oniVGvhvzebxjiM9xQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mla8usr5g7leE/QNsO/Po2fXnRV8JBvyN6KOb50Jhbw2+lMnBd
	klmxx+ywG/ogoT0iftLV0EGNjk97hSPUTaP8tmKAGb01Ko1xmVHW5WPX8bPhgdQa3HwrCS+AEOS
	9VsC63V++xsKcTulMiUgLHQFr5jS4U2s=
X-Received: by 2002:a05:6512:3ca0:b0:5b8:bc5e:b574 with SMTP id
 2adb3069b0e04-5b8d89b0a6bmr80176e87.44.1790104981582; Tue, 22 Sep 2026
 12:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-step_wise_multi_zone_stale_vote_fix-v1-1-789f68dab229@oss.qualcomm.com>
In-Reply-To: <20260922-step_wise_multi_zone_stale_vote_fix-v1-1-789f68dab229@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 21:21:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h8w4Za5jU7M5Vos7OWf6hkXXHoRetR87-_A7U-Rj9-Zw@mail.gmail.com>
X-Gm-Features: AcwNN1VYiKZQLUWuoqK1GWIegsgx5WasS_Lrro2nwSBi5LKy9AFX7qy1FHw6H04
Message-ID: <CAJZ5v0h8w4Za5jU7M5Vos7OWf6hkXXHoRetR87-_A7U-Rj9-Zw@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_step_wise: Fix stale mitigation vote with
 non-zero lower bounds
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 2:19=E2=80=AFPM Manaf Meethalavalappu Pallikunhi
<manaf.pallikunhi@oss.qualcomm.com> wrote:
>
> When two or more thermal zones bind to a common cooling device and one zo=
ne
> uses a non-zero instance->lower value, there is a bug where the instance
> holds a stale mitigation vote even after its trip is cleared.
>
> Problem scenario:
> - thermal-zone1: Trip at 50=C2=B0C, cooling-map with lower=3D0
> - thermal-zone2: Trip at 55=C2=B0C, cooling-map with lower=3D2
> - Both zones share the same cooling device (e.g., CPU)
>
> Issue flow:
> 1. Both trips trigger, zone1 requests state 5, zone2 also mitigates
> 2. Zone2 trip clears (temp < 53=C2=B0C due to hysteresis)
> 3. When throttle=3Dfalse and trend=3DTHERMAL_TREND_DROPPING:
>    - Current code checks: if (cur_state <=3D instance->lower)
>      return THERMAL_NO_TARGET
>    - Since cur_state (5) > instance->lower (2),
>      it returns instance->lower (2)
>    - This is the BUG where it returns instance->lower even though
>      trip is cleared
> 4. Zone2's passive polling stops (tz->passive reaches 0) - no more update=
s
>    for zone2
> 5. Zone2's stale vote of 2 persists indefinitely
> 6. Even when zone1 wants to reduce cooling to state, the cooling device
>    cannot go below state 2 due to zone2's stale vote
>
> When a trip is cleared (throttle =3D=3D false), always return THERMAL_NO_=
TARGET
> instead of instance->lower. Remove the unnecessary check comparing
> cur_state with instance->lower. Since passive polling is already
> deactivated when the trip is cleared, the instance should always be
> deactivated regardless of its current cooling state. This ensures that
> instances with non-zero lower bounds do not retain stale mitigation votes
> after their trips are cleared.
>
> Fixes: 042a3d80f118 ("thermal: core: Move passive polling management to t=
he core")
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qua=
lcomm.com>
> ---
> When two thermal zones bind to a common cooling device and one zone uses
> a non-zero instance->lower value, there is a bug where the instance holds
> a stale mitigation vote even after its trip is cleared.
>
> Problem scenario:
> - thermal-zone1: Trip at 50=C2=B0C, cooling-map with lower=3D0
> - thermal-zone2: Trip at 55=C2=B0C, cooling-map with lower=3D2
> - Both zones share the same cooling device (e.g., CPU)
>
> Issue flow:
> 1. Both trips trigger, zone1 requests state 5, zone2 also mitigates
> 2. Zone2 trip clears (temp < 53=C2=B0C due to hysteresis)
> 3. When throttle=3Dfalse and trend=3DTHERMAL_TREND_DROPPING:
>    - Current code checks: if (cur_state <=3D instance->lower)
>      return THERMAL_NO_TARGET
>    - Since cur_state (5) > instance->lower (2),
>      it returns instance->lower (2)
>    - This is the BUG where it returns instance->lower even though
>      trip is cleared
> 4. Zone2's passive polling stops (tz->passive reaches 0) - no more update=
s
>    for zone2
> 5. Zone2's stale vote of 2 persists indefinitely
> 6. Even when zone1 wants to reduce cooling to state, the cooling device
>    cannot go below state 2 due to zone2's stale vote
>
> When a trip is cleared (throttle =3D=3D false), always return THERMAL_NO_=
TARGET
> instead of instance->lower. Remove the unnecessary check comparing
> cur_state with instance->lower. Since passive polling is already
> deactivated when the trip is cleared, the instance should always be
> deactivated regardless of its current cooling state. This ensures that
> instances with non-zero lower bounds do not retain stale mitigation votes
> after their trips are cleared.
> ---
>  drivers/thermal/gov_step_wise.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_w=
ise.c
> index ea277c466d8d..4fa4377f0d42 100644
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -65,14 +65,12 @@ static unsigned long get_target_state(struct thermal_=
instance *instance,
>                                      min(instance->lower + 1, instance->u=
pper),
>                                      instance->upper);
>         } else if (trend =3D=3D THERMAL_TREND_DROPPING) {
> -               if (cur_state <=3D instance->lower)
> -                       return THERMAL_NO_TARGET;
> -
>                 /*
> -                * If 'throttle' is false, no mitigation is necessary, so
> -                * request the lower state for this instance.
> +                * If 'throttle' is false, no mitigation is necessary and
> +                * passive polling is already deactivated, so clear this
> +                * instance state by returning THERMAL_NO_TARGET.
>                  */
> -               return instance->lower;
> +               return THERMAL_NO_TARGET;
>         }
>
>         return instance->target;
>
> ---

Applied as 7.3-rc material, thanks!
