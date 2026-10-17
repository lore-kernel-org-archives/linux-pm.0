Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543C3DC4C8;
	Sat, 17 Oct 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274198; cv=none; b=H8bftCJLEzrysrX5iQPpSaOddpGe15GsYysv/Hp7nfP3g11YayCjYCKQBdYsddjVuOtY6MVTtUZgnca8HakVQkf1h3nosG6d+cEoZHsuD+Fj0WoEQZEltVDgJSdEbJ4UiSxQLsAsX0/hCaGOrJCw0ZaJTftNj0PLIsvhXKk4Gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274198; c=relaxed/simple;
	bh=h9sIoYj/4OT89sWZ5HOHRZK73thUW1s+E1uItrhtnWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gKUJm5ddJdRAsZ1VHgP+9sWUSTUCxZh4iz5K83p+2Qw4LIh2ufp1aGsUb5hEzi60eSuKVceS+5ta4F3/vEj+z6Tmux5E3spR5c3h3IZ04SRQtxR8L0dst/Hk+a7fxWrkB4EFvutvpXJtWfErJLqgppQfKbH40GE4vO4IGRIFsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F211F000C4;
	Sat, 17 Oct 2026 21:56:36 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 90C161824BA; Sat, 17 Oct 2026 23:56:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20261015-bq257xx-dev-comment-v1-1-c87ee6a3b251@flipper.net>
References: <20261015-bq257xx-dev-comment-v1-1-c87ee6a3b251@flipper.net>
Subject: Re: [PATCH] power: supply: bq257xx: Describe the dev field in the
 driver data structure
Message-Id: <179227419358.76434.985474943923116149.b4-ty@b4>
Date: Sat, 17 Oct 2026 23:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 15 Oct 2026 16:45:03 +0400, Alexey Charkov wrote:
> The commit moving the device initialization to the new .init callback
> missed the description of the newly introduced dev field in the driver
> data structure - add an entry to the kerneldoc.
> 
> No code changes.
> 
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq257xx: Describe the dev field in the driver data structure
      commit: 9c034b714ff97bbb0b9b9946857f7244db11eea0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

