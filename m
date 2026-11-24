Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534851;
	b=5ivEladuWEws1vNAe0cwn1FoWXg+HqEIw/YARF8nBHiWoDr2OfazHRLkepYhdFHL+VEk
	 7NbIh3dFL7Ka3jUWHdIsTRdPkkM58BGFMQgWGLVWBEWxSQHOQ0Di8vZkzWBcjYAKK7Cpz
	 bPqdn3nh64dsOaVdkpH1C8U9YKkfNlLMDzFnHo0cr32gDWxEFzVCjK+EUxYSr9iOeQHOV
	 PGwoP4n9d4VCjxsRpMyo1js8SSL0ndvtpJ3mpJlk1P3XJKHOfbu1IUFu7Ead8FZcUYQer
	 yoizh6cQUXq6Gx3Q1CdIeEWZvCLdYjiWkzt8rXD6AIcRm5CG8oMwr4Ibuc1J4c/SlCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534851;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=yytJ7lDVt9QuxlTp1k/KOADhM4qTcQ1NXSvg1e5yx5w=;
	b=xPXEeONj0FJ8m6/lE03Nk6OwdgkX1am0VcaIhMrCXOpj5ZCxsZMLpJ7E0UAtQUUPMMXQ
	 58R8gMN1grrk3srL1fjJcy3VPf8sPsDqEFwMIjYYzctEGbBTDGj6h/Bl0tTb1qHkxf0P9
	 estyzz25WwaZNC1wR6g2+4GDNnyXzjMBTwCjatOubjE/qbp1S7kHTBHyLbyFalpQ0Es1c
	 nfJIKSBII8Lxd/5bOQSSSamkyTT1qBo0vdRNXYHi75aoDtgEnf31HcveCPhLaEgzjESOl
	 0Xhajup3BblADcH9dUk4BbTiwSyRwjw9exChKLMXvrrcJd5f35Et34gdFnROnDCbuMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibX29X4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19623606A31E;
	Tue, 24 Nov 2026 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibX29X4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D741F000D2;
	Tue, 24 Nov 2026 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534850;
	bh=yytJ7lDVt9QuxlTp1k/KOADhM4qTcQ1NXSvg1e5yx5w=;
	h=From:To:Cc:Subject:Date;
	b=ibX29X4UugthlCcIiVskgUNlQwb9gv0Y9cYCJBY3KJaqVQ8JFjOw0993Noj+xPnzl
	 wbl3qLaz7otY0yhqdhHLd1QcxAd/PnmR3/ALY5rxyWdjea7YHuSLEJGWpi3br+qfLg
	 YvQSQeh6zclevrwuDZuI3K115uSaJ/8QDuuAlV5C7r3tU+PKBrLpHtYxfPMBpSFh7H
	 YuJ+10nYNeut6/uPOlh+Z93JK4Rmd+NBFwhyjPEai+5BSdxv1ByOqmq+n3U+oo5hIL
	 Xp1bf+QcWGQBVstxqdLGoXpCFbtvUraM1q5wt7uP1WNpYHSocFxb4dy5qyIiZHM6J+
	 T4X/XrI/BI5TQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: [PATCH v2 0/4] PM: runtime: Fix issues related to autosuspend
Date: Tue, 24 Nov 2026 16:29:36 +0100
Message-ID: <4779892.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi All,

This is a follow-up series for

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=26236a3e8803f7e1ace104020d7f006edb220116

which is in linux-next and it replaces

https://lore.kernel.org/linux-pm/3076901.e9J7NaK4W3@rafael.j.wysocki/

(hence v2).

First of all, there is a potential issue with respecting autosuspend delays
in pm_runtime_put_autosuspend() and pm_runtime_put_sync_autosuspend() that
existed before the above commit, which is addressed in the first patch,
and that fix is relevant for the other patches in the series.

Second, the commit above overlooked some cases in which a running autosuspend
timer may trigger between dropping a runtime PM reference to a device and
updating its last_busy timestamp, which may cause the device to suspend
without respecting its autosuspend delay.  Those cases are addressed by
the second patch.

Next, I was mistaken when I wrote this in the changelog of the above commit:

 Updating the last_busy timestamp when rpm_idle() returns an error
 without calling rpm_suspend() is not useful because the device is then
 going to remain active for an unknown amount of time and its autosuspend
 delay needs to take effect later.

There actually is a reason for doing this which is that an autosuspend timer
(left behind by an intermediate runtime resume) may be running when rpm_idle()
runs and that autosuspend timer needs to be prevented from using a soon-to-be-stale
last_busy timestamp value.  That is addressed by the 3rd patch.

Finally, the last patch updates a kerneldoc comment that has become outdated after
the commit above.

For details, please see the patch changelogs.

Thanks!



