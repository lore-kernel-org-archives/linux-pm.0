Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6336EA93;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040285; cv=none; b=rIrDaIh2z7fuGiiDCEp7JCWi+MMHEjCXjtVWon7zgO5l/r1Ticl5eSztxZzPLIdDMtr4LCS9hF7zyDQN83lCVsiIMYBVQmj8rRhRT1SBD/dA2ph4qwCkU1pZG/1lHJEk9Kfp7cKDj/YXEfzGjaeXG8ZvrSFPcud53zoWK0VoGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040285; c=relaxed/simple;
	bh=iS/eUwwMdVFzfK8MlyhjnMq/tM9U1dbxJyRgPvGt1xw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u7SbGnoxG7eVCpvxfRF48Sru0VnVms5l/p0OLiLa4JWTkt6scxxX5LWhp1sBGKjnSAUWj95u0Riq/e6iY2mRwQfe5VO3ssWeFx1zwqXzffPkm2L7/wOslljHvFrPPt5DmCA4bsBScdSAp+CS68JSlrBbE5XdjAEwdu3IEbSV0uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV+hLGGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV+hLGGU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35626C2BCB3;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040285;
	bh=iS/eUwwMdVFzfK8MlyhjnMq/tM9U1dbxJyRgPvGt1xw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uV+hLGGUZSW93FQvfEreLx/vXRGsCgoeCZP6i3pPUZG/jbtWiiSwL0Ui0rMR34xPS
	 LyZTQ6G/9qnKB6+l58NOXIJs+u7rOY4AFQwzhO5fJ2JOnA9hrcAJZBqlfl4BGkm1b9
	 quvguBzD3TieMqENv9LbqCcFL+rf24BF1uqoB2Zuoy5k/Xnd7cF4zYBTdgmvf33tgw
	 lgnB7IDnJicGim72vKSTS24dE+Txg8I0/yWc8HnoHWUaGQLyrR2EUM+U9YFfg+qurs
	 JKOlzd+v217xBHdZYU3pXyfM0T4X8LbRfjst6lHpINGv/0cg+sKm3IQHlBIh6RtO4F
	 DUx+ftc8XgVEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EF7C982FD;
	Tue, 22 Sep 2026 01:24:45 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Subject: [PATCH 0/2] PM: sleep: make the async callback state explicit
Date: Mon, 21 Sep 2026 21:24:41 -0400
Message-Id: <20260921-mb-pm-main-v1-0-1d4cbd9d2b2c@vt.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANnYsWoC/yXMwQrCMBAE0F8pe3YljcGivyIeNunGrpBYslqE0
 n83qcc3zMwKykVY4dqtUHgRlVeu6A8dhInyg1HGarDGns3F9pg8zgkTSUYebTQUiQbnoA7mwlG
 ++9nt/rd+/JPDuz20hidl9IVymFq0cxmOJyzBwbb9AKT0AlOOAAAA
X-Change-ID: 20260921-mb-pm-main-ed2f0afaa744
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040284; l=1062;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=iS/eUwwMdVFzfK8MlyhjnMq/tM9U1dbxJyRgPvGt1xw=;
 b=m/1p/8Kw0cKXFUUNs6T0+gIF2NOs8aKH948moy2ip0ShkNJVF2oq3YzqmemITIKbPS4Cg1llE
 49XebTnZxW9CWy5AvwVktstFbt5GfZjIikARkMYnuX3iQGDpcLRzY8a
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

The dpm_*() phase functions publish pm_transition and reset async_error
before scheduling the asynchronous device callbacks, which read both from
other CPUs.

async_schedule_dev() contains full barriers, so neither patch changes
behaviour. The first states the publication with a release/acquire pair on
pm_transition.event. The second uses WRITE_ONCE() for the async_error reset,
so that every access to that variable follows the convention its readers and
the failure paths already use.

Found with MBCheck, a static herd7-based memory consistency checker.
Compile-tested on arm64 with W=1, no new warnings.

---
Jaidev Shastri (2):
      PM: sleep: publish pm_transition with release semantics
      PM: sleep: reset async_error with WRITE_ONCE()

 drivers/base/power/main.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-pm-main-ed2f0afaa744

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


