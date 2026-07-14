Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAB32AAA0;
	Tue, 14 Jul 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020326; cv=none; b=LaDEPBaugXTMfiY+uOSy5sCINAIcW+uTulTyFossvTr4jyz1puzMRgzF/uEfdqqOLr/tkxKb2NkxkJPbDBNrrT5V6bch0bidQP5OSFvmLwaG5jXGZ9vqtO88EpQ+YLtFvDJllezS5pGmX9Q1en9daXH4ThdkWTSdAQhQWYy/4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020326; c=relaxed/simple;
	bh=4jFuKhT1ET8uRm76rjsSNFtNGde0a6vl8wN80kGvhKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XszFcQEX82aaSNklbTXn46iaLrzN6y4ztWXsF52VA4+KKKJsa8/qE8HAgdC2LqtNy/ZNQ6W9xOY6sqa7OB9ZhFO98PbiB3rlJbViVd2JGToNBS6jKDR32H47Tu94He3wJoIgqbJUfgCfdgfi2bO9nNv/AeLGgyWVnZ1Qf4sf9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B67xo9vh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B67xo9vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428C11F000E9;
	Tue, 14 Jul 2026 09:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784020324;
	bh=HS8GPuh1k2NPJ/kyd+W9EnihrSZfG4zVFWpsfKm2RLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B67xo9vh3DdJ8o/dp4ZQsuG29EfitlgjNPjp9PmbZ06SgBuPm1LwkQGs5sE68LroG
	 7In1YqIfMytKKyWpIBuaTW5YipC4g7dFypUI0irviF3Ba0EhuPvTgsCPc+6p97NUsM
	 ormiUF7raDaQ6dVZN81dDALkPVJ9miYWxabK7lS4a+EA4hVJqxkN4zSrmyiY299vkk
	 5TK0hxNkuAicY8VvItMDC5wQTKc0HYr5lC2B5BvgC0DE+UP4NAvOAoDvdwWofcOw93
	 4mHz0Yr+Bez5qqiFf6YhIXMwHD4n+TRSV3/2QjSyFktYsjfno50kVSlz4ArvpCpUrb
	 72ZJxtrVklgAw==
From: Yixun Lan <dlan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuwei Wu <shuwei.wu@mailbox.org>
Cc: Yixun Lan <dlan@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/2] cpufreq: spacemit: Add cpufreq support for K1 SoC
Date: Tue, 14 Jul 2026 09:11:56 +0000
Message-ID: <178402025712.1568061.9223355686030414906.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
References: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Jun 2026 16:10:22 +0800, Shuwei Wu wrote:
> This series enables CPU DVFS for the SpacemiT K1 SoC using the generic
> cpufreq-dt driver.
> 
> K1 has two CPU clock clusters. The two clusters have separate CPU clocks,
> so they are represented as two cpufreq policies: policy0 for CPUs 0-3 and
> policy4 for CPUs 4-7.
> 
> [...]

Applied, thanks!

[1/2] cpufreq: dt-platdev: Add SpacemiT K1 SoC to the allowlist
      https://git.kernel.org/pub/scm/linux/kernel/git/spacemit/linux.git/commit/?id=6f6369ada94038b189096b7a98330dee9814082a
[2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
      https://git.kernel.org/pub/scm/linux/kernel/git/spacemit/linux.git/commit/?id=199380e4d8cd22e539a08d4949e9582b09390bd5

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
