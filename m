Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1A471279;
	Wed,  9 Sep 2026 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990727; cv=none; b=ibpjfIkuvknMFqiwGoUwhVMZKf9wt2EaSil7VK8R/fOmErMNTXHxFkw8bSBiBc+Q7EP2yWxeL8PaabjGrW/4N5NY18ybPB9/2C/I6cVIeNE6sS6kiQgW6DqqqX7QeCnCYJelOfYRF4jFbLBYowIbbdnInvZVchKyEiLxE4UUsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990727; c=relaxed/simple;
	bh=523Mbb6O2uE2dp+EsPbU7CW/pAvf0urliF5CjdPdCgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DhR1ASfmR8TlJ9a/ks+9Mhe3IotgghpagQdVPvHWn+MOFebrE/TyBWD/T5TerCD/fh+bVDOxDfz4ijlbNUx492ba9bcLU+sHL3+ymh+lNnbmL2ih44b1shEoYQt1wtx/CT9qYXc6SGTpZBQhDs6veyrppkmBbpOL3BMm3JgX04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC041F000FF;
	Wed,  9 Sep 2026 21:51:59 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id DAC39183378; Wed, 09 Sep 2026 23:51:57 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Matt DeVillier <matt.devillier@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260825120929.13168-2-matt.devillier@gmail.com>
References: <20260825120929.13168-2-matt.devillier@gmail.com>
Subject: Re: [PATCH v2] power: supply: cros_charge-control: adopt EC charge
 state on probe
Message-Id: <178899071787.893782.7592848745481993513.b4-ty@b4>
Date: Wed, 09 Sep 2026 23:51:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 25 Aug 2026 07:09:00 -0500, Matt DeVillier wrote:
> The driver previously always forced AUTO with no charge limits at
> probe, which discarded sustainer thresholds and modes set by firmware
> or firmware setup before the kernel loaded.
> 
> For command versions that support GET (v2+), read the EC state into
> the driver cache instead. Valid sustainer limits are adopted as AUTO
> with those thresholds: while the sustainer is active the EC may report
> IDLE or DISCHARGE as a transient hold/discharge step, which must not
> be exposed as inhibit-charge or force-discharge. Sustainer off
> (-1/-1) still maps to Linux "no limit" (0/100); other invalid limit
> pairs are remapped the same way with a warning and pushed back to
> the EC so the cache stays in sync.
> 
> [...]

Applied, thanks!

[1/1] power: supply: cros_charge-control: adopt EC charge state on probe
      commit: 58a5bc61cb7065b52c5b3f537724b1991a88f3ea

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

