Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59035258EF9;
	Sun, 26 Jul 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078077; cv=none; b=FGLEerzTsvt0KqlaZIQEb4Ws1dOE8d1yDHjCkIbRmYe7Ci7HxrNNCq3c5OeoWLVxevooEJK29EtN36EJM217S7CXXE69UxBh0ZsQkZt+Wt1svsNn+AUAkcSMrBH7mp5jwfGjT1S4SDtqvEbhQLYzSBlxV2IdGctTvVSuAeBIBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078077; c=relaxed/simple;
	bh=Co/haKjVOYZQ+2iJ7vMmnKszHHqfkBsokaFLudtYZ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfcaFlctnDGSEjg5Epbv/CRGkbIRDSZgGm+9ubv6V1znsejNoXHCB1vdypt8kVoXKJUbJE7BP0ME1qyPBdHHLseNy1ZFD6Ku1PIyoEUNWvA7SDhkgOH/h1ir37Fo4C1EqPzNKpikKsHGwZEgPzP5usfl7cF5BsDvGsUwOhR7JMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8ADJwIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8ADJwIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B267C1F00A3D;
	Sun, 26 Jul 2026 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785078076;
	bh=KF3WLDnzhawv1E63jb1eZQJNVi9jAWSGddOpTswPwi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k8ADJwIM/9K4aDbthIc6E0Kkyy/oEv6J9w5YEtQwANBLNeCvAdtfmcvcKBClC7kgS
	 Vu4oxdUR9yQ9vPt0xvaXnpDtb/pLbjmJ39fp9kFIozkvK45h8UiK7QV0Gwfck02YMQ
	 3s88yuKoxxEgdEoY2v6/gk2rt2+mORJE8CcVZwhObDIWMsdIxJBvZqvjW9MITAl+q+
	 2Zje31YvYIGq+fQqg00uLmyEqb95ZlKqG93iprGDDNSCeqqJQaLAUiYDkMdyUQE2Fh
	 ql+wTAFv5Udl1ZNbbrbSTUno603bDlMWXmeWUjbEkUnEK13zCEjloPgCr9R7+Mz5nX
	 mz0TuyBRixPNg==
From: Will Deacon <will@kernel.org>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	chaoyi.chen@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/8] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sun, 26 Jul 2026 16:00:53 +0100
Message-ID: <178507139795.2055528.4355657426833307310.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718031146.3368811-1-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 18 Jul 2026 15:11:38 +1200, Jiaxing Hu wrote:
> This adds RK3576 NPU support to accel/rocket.  RFC: the NPU brings up and
> runs, but full inference is not correct yet, and I would rather get
> feedback now than sit on it.
> 
> Tested on a Radxa ROCK 4D.  The NPU probes, powers on, brings up its
> IOMMUs, and runs jobs to completion (rocket + Mesa Teflon).  Getting there
> took a few fixes outside the driver too: a power-domain settle delay and
> reset cycling (else a cold power-on throws an async SError), the full
> clock set on the MMU nodes, clearing a stale firmware page fault, and both
> NPU power domains on the core.
> 
> [...]

Applied driver changes to iommu (rockchip), thanks!

[4/8] iommu/rockchip: take all DT clocks
      https://git.kernel.org/iommu/c/841363ebb508
[5/8] iommu/rockchip: clear stale page faults before enabling stall
      https://git.kernel.org/iommu/c/b10d5920cafa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
