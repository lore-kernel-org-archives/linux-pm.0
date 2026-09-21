Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7233E1208;
	Mon, 21 Sep 2026 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985055; cv=none; b=fUNyfbmCEHYsYf7U4ENmOiibjXoz0khSt+xCi9+2nZvS8j2dyTWL8kUiPPd3luM8tf2yMcTqShhsP54be1VQwchtya/ZJSL82alASiThyGUuJ0EOwsyulr33ZEFkilWwUj+BNer6NsXe5h0iYac89G/9VKOWIrfLG96Oyt6wOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985055; c=relaxed/simple;
	bh=A8gaYmUkSM+jn4VvqkxmBxwfP3N9MkHk1rOei+jlYmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lR+Nk8mzj0KvvH3hlg7HuMWLClHJOvxRY96FF4/d9QBTQnG1bE+MH8sQdvUjHjTohSH7amHQJcBZeosIzc/+sImUz0KRI5CaQPapwvDLVlFt77Y+7wNLqoxywzeRXrOkQ4GqGqZzwGmXTdAZPtjcnGY1OgAC36mA44U9xQ4WcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JdgK2IKg; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JdgK2IKg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=2F0Tbrfy9uo0WVdHDWHMfFSMVTYsoVYdSEjqRs17iXc=; b=Jd
	gK2IKgE+ZdOV8H1lwTJl1xa0fXCTMCBVIOlb0NUb2O0R4rzkAZBiBUiUoZeBvb9/IlhcuGEJn+Xjl
	WFQVZxxyfD90o2YkZLChRXXju6ka5NWA5CggJjNe+kivrc6ufP8U5iGhwc6SsOu3OuARZIdedceRH
	eqjA3KEz7be0qW04mZcorx3xOOMmmf+OPcfso+Rev0GamdH+rRrn43QbfOrTQuA0qJ7nTd6usKtBb
	ObZM7jmcdnmh9H7dUDHv7sghfXxvyGuzZzgNnV0A5NsELtCaGSLH0hZNGjaSQ/gcGgH8hVwZwiV1F
	TgqR9PchSiD6R3Hq4TpLyk4G/gkICTWQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1x8aXa-003NL6-1M;
	Mon, 21 Sep 2026 09:42:26 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Linus Walleij <linusw@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/4] Drive-by changes to axp20x drivers
Date: Mon, 21 Sep 2026 11:41:45 +0200
Message-ID: <cover.1789983244.git.ukleinek@debian.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=ukleinek@debian.org; h=from:subject:message-id; bh=A8gaYmUkSM+jn4VvqkxmBxwfP3N9MkHk1rOei+jlYmE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqsPvbF+HNmRvpLLvfl19whxTpONAs6lE29JJT9 Fh1g+CJYfaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarD72wAKCRCPgPtYfRL+ TgrVB/4y4ubjYC17eSCesirGhjAgo2UILzYp7z8zo/qfiP0LKASDG6DX7rcSW+srhk3iVjisznw Y09RqswwMThnEjUfZbe5Xj5J9rRvAMs0Gf7iJtIhBFIPUF7AEzXwiHxZQMM+EiKaD9/hybNee8h q18jhfllew1mSPWKuyzJ1e2AXRPAFOrlIszjVJAcPrMpSIDSrs42Z7uvVxFO4KBbGwRCYzz5zc0 HjqGFjQutbfCmcBFJy1UMxBiFfyPRYsjaAC/LlMT4WP1A3jgXE5WNl81+BQxFWMfGQOKSBapWiC hOTK9JXiBOYh9FKQwTji7xPhlrnJQDF07x9zAXV1GvOzXAcJ
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

while trying to help a Debian user debugging why USB doesn't work in the
installer on a bananapi, I discovered these patch opportunities. They
are only build tested.

The first patch touches a different subsystem than the other three, but
given that maintainership overlaps and the first two patches are
identical in spirit, I still created a single series only. The two
subsets are orthogonal, so can be picked up individually by their
respective subsystem maintainers (and please do so assuming you're happy
with the patches).

Best regards
Uwe

Uwe Kleine-König (4):
  pinctrl: axp209: Drop check for disabled devices
  power: supply: axp20x*: Drop check for disabled devices
  power: supply: axp20x_usb: Introduce a helper variable for &pdev->dev
  power: supply: axp20x_usb: Improve probe error reporting

 drivers/pinctrl/pinctrl-axp209.c        |  3 --
 drivers/power/supply/axp20x_ac_power.c  |  3 --
 drivers/power/supply/axp20x_battery.c   |  3 --
 drivers/power/supply/axp20x_usb_power.c | 50 ++++++++++++-------------
 4 files changed, 25 insertions(+), 34 deletions(-)


base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
-- 
2.47.3

