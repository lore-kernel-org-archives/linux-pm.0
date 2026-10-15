Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497C44065D;
	Thu, 15 Oct 2026 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066163; cv=none; b=gUlULwV84JaF8HstSRXNonLYoKl6e4YkQGPF4xAgmElH4Fh6dgde1hjPldNtxrSJkc9HhzKtJpzUBNBVSyN8Tk+1TFhiNqSCe1SBnkge7G/Fc0yklTEAjpclCUGhlJAhMzi5p1ZIIbPkilbrMs+/SRqguviI3/y9/kECRB0zEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066163; c=relaxed/simple;
	bh=0sn3RFOrakh++JgrNMf2BtdPuCWAW2pSyF92AX0juuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PogUhOQwBwXtYUNEZRw+G+CGlcrZCfFf4zIgPQGrdVwjpyO/DWond3+o6ouRDDTXm+zOtoF6Xk+SJKtNzC3sHP8U2oKDmP8jdtC1wpwGG8nGInlu+o4emkbn8t89lhLFRvaCPs+u2YrAmXd/Z2/uIRD14SO4XuMDjeNBfVdDxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jzVH2l5U; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jzVH2l5U"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3D3728008C;
	Thu, 15 Oct 2026 14:09:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NzdZqoO1GbzS; Thu, 15 Oct 2026 14:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792066152; bh=0sn3RFOrakh++JgrNMf2BtdPuCWAW2pSyF92AX0juuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jzVH2l5U7HT+syXP+bf6XKfjVhFRLQONV5WxdL6Rp2qexUOZERGt1UenuISGGVt+6
	 vYRer9qpwxUO/Iz0HwHqaKmSq8kGdPMJk76v8rarbb6RSZWOINDY1yjvFvo0McREYk
	 ASdbFA4MvdMyzD3C5M7Y2WZGYawfKSXTU0+ioZXXng4gFH9xy7eyiUzEUO8sooAMOu
	 lisyLzS0lSGLLunr2ge/t0PKpWeomR1jtb+fgNdAhQYVnT53xwRq3AszuYHd7jDAGJ
	 zCP+aQZJgykY8ipoZlrjGZbH0Ncwr+KaJ0oeJ7hd3L4xqMezBiU2+UUOh8OSH42Thf
	 QkTr4uKSGn54A==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: Rong Zhang <i@rong.moe>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Charis Stratakis <c.stratakis@proton.me>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
Date: Thu, 15 Oct 2026 15:09:02 +0300
Message-ID: <20261015120902.15337-1-aliamemis@disroot.org>
In-Reply-To: <08b6196a955faef9968224d7946ea5b1150f2ae3.camel@rong.moe>
References: <20261014132703.93355-1-aliamemis@disroot.org> <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com> <20261014150537.121547-1-aliamemis@disroot.org> <08b6196a955faef9968224d7946ea5b1150f2ae3.camel@rong.moe>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 07:51:22PM +0800, Rong Zhang wrote:
> Thus, any call to ECCC or RDER consumes at least 200ms in emulation, but
> in reality it doesn't.

Thanks for finding the actual deadlock!  The 680 ms came from assuming
"slow" EC commands.

I'll wait a few days for Hans, Rafael or anyone else to comment on
dropping the EC query and UCSI patches, then send a v2 that merges
both series.
