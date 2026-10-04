Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F0474246;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136004; cv=none; b=uNruYu/h8ZCMZm/qSMAnnjA3OfcHmzecEfJ+Z/SpYACD1LPgqmYNL01pQJ8I+3st4vsUhG/M8iJdGTOxnMtPw3xQwMCyL1Y/wgNXp1yOMIpks139I72fTA8BkfOJTkAwyHh0UzEOPgcWl4TX1IeNJAdstBaGXhhu50ANymSBcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136004; c=relaxed/simple;
	bh=AZzMkKHLVyn9+eSiEVa6BHE5foB8sdFNGExauzB8jVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o/IC7EOF5osdLaYIAE88s115b5NCj44prkIS9wOuqxAt1RThEr5cQXBZYxkeMTq8iBeQXa03jOLiE8rGyPuSP1GOw1AcPIyNupt9X+Zud4P4fBMKmUiw3LS7MG+fDDk6+HNxjJTSlqh+n5RfmuDvUgXGjp8AoR7Jv3oIzoUDh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304EB1F00898;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 008EC182AB8; Sun, 04 Oct 2026 19:46:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <cover.1789983244.git.ukleinek@debian.org>
References: <cover.1789983244.git.ukleinek@debian.org>
Subject: Re: (subset) [PATCH 0/4] Drive-by changes to axp20x drivers
Message-Id: <179113599798.190565.3353927757122542403.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Mon, 21 Sep 2026 11:41:45 +0200, Uwe Kleine-König wrote:
> while trying to help a Debian user debugging why USB doesn't work in the
> installer on a bananapi, I discovered these patch opportunities. They
> are only build tested.
> 
> The first patch touches a different subsystem than the other three, but
> given that maintainership overlaps and the first two patches are
> identical in spirit, I still created a single series only. The two
> subsets are orthogonal, so can be picked up individually by their
> respective subsystem maintainers (and please do so assuming you're happy
> with the patches).
> 
> [...]

Applied, thanks!

[2/4] power: supply: axp20x*: Drop check for disabled devices
      commit: c9ed44ab230f4359cdb3a72263c65daf31bd8528
[3/4] power: supply: axp20x_usb: Introduce a helper variable for &pdev->dev
      commit: da54acbc2ff2470c49259a91a5f48c4b0cce09d7
[4/4] power: supply: axp20x_usb: Improve probe error reporting
      commit: f945606a8cb34c97d644ed487282f96641b05185

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

