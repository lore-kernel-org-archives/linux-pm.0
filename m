Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AC33E376;
	Mon,  2 Mar 2026 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494920; cv=none; b=b1bhr0oEiFjcoqE4vbOM7OuoHw2hLnWCayXyGvUNha5pKhGv7IABqIxgzmDhAl5Oki5SSjsGxjShNDpF2KSgwSeLlT4FiGfAlHPAiTL9CxOjM5M4g6wK9/tmb0/xCpD/+4X6zNOwf32jzUE0VYyLnU98VQyc9LZGDekoZNInem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494920; c=relaxed/simple;
	bh=XFwxspNX9VZGzrUz9jgp51VfeIO2J5v9ai5DRcyX7s0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h2Ym8dU6ti5C38MT2k+YaiwHYX86G+/oWCz1tds8Taejm+Ma9welt1olEWMI5Sst67boLCLHw/zyQIaoaXUZdGOFlml34fuSWKrW/6Vd3krOROP3c+MqVb+cffMa8YYgC998CI2CAYZj+4dxsH0yF1ueWWZ6vwD7Z1E9Oj+iexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B8FC4AF09;
	Mon,  2 Mar 2026 23:42:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3710F181258; Tue, 03 Mar 2026 00:41:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Michael Reeves <michael.reeves077@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Hector Martin <marcan@marcan.st>, Joey Gouly <joey.gouly@arm.com>
In-Reply-To: <20260217-b4-macsmc-power-v7-0-4a4d63664362@gmail.com>
References: <20260217-b4-macsmc-power-v7-0-4a4d63664362@gmail.com>
Subject: Re: (subset) [PATCH RESEND v7 0/2] Add Apple Silicon SMC power
 driver
Message-Id: <177249491821.606802.13655015043720076680.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 00:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 17 Feb 2026 21:47:24 +1100, Michael Reeves wrote:
> This series adds a power supply driver for the Apple SMC found on
> Apple Silicon devices. This allows the kernel to report AC status,
> battery charging status, and power metrics, and modify the charging
> behaviour.
> 
> The first patch adds the driver itself, and the second patch wires it
> up to the MFD core.
> 
> [...]

Applied, thanks!

[1/2] power: supply: Add macsmc-power driver for Apple Silicon
      commit: bb7cd531f275cd643da6f26af0a25acdef6f26c7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

