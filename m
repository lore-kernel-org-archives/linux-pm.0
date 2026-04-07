Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6583B9D9B;
	Tue,  7 Apr 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571063; cv=none; b=pArzSBK9//TmzuBiL0fiTK5DBv6VRijzUuPooPHsOO/ixGgtenkjcjYAeinWTdYIfP1TfwejkoK0q9Jk8FGY/m3pnQugcTwIvvrluWGfPw2rN01BTVF71ySJPEvzjGTEhc0tuSEzexT6R47UMCJXvxTdMUk47rgAaicA0ijguhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571063; c=relaxed/simple;
	bh=VlpvBmKQrIWx3iYGrxnA5oDMuc0OpyR3PeFq14S9kqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C9jCqKvG+SwzJUQm4F4m7ZyMzbuaKp1GLN53iDMUQV9v6YN/0zAAzt1BeFhLHBdlPZQHi04Lyz8ouV3r0GjUHSPIMAD5uXwV1HXWztZw34fONQm7O9WIzSC2aere8a9X2szhRsGSVFR/S0hOnizODWVdRI7Umq7BoEgGlrL1tQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGkUBi4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGkUBi4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A319C116C6;
	Tue,  7 Apr 2026 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571063;
	bh=VlpvBmKQrIWx3iYGrxnA5oDMuc0OpyR3PeFq14S9kqs=;
	h=From:To:Cc:Subject:Date:From;
	b=gGkUBi4XD1az4qon86QvKXxH7Q2liB6aiHqByWTbw83J8lGKT6fCkfi6ljhodgJsG
	 ivyvgI6hBiYM89brlgKir+WG3EfWFfmPawRsZw+qb1wxkUYV2K4b/auR77ATFpa2wc
	 F0GHsBPfWT7S3DND7yO5yayJ+RToP4kkbr/rCrg+AT/Wad78McCWpEZYRW2Vz0qrnB
	 2rbbpXVywonwf2XXPUELXuU+gCp3OP6bHdk5xvxunSdLL9xZaE9ztVCFXorapYJFDJ
	 CVA6nA0z1CbFeuFy9HxQHAxOc+qi31q+l0YKBRPzsp1sKphmnkwpwFYyEnID1+k+RJ
	 gOofYjSR28awg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v4 0/6] thermal: core: Fixes,
 simplifications and suspend/resume relocation
Date: Tue, 07 Apr 2026 15:51:47 +0200
Message-ID: <12871778.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is an update of

https://lore.kernel.org/linux-pm/5119690.31r3eYUQgx@rafael.j.wysocki/

changing the first two patches to address Sashiko feedback.

This series is intended for 7.1 (it applies on top of linux-next).

If fixes the thermal zone removal and registration rollback path by
addressing possible race conditions and a memory leak in that code (patches
[1-2/6]), removes a redundant check (patch [3/6]), changes the thermal
workqueue to an unbound and non-freezable one (patch [4/6]), changes the
allocation of thermal_class to static (patch [5/4]), and relocates the
suspend and resume of thermal zones closer to the suspend and resume of
devices, respectively (patch [6/6]).

Thanks!



