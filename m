Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4125B09E;
	Thu, 21 May 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368486; cv=none; b=UKHimv/q0nb/r26lnapLmBCTSLLQnxLt7/Q7OXD2nDaaP6pCOM3y4Gejb2FtQnS4IqlOJBsFpCRwLJ9wUyay2Q+iilubCQ+ipL/anXoPsVjw7r/WieP80h5At1Rpin1p8Ypb2rdEBeMeoiRoyS90J19Jg1Nje48mANew3fQ9flU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368486; c=relaxed/simple;
	bh=LzBBA30mVQR9do3IoDIGdLISLgWIk5G5D/Lq3aUaJIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcucgJgkiIUt+O1sX+xcXapEGhSeAObJ7hZX/l/lc17ObvDPNtXeWZc1GxO15YRqlPeScsB0QgX+NhePCafi4KCxMN7AVQ9E2WIGprlzAk3YMkIwLHYXu7AwkWxFJI9EHevfqHiDFSWtdtldOWDHLXtkjj7MfzFH8r43Z2wHcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQzDXNuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQzDXNuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E454B1F000E9;
	Thu, 21 May 2026 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368485;
	bh=YZ4Q3TUDO2GIop7GRyVIOG7OcA4OTXp7XlWjhqU8v/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQzDXNuydk9jwibHbEes12ds66ESkTE8eyo5qKVKsOw8bZclsMscV09t4FUiAnSoM
	 5M64ai58AK16ClOm1Sf49PpUrAcfrPHjkYv/pQ0uS8LJQdve7+Y4gOo5iLTdokSpBC
	 LPDLZqcwRMmUSCivmnekAB0cT98ufnYnPl5Gng4kjZiOiLbbAbaFF/sGFEEjJN1E0Y
	 TYvc09KJIqjoU0x2J/CmwKybhFv8H1ELM/2W+NsoPQW+gFzQrlvoygYrBOWorEfzyP
	 7pex8RxEPGnQTPpE1CGJwdK/QMn6z+bZxyl1a8BZSYDuhkHZ43N4HSLxivVeM4jwoy
	 jdTyyg9Xhg45g==
From: Yixun Lan <dlan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuwei Wu <shuwei.wu@mailbox.org>
Cc: Yixun Lan <dlan@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Anand Moon <linux.amoon@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yao Zi <me@ziyao.cc>,
	Vincent Legoll <legoll@online.fr>,
	Gong Shuai <gsh517025@gmail.com>
Subject: Re: (subset) [PATCH v5 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC thermal sensor
Date: Thu, 21 May 2026 13:01:16 +0000
Message-ID: <177936776325.387485.15662058076324687710.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
References: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Apr 2026 15:15:14 +0800, Shuwei Wu wrote:
> Introduce support for the on-die thermal sensor found
> on the SpacemiT K1 SoC.
> 
> Include the device tree binding documentation in YAML format, the
> thermal sensor driver implementation, and the device tree changes to
> enable the sensor on K1 SoC.
> 
> [...]

Applied, thanks!

[3/3] riscv: dts: spacemit: Add thermal sensor for K1 SoC
      https://github.com/spacemit-com/linux/commit/247c77ff5806bcd6a5ff802718de1f0aa2bcba6c

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
