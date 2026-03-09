Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AA2522A7;
	Mon,  9 Mar 2026 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082482; cv=none; b=r6Y3+9DkABCom3voFAO87Gr852m1RIeqPVk2ALo+bg1lo+1lcgVEShbRokJdxV3lFs85fCtB/oe66U6N7uh8w6SN0qqrAY49k/JibLvR6hWlvmvmoyA7Rpk1uMzzlo/rino4Ew6uxTbGQ/uxpYlyTSxLHbDn+D+qZN3QcNcbjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082482; c=relaxed/simple;
	bh=ItcaXl8i5CYKhNzfahBwz+fIvVyHDL95A85+MWGEj+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RTnfufm+ZK8WPc+KQFl9CJpsjJ0hw7hDLlXZ+BYZs8QFKSKRyg6Jifc3ld2FTuxfo+Cu2UQ77icm9ZXIC6O5DVcw7wMCx9sZNNIWyJvqYEZ2hstPIIh4IaKq5CxVQ1kEoHPucapVupbMG906oRl34v8iCxhIySJ/T4xpZnLI2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCBUysla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCBUysla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0BBC4CEF7;
	Mon,  9 Mar 2026 18:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773082482;
	bh=ItcaXl8i5CYKhNzfahBwz+fIvVyHDL95A85+MWGEj+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YCBUyslaEh4FxVZSxBpQjunDjSpSxIHQJ2Osa/O2P2cOqe1W//QWbEKffWInMhfvC
	 5ZxQDH4uWCo97stqiF7jEv8b389fq4ylY7iw41ji/1iDgpm0rtKUboHAqHZYTgaey9
	 wq1gH3DZoKf38MHZl3jhpbYN56JJSs5V79fBKXv9md5wa86pQsHSQLM1A2eZajIgLT
	 96Qn26WuA37vSjIqtj3/rKS+Ij8wOGS9Fv27mPuEINCe8uVO3j1g9U6OEils/XzysM
	 ONZN81Y3DySxboGPKl6eixOCkOgbM7L6ppS9aTqqeN5lZdis5UsmDjlPebl/EgzsMo
	 H5T/7EeCkV0bg==
From: Lee Jones <lee@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-2-69526fe74c77@abscue.de>
References: <20260222-sc27xx-mfd-cells-v1-2-69526fe74c77@abscue.de>
Subject: Re: (subset) [PATCH 2/6] dt-bindings: leds: sc2731: Add compatible
 for SC2730
Message-Id: <177308247887.1642764.10057275958264547150.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 18:54:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Sun, 22 Feb 2026 14:16:46 +0100, Otto Pflüger wrote:
> The LED controller found in the SC2730 PMIC is compatible with the one
> found in the SC2731 PMIC.
> 
> 

Applied, thanks!

[2/6] dt-bindings: leds: sc2731: Add compatible for SC2730
      commit: fc2dfc3392ec52f12d8d6f16a8b13cca838d8bee

--
Lee Jones [李琼斯]

