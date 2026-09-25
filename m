Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B64D9F94
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352093; cv=none; b=ONk0Oq73Xq4TbGwYb59X1noBX8lF22Cg3ReJHGerGW2P9Wh10VVFSWzc6e4WbCK0u3lDdetXrxSYoR04se1iiHEuCfYj6t+pD3jRAZBHeHjIBxPkYcpXWEDFnb0UscUbCwyLSob1hCXG8eNa/T4BrIndx+Q6nC4YRYRPoRhQMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352093; c=relaxed/simple;
	bh=V5qRqVM6Ya95BIQu+G6iPRxDKXr2qjOW/PKpZXiBDJ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NHz9SCe+QC42y6pMqxn4F8btVSfUSgqAG6NQiWTgS2a2mcL0MqeWdIkVJ5Rk7ih8pRN0is1wXeERn6qMiXzjqlrgsKgqsQ2d7Jy7BjwhjCNMECi3rNa3VvuctM9461mRPn/UxAhtmVf22ahLltYAwibG5pWX6IksPwulxbCDPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck0vEgf5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck0vEgf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6851F00898
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352091;
	bh=3Hi/phwcXVre7JVJgEDHQkw+sDJxQGUupzSizU89STE=;
	h=From:Date:Subject:To:Cc;
	b=Ck0vEgf5Fmkw5uD4wsj4ToXXevw4aaD2dlYsWsmh2NRh1kzeycBjZfMxDSZSzmsbA
	 TquJ6pbPcuhXWCUz7pSCsQwe6uiep/wGp9oKuIqAs4kVTrUuGuLLOWkuXwgXSycGlX
	 vmkE/3gnJu53AtpQ8SQGlCNzC0eRq5dMVT0Qu10os/FVH50cmqE1TjUeQQmICK6HAn
	 rLddaetCLom2CHX7f+1/SuobgVIgrl/BE1EM4rEkvl4HC/Gcd+DGknVcb4GBeB+ia9
	 xef/Vp1Y9kJxNnCGVNGFvhVe9N30eYzuhsIEnbgrtyH+uwKkCHhMLcy4MANLN1xe5B
	 P6MHWI4N/4Hew==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a6124046f0so8598891fa.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 09:01:31 -0700 (PDT)
X-Gm-Message-State: AFuF++nAaiUJm4yAbJSizdHL2kH5jKReq0NuhSkkPlQhShyzBwf44jGX
	/Zg4wIZHoO66SLBUO8vHxmBlLDG5LKXZxYW0tB0XOi2l3MVGndbhyo9sH/6ZxWtxe/s9OmOpk2P
	dDZl+vuwYK62UnP3ouVlfwqxGDdx6Q1o=
X-Received: by 2002:a05:651c:b0f:b0:3a1:93cb:fa2b with SMTP id
 38308e7fff4ca-3a63c070494mr16618411fa.7.1790352089892; Fri, 25 Sep 2026
 09:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 17:59:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jSaS=xp006ufiOjn+FXF96FLEs8_dawUgDqObD9FacLA@mail.gmail.com>
X-Gm-Features: AclHuK9q_FUW9IEl29q-Qn31juq-j2D5f8g-kYzw888ih5rMI4Q9haDRW-BUsqA
Message-ID: <CAJZ5v0jSaS=xp006ufiOjn+FXF96FLEs8_dawUgDqObD9FacLA@mail.gmail.com>
Subject: [GIT PULL] Power management fix for 7.3-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.3-rc5

with top-most commit 41112a787f9182c7f2d27122817861e3f22ef928

 PM: hibernate: Freeze kernel threads after image preallocation

on top of commit 93f51579e7df248780214094418f205253383cc5

 Linux 7.3-rc4

to receive a power management fix for 7.3-rc5.

This addresses a hibernation regression introduced during the 7.2
development cycle that causes the image memory preallocation to
deadlock if it depends on frozen kernel threads (Florian Schmaus).

Thanks!


---------------

Florian Schmaus (1):
      PM: hibernate: Freeze kernel threads after image preallocation

---------------

 kernel/power/hibernate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)
