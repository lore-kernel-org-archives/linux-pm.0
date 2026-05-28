Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CA2E7384
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992677; cv=none; b=uZTpWVTtVct4mExFUYzefYr1e16nrM5JlNqn3pBUlp2lhLkP9v2j7DqNq7nX4MuSZ0RZ2j9FC4q39max/lFpIMXBc5EIFTPauD9NgP6iGug8Bls7J9By4qU4FkF00+3FNknj7Q6hdMwdTUwyLgtBZ+UJ39EJwl3LSq9RTZJzWyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992677; c=relaxed/simple;
	bh=QnALumxlUlUIB1HefykEOvNlOI5fIAkyB4J16lu/0iA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bST0IoaXD9XbUF1zSY+ehmysYT4sw4on1cP+BYFEWIN9x31Lv0nCXBoUSpVUCTJmE3fmKEGbcO88Rb54LOgF8KJ70wG3hoGliNa1HUribxaYMhDc23RU5nHC2etIbT9IJDbpKaWM5e097xNbztHB9dH8NAKW8MpfX9H0YPpTFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bczj/+qW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bczj/+qW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8F61F00A3D
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992676;
	bh=8hSM31f8sc6XfPqyqXB5RK3thMAXNjjPlnC9UDilHNM=;
	h=From:Date:Subject:To:Cc;
	b=bczj/+qW+Bj7CUloZo6FgEwP1o9HTs4+1udJ9MFIFRzVSUVtBYwpJYznPHBu31L3D
	 HyFvajSk5eDXCzPqBxA7BBZjIvgF5Hz98XJxvqxunCHQXQxNUsnLZ/frec9PIV9zO+
	 IE2dKnwlhTg9c6Nq1dKEub42iAEKaYeDGrvM+ju+wmb8G/arWUAwHSmPF9kdMSruPY
	 LSQ9PyU/8zTbkofxKMCYpfTmKnMzrxKREsGkgckG40MItlb4dRXRJaJMmhUMuMTWkO
	 SZ9HqCsJl1gBIjLurHtwbEr/GUHO1r64ebEzjqNQCUVWInOxQdvJykJgaxUJ8oPycz
	 eX4fV0rmF/fRw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa21fa024cso11485266e87.2
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 11:24:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YzjYL48i7fQk8ugqd9YRgjDQO6gRDTUprCYWKZaVw3hq6odGaUH
	AAMciecO2Dgur/XZlZ2rOMakqUz8562VVWMgT8vN4y5eLwEmonjUYa5K+NJnmp++o5BEH9NJxV0
	a8KK6vUVgSKwsHEzBXjSt6lTztm+374g=
X-Received: by 2002:a05:6512:b88:b0:5a8:6383:eb1d with SMTP id
 2adb3069b0e04-5aa57cef2c9mr128351e87.0.1779992674513; Thu, 28 May 2026
 11:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 May 2026 20:24:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hpExkjuQy5ezEo8WGBrqMG5BssPAorP-d7mRk-2Nsv5Q@mail.gmail.com>
X-Gm-Features: AVHnY4Kzju08ZljjsFpNGPmtwYfApCwK_z60OojIGAU0nVU6jiLjoAsr3dPj14E
Message-ID: <CAJZ5v0hpExkjuQy5ezEo8WGBrqMG5BssPAorP-d7mRk-2Nsv5Q@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v7.1-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.1-rc6

with top-most commit df488cac6140aa04ae52af9b4507d8f99a3762be

 cpufreq/amd-pstate-ut: Disable dynamic_epp after the mode switch

on top of commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d

 Linux 7.1-rc5

to receive a power management fix for 7.1-rc6.

This fixes a possible amd-pstate-ut cpufreq driver crash introduced
by a recent update (K Prateek Nayak).

Thanks!


---------------

K Prateek Nayak (1):
      cpufreq/amd-pstate-ut: Disable dynamic_epp after the mode switch

---------------

 drivers/cpufreq/amd-pstate-ut.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
