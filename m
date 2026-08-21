Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1230DEB2
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317422; cv=none; b=pg/PayW5+XO6SzesWUPZFObf++coHL6M8R6PxE62QmT78KLjG5scpjJK4xq1MzX0JY/4zGZu33b/giX34Dsuuz5uHXTzF63TWLntt2pyVPDixh6VKLrUrnVp1Cm2LDWlNoIBn+2WgSIBvmJJAn2qQ56Ex7HWclzwEWtEvOCsJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317422; c=relaxed/simple;
	bh=ab0Dzgup3mBzpFKcBqI4rne1suQXikaZP0o+z4kWxZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlwPqCOuOo1WWY+5TWHRX4DuFAz9gjxgpk9sJIjP/W2p+kUtEvvdKs72883+yJyDgsAivtvjsC60zyVhLBopQaL7WyrlLsJQ2I0X1J1sF1h+99gBBjzmEoG5lRBQUB8yUWffSqdSyV6n7OJPfcmt8BeXltyRWGJseJA61VjeAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY0r12ri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY0r12ri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4349B1F00ACF
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787317421;
	bh=ab0Dzgup3mBzpFKcBqI4rne1suQXikaZP0o+z4kWxZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fY0r12rixP7bDa9UUJ3hubgiPv8f8Mh6t/vGyUoemPnsEqsKPjw4LEXmEQuMZzwvQ
	 q6wafnxtTCzfStCA8f6GPxZr4Zi+tpnzTlEkOaghP7tFq+eM38jboQcLR6043ydAmS
	 ygA8ZSqxGtZy+ATT3WYFRtTLDb0b0qbxH42mwKvFAE3xQArLc67iL/SwvLDBCZlrg/
	 XCjJb3bSAHi3v0f+RroMFvS2X5kXFecn0OcBeouuNEObATwkqypPsZx3UEHDtz4IPU
	 rmBME4d8abNDxszYB685j1jKYeNnodONncaAS9tr3x0C22XsS0DJssv/n7qeOWnagK
	 eDmyaL/ILf6Bg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a14f6613fdso12294291fa.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 06:03:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpY1cI55CAgibsArwIrjNsGWuenD5zlJE2V54LbGTKu/WSFfAjef57hdT9NQ6QQLWoNYtZxkTTK/Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mXJTfV/CEIyvaihn8FoYCQb8Wa2anSr9vVIaNsiOaw8knKs1M/
	G23cblgxIYjIdYWs8fVHJOtAHXB9vxW9nwQeVe638mDTwFPaY6xlYLV5zgUcdRSZdgv7dVvsafD
	9TJsHcLD1XqMCuYBTtbUZaKle8DkoAPY=
X-Received: by 2002:a05:651c:a10c:20b0:39a:da70:2c77 with SMTP id
 38308e7fff4ca-3a1aeb79ea8mr10814651fa.3.1787317419704; Fri, 21 Aug 2026
 06:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>
 <CAJZ5v0jXwtBz3z4h3ehJTuaqYN4z7=wOv_LGnjQ4LQMP0TBKmA@mail.gmail.com>
 <5cfd774e-8797-4765-a36a-c3dc2d6ac004@oss.qualcomm.com> <bc9c2236-6411-4ff1-a03c-d97997b5f780@arm.com>
 <8b728c1a-f783-4660-8ed0-eb131875f2d2@oss.qualcomm.com> <6d5dfbaa-f0e0-425e-bacf-f177185d1eff@oss.qualcomm.com>
In-Reply-To: <6d5dfbaa-f0e0-425e-bacf-f177185d1eff@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 21 Aug 2026 15:03:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hhgGyKFb3ZWFAYyfqmyp7csWAGB7Dus4ZbohzEHQT4-Q@mail.gmail.com>
X-Gm-Features: AcwNN1XHCzp31HULY2s7Tr0VctY6nnExEy1MfibBGKi4HagHsJwcEFzzYjT8xKw
Message-ID: <CAJZ5v0hhgGyKFb3ZWFAYyfqmyp7csWAGB7Dus4ZbohzEHQT4-Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 11:28=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Le 21/08/2026 =C3=A0 07:03, Maulik Shah (mkshah) a =C3=A9crit :
>
> [ ... ]
> >> What do we do about the cpuidle stats in that case?
> >> I'm thinking primiarly about last_residency_ns and rejected here.
> >
> > As the idle entry will not happen (call_cpuidle() is not invoked)
> > the stats would also not required to be updated.
> I agree, with the IPI pending it is like the idle task should have not
> be scheduled, so the idle call is aborted.

Which is why I think that this should be handled directly in the idle
loop and not in cpuidle_enter_state().

In that case, cpuidle should not be involved at all (if it is
sufficiently important for special-casing which I'm still not
convinced about).
