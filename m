Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86B4746AD;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136009; cv=none; b=J0hJKQme+gZb9DH6JABlG28amSzNP8JpT6ZspLPtdqpKXRExD53N6papFhXUlPdcl7TDSjj7HGMK3G12RDStJRDmhEgwaM6QEOW2LKvo5YDhInnGr8zu+WLZl00/QUdPWarWmTOrRJLM802hx0Y6j582kFS0omxPWGYL7WJrC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136009; c=relaxed/simple;
	bh=LOAH1/fP5z0O0HGxB4kXCi0ZaTdashs58kjka/LiWmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aREI7jXqAort9ZqWUB0x7q6I6ovDTEiZsy7TxiJJkEe1mzrYL4SghqFiS8C3YrpBuXxaMrTRbSLsUiMFpRdMTrCxn8zoJHDqgr89r4CkT50JjmP8L5YbVawTH17TCaSEGZFwn8pdS5SCGPAcF9E1fGL/kunhinN+XOy1ZUV81qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784211F008A0;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1C6B0182ABB; Sun, 04 Oct 2026 19:46:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, 
 Alexey Charkov <alchark@flipper.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
References: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
Subject: Re: (subset) [PATCH v3 0/3] power: supply: bq257xx: Fix probe time
 race against driver teardown and battery parsing
Message-Id: <179113599810.190565.15177158695762517847.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 10 Sep 2026 18:32:57 +0400, Alexey Charkov wrote:
> If a bus holding the battery-equipped power supply goes down right after
> it registered, it leads to massive fireworks as the driver starts to tear
> down its resources while callers from other contexts are already eager to
> process events using this driver's callbacks (and their private data).
> 
> This was observed on a bq257xx device, which also uses the legacy parsing
> of battery information from the probe routine, where it happens after the
> power supply registration, adding yet another failure mode to callbacks
> firing early (i.e. before the device is fully initialized).
> 
> [...]

Applied, thanks!

[2/3] power: supply: bq257xx: Use psy directly instead of driver data
      commit: 1a64071bb30d97b75a1029943b6a3481098b254b
[3/3] power: supply: bq257xx: Convert parameters setup to the new .init callback
      commit: 455e49c6700c8111d492923952a1fe3b98da0195

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

