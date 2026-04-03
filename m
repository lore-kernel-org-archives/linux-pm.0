Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3517555
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219573; cv=none; b=o8u2D8psKMEydha4hCuyi4ofnvFnpUJ2QUz7R4w+4TGNt91HPOuDW1RcO4bu4qWskFPF9MP/WLg9r0OlxHq9YZ3m/gDJbvapnDSyR62VOWUXZ3WjROygZ6C8/r3MDQ6K4Aydaz1YKycPKXityptRyaANBpqR9VKq+kMp5R2Kavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219573; c=relaxed/simple;
	bh=WyRkeMA0kDe4LYIAyjmQb2NSmwGQPBCyqti3+rXezoM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qL6++ouOfSwGVxgK4Frm2DC/y19UFTM2UdQvtCCnwcqBsztq5tqtNSEAFi3DFTaAIH8vGoGH+Q3WtDOLLcXDCibzUakUpfn4uQvTjnSFJmbu6UeO/u8sirtuVt202sWjwrOxadIG93LGwfyHH58HPMB/mGQw1HrShqwKoH3TzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4H35gap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4H35gap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3AAC2BCB1
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775219573;
	bh=WyRkeMA0kDe4LYIAyjmQb2NSmwGQPBCyqti3+rXezoM=;
	h=From:Date:Subject:To:Cc:From;
	b=q4H35gapf5yXB6YDSK2XmSNwwfJRh2IKoCCYjpT2VEEeg+Uz1+WaSS7TjqvvQBKU4
	 BZEyw4DwLhRuklGnUCviucegl+HDzpZBzqsyHUdI7RDvW5CU0Asp7GULZL1/PpOW2J
	 mpGN6y94M8P/atyvxAiWghflSVi/8WacZZxloQ6GGFQCnN4K8z1sqExY/uWRek5oEo
	 7Qx9ho4dPaGjc4X/w7tGmZeyxUhdpCi/Yjt1CxIKSAvvJvzLA4n1Mz9kLXMnYjoSKW
	 32MCyS9UJP++ZPLKb/tBSLVQ3fWAKslTuprEgDsAxTSHd0zjBJ+XfBr7mNl/dyB40K
	 GYMqTfd9F7I2A==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4152698e745so782604fac.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 05:32:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxmyeMGHxlH8KjmcwSIpQO/KvldY6LapiXEES3JwuAdkAUNFAFw
	FRDHRTWHch0hRJw/4ylwLXdk6f/87Sbylh1zvB7WJxDln9g9UttYrwsy6E5C44YjMwU/ddWbPNx
	MTXVB7A9xD9DpzLK+Q13Icbbg4RUugU0=
X-Received: by 2002:a05:6808:309d:b0:467:32c1:acf1 with SMTP id
 5614622812f47-46ef7d147d1mr1431094b6e.39.1775219572210; Fri, 03 Apr 2026
 05:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 3 Apr 2026 14:32:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g23pA9urxBundpRAb0O67=UFSM29SDiudXNa2S18sBZA@mail.gmail.com>
X-Gm-Features: AQROBzCxBYkTwla6muI-pnl9KWSYSUyAIKr66htYTe12fpfxuZC-odr117SjGPo
Message-ID: <CAJZ5v0g23pA9urxBundpRAb0O67=UFSM29SDiudXNa2S18sBZA@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v7.0-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.0-rc7

with top-most commit 9e07e3b81807edd356e1f794cffa00a428eff443

 thermal: core: Fix thermal zone device registration error path

on top of commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d

 Linux 7.0-rc6

to receive thermal control fixes for 7.0-rc7.

These address potential races between thermal zone removal and system
resume that may lead to a use-after-free (in two different ways) and
a potential use-after-free in the thermal zone unregistration path.

Thanks!


---------------

Rafael J. Wysocki (2):
      thermal: core: Address thermal zone removal races with resume
      thermal: core: Fix thermal zone device registration error path

---------------

 drivers/thermal/thermal_core.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)
