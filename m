Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F76331EDA;
	Wed, 10 Jun 2026 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075384; cv=none; b=kK6R6nKMMgfvZK2e52a6uhTRWaTDD0y9n3I6uyDt/N+y5tD0u0ATiBZgyvqnDp4MbAbPdT3ZrWV4/+fM5IlJv2vJ2PIL8D0Gvl20c2kRa1g5RXvErMzBfreQOuwAflKAvgquloWX5TmZBd6JoQ6xAbT86E9HdTjGuD0rcrkUY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075384; c=relaxed/simple;
	bh=9nSvCTH9lG3oXMGc/1zkwY8WK9UjJZ4Vth0dbRrxueY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TE2LBMkwb8INl/jGqM1KN3cmHyuxJRosIRQoec/0iOjX0s3/FIuouN82bkpqL3jWr+npd08tcv63ybKsjKtf7G6hDE22HN3i+4g1fzdTP2ATBdYvyIwKMgpP9c6C3CygZBxBATCYeGhi8+anpwk56ZkYw/GyT/JJ9rrb51uyUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VZdNe62r; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VZdNe62r"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6B42426950;
	Wed, 10 Jun 2026 09:09:40 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xRwFFl8RsLj3; Wed, 10 Jun 2026 09:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781075379; bh=9nSvCTH9lG3oXMGc/1zkwY8WK9UjJZ4Vth0dbRrxueY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZdNe62rx4z/p0VUJQZUkTqzdauTCG+zf1ocPI+f6xZItlif9n/hS+CiKBa5OonbP
	 jcOqF0e0PqBtff74W7BJpPHEQJV30RGHuLiQF45ItusBuhEwi2Fzp51KR6UBv5GylM
	 i344LiZ0VoUvrlwctvejZi56YAUSpTIC0lqH+1kG7yCxwXHeZwNlaHnqR2LEAcvcy6
	 knnJotVHbgZPQCWvHE+lvW7E2O3CH5LqECArCZZRIBHwOE9buztr8GjlVApc+QLxlE
	 bFoUOc9pA4kzJmEOu5+Yz0lJjKsHlmpAZ5XifYeWg1tTi+WLtXBT6+M/2cXG4rbxXO
	 DVY0dAnD9ZveA==
From: Marco Scardovi <scardracs@disroot.org>
To: kprateek.nayak@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 stuartmeckle@gmail.com, viresh.kumar@linaro.org
Subject:
 Re: [PATCH v6 0/3] cpufreq/amd-pstate: Fix EPP and auto_sel initialization
Date: Wed, 10 Jun 2026 09:09:26 +0200
Message-ID: <r6FELlcBRBCMF5j6jCxUag@disroot.org>
In-Reply-To: <9345645e-8548-496a-83d6-8741cc001cca@amd.com>
References:
 <d8bc45af-d8bb-48fb-9f3e-5188c8d79c8e@amd.com>
 <20260609073042.81275-1-scardracs@disroot.org>
 <9345645e-8548-496a-83d6-8741cc001cca@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In data marted=C3=AC 9 giugno 2026 15:48:57 Ora legale dell=E2=80=99Europa =
centrale, Mario=20
Limonciello ha scritto:
> On 6/9/26 02:29, Marco Scardovi wrote:
> > Hi Mario, Prateek,
> >=20
> > no big deal making a v6 with your suggestions. I'm glad this series come
> > to an end and everything works as expected.
> >=20
> > Here is v6 of the series addressing the feedback on EPP and auto_sel
> > initialization. This version updates the metadata with Reviewed-by and
> > Tested-by tags and applies a small commit message cleanup.
> >=20
> > Changes in v6:
> > - Add K Prateek Nayak's Reviewed-by and Tested-by tags to all patches.
> > - Drop the redundant paragraph from the commit message of Patch 3.
> >=20
> > Changes in v5:
> >=20
> > - Split the single unified patch into a 3-patch series:
> >    - Patch 1: Change EPP helper return types to signed int and add error
> >    handling>   =20
> >      in amd_pstate_epp_cpu_init().
> >   =20
> >    - Patch 2: Remove the active-mode early return check in
> >    shmem_init_perf() to>   =20
> >      ensure auto_sel is properly toggled on shared memory systems.
> >   =20
> >    - Patch 3: Cache the initial firmware programmed EPP value in
> >    cppc_req_cached.>=20
> > Changes in v4:
> > - Refactor EPP getter helper functions (msr_get_epp, shmem_get_epp, and
> >=20
> >    amd_pstate_get_epp) to return int, conforming to standard kernel
> >    practice
> >    for value-or-negative-errno helpers.
> >=20
> > - Clean up commit message description to link error propagation directly
> > to
> >=20
> >    EPP caching.
> >=20
> > - Execute the remaining shared-memory initialization path even when
> > booting
> >=20
> >    in active mode, rather than bypassing it through an early return.
> >=20
> > Changes in v3:
> > - Patch 1: Cache the firmware-programmed default EPP value at CPU EPP
> >=20
> >    initialization (resolving the boot-time false cache hit) and explici=
tly
> >    toggle the AUTO_SEL_ENABLE register to 1 on shared memory systems,
> >    rather than utilizing a state-tracking flag as proposed in v2.
> >=20
> > - Patch 2: Dropped as CPPC systems universally support EPP.
> >=20
> > Changes in v2:
> > - Patch 1: Rename `epp_initialized` to `epp_hw_programmed` and add a
> > comment>=20
> >    documenting the EPP cache guard optimization behavior.
> >=20
> > - Patch 2: Add comments explaining the uniform CPU capability check on
> > x86,
> >=20
> >    handle EPP capability check errors robustly (only treat -EOPNOTSUPP =
as
> >    unsupported, warn and assume supported for other errors to avoid fal=
se
> >    negatives), and reject runtime active mode transitions at sysfs store
> >    time
> >    (preventing the driver from being left in an unregistered state).
> >=20
> > Changes in v1:
> > - Fix the boot-time CPPC EPP/auto_sel initialization regression in
> >=20
> >    shmem_set_epp() using a state tracking flag while preserving runtime
> >    cache optimization.
> >=20
> > - Add an EPP capability check helper during initialization.
> > - Fall back to passive mode at boot if EPP is not supported, and reject
> >=20
> >    transitions to active mode at runtime if EPP is not supported.
> >=20
> > Marco Scardovi (3):
> >    cpufreq/amd-pstate: Fix EPP return type and handle errors during
> >   =20
> >      initialization
> >   =20
> >    cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory
> >   =20
> >      systems
> >   =20
> >    cpufreq/amd-pstate: Cache the firmware programmed EPP value
> >  =20
> >   drivers/cpufreq/amd-pstate.c | 20 +++++++++++++-------
> >   1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> Thanks, this all looks good now.  Appreciate the patience, and thanks
> for taking all the feedback into account.
>=20
> I will add it to my tree and it will go for next cycle (7.3).

Well, thank both of you in first place for the patience in helping me figur=
ing=20
it out and testing my patches.



