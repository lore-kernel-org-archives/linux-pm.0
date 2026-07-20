Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B6266B46;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583828; cv=none; b=RegEybupYOGiKMILJ1pnomGelYjemNrhrtzxPhrEwEmhikf78yt13wesUPpxFge49nQsvcU8gpvEO9U3MdlfxWGsrfVqhtNR07lKQvAnFKBlFJ2YU6w1YguXOMcbAYus6vnXIcqoIS4zT3+r7VWyh6Q5IUqifAVc11jjEDKojwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583828; c=relaxed/simple;
	bh=Aj/WK0wneOpE2vP8H7iwjacRk0G6xA0Om/pREqe4ebY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yh1TK/PhZVutvKuEwKbjk4a61tWFsiOg/rYm+ymnsqqGQ81z9h3efXEs8v/LTVzR5w4gDvIOQZkbhRR0HJZqoHlxAHfXjbd5XphbBl3Z5FQF4wHiBije0/jMFIo78XIRtLxR0RxWAN+7ManxDnEJjt9Kyc35dmwc+JTgfkI/3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D77D1F000E9;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E0D76180D65; Mon, 20 Jul 2026 23:43:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260617-coldfire-rcm-power-on-reason-v3-0-1a7c7b6b14e7@yoseli.org>
References: <20260617-coldfire-rcm-power-on-reason-v3-0-1a7c7b6b14e7@yoseli.org>
Subject: Re: (subset) [PATCH v3 0/2] Coldfire m5441x: add RCM power-on
 reason driver
Message-Id: <178458382591.311390.7037869995875502817.b4-ty@collabora.com>
Date: Mon, 20 Jul 2026 23:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Jun 2026 21:17:14 +0200, Jean-Michel Hautbois wrote:
> This series adds a power_on_reason driver for the Freescale ColdFire
> MCF5441x Reset Controller Module.
> 
> The MCF5441x has six documented sources of reset (power-on, external
> pin, software, PLL loss-of-clock, PLL loss-of-lock and core watchdog
> timeout). They are latched in the Reset Status Register (RSR) at
> 0xec090001. The new driver decodes that register once at probe time
> and exposes the result through the power_on_reason sysfs ABI.
> 
> [...]

Applied, thanks!

[1/2] power: reset: add MCF5441x RCM power-on reason driver
      commit: f0ec0d960c99837dc61e1604c3ec83e53c8c829f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

