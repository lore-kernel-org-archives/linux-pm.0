Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009221A6824;
	Fri, 24 Apr 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017190; cv=none; b=r6coZB1Nsc8oqJw0NNMpJMHuc2S8HeI/LHmytXB9r2qKX9tR78ncsAUMWeJLV236z7BQlTN6/XiCzv2PkRGtDc+D5XZRFsV476LHHqCTBfP6GRMGS6h7/o+nSPMt9aIgYkEkz5IP9WYOc9MQG6gpZo/+xzPRvj9DWCQ+D/VgzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017190; c=relaxed/simple;
	bh=GkjakA382zoWNVbHxl6dk01JazLV/uSBP8Dj4HZRGvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ov/bofonq7p8K9L0YA/JtEcdOxgNEn1xg+cuabv1mNMhg41xsbxTum3zz7hTmv+pp3sgSEm3d7+TcWWOARpAf2IjQZjCvLj4Le3/AIYHmE1u3/LxSAPWU+opWSJvQ8ARd3e2s0rnsYThZpAcXCGjl87Cj2y7lRQf1LRBjXEJPpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6lO4Yi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6lO4Yi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C424C2BCB5;
	Fri, 24 Apr 2026 07:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777017189;
	bh=GkjakA382zoWNVbHxl6dk01JazLV/uSBP8Dj4HZRGvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b6lO4Yi0DZmLmWYNrfeCJyulbwIdJYCRVbdvFFe1SpAsFgUqk42LSiRbqG+y9yZL+
	 A/glD1pRiBr5xL/UzH6At6Tclj+jmOrD/YLoLDoQcLhN787CVjnM9/s+7eNOHcakmK
	 3WbsNuC2Ifb3Eg41W91rbH5SxeEJDAPH5+XwSn2ptQOsWXyT+/aleLlb+lggUIuahT
	 7IUBAJat/61N6t/WHHxq186UgLV6J/PBwXCnU7cNIvpddOs8eA/gJNpftszPc85JYD
	 EhKGWqRZpp4I9wvt/bhLeMqVI8ttMLqCCk4ovWzznO9BawnZdX5jDYwgtZ9JRfUaEx
	 3IuA3cEkdljwA==
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
In-Reply-To: <20260329-sc27xx-mfd-cells-v3-3-9158dee41f74@abscue.de>
References: <20260329-sc27xx-mfd-cells-v3-3-9158dee41f74@abscue.de>
Subject: Re: (subset) [PATCH v3 3/5] mfd: sprd-sc27xx: Switch to
 devm_mfd_add_devices()
Message-Id: <177701718589.698484.16565484483941180885.b4-ty@b4>
Date: Fri, 24 Apr 2026 08:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sun, 29 Mar 2026 09:27:47 +0200, Otto Pflüger wrote:
> To allow instantiating subdevices such as the regulator and poweroff
> devices that do not have corresponding device tree nodes with a
> "compatible" property, use devm_mfd_add_devices() with MFD cells instead
> of devm_of_platform_populate(). Since different PMICs in the SC27xx
> series contain different components, use separate MFD cell tables for
> each PMIC model. Define cells for all components that have upstream
> drivers at this point.
> 
> [...]

Applied, thanks!

[3/5] mfd: sprd-sc27xx: Switch to devm_mfd_add_devices()
      commit: a7999115bcecdf2620b864080fbb4f6e87269102

--
Lee Jones [李琼斯]

