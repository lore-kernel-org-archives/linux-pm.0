Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D6514762;
	Mon, 21 Sep 2026 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028404; cv=none; b=bD6UqfmZ95WBfZLmOcuSPvcolVYPL5zUmIHd8G7YqhcADiZgW1qbt4nkIMkXNh9v3MeNhWgObKCH/AFh1gwonKSCZ5XKUDosz7TszFRbPktyXk77VEtzOT03NMlq2gBeHiKDaT4HMcPP7b0AbXuf+WrR4eKyeYBXFQ/88/TUsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028404; c=relaxed/simple;
	bh=X/0hh96nzijd9yDSFT9pakn2WTJfPccstachVOiA3f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Il6MIWCMXnstJvWbrUMDVFiuaTesRtzvA0Jda5zCRoKA4Ik2JGgeQ75oLgr04J+O+5hFtLrnsZRoVszLEQHQZHNYjLWFrqhcV19rRs2Pq5edcwey1iMtEL8N319yUgYfgdHEp2yQasiiZLZY2ApseRBpVTS6a6zbl/NjwfbpXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VdwN1/m6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VdwN1/m6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Xh7r+wBULLX7xOhkCrEp64UsGuqdkH4pf7taI2bfz/Y=; b=VdwN1/m6cob8uyb69bcrs6kzSx
	wtZUqa2i/g68w6+aAstSNytJPJAdb7p0plB3mUGSxy1VC/EHfNYwPRyrZz8tiSDF1anBMUg7gK6rU
	eQC9D04+lNHkSnHgdukiwNCNsh6MSaUxYoATm8yDqOfGvbbi0V+WgZQImmgt9bArxhDuBZEaWhj7c
	xHLDzjwwbJGJ/pM0PyQX75uvDyz/O1A8n2E8GYOXOv5ZfHn9Z00J6AGt7DHP+YSCA3KUqgEzYDLnK
	EuCneA+xU2pEcqJX7T4gH5Qqo/H26phoAVxLkUy4Gsmj2RFiVxQ/hSIlSwLVSOTfYjm57u1SHLhSL
	t0eaVU+Q==;
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject:
 Re: [PATCH v13 09/14] pmdomain: rockchip: add optional per-domain power-on
 settle delay
Date: Tue, 22 Sep 2026 00:06:12 +0200
Message-ID: <15844283.tv2OnDr8pf@phil>
In-Reply-To: <20260915104328.45901-10-gahing@gahingwoo.com>
References:
 <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-10-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Dienstag, 15. September 2026, 12:43:23 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Jiaxing Hu:
> The RK3576 NPU domains need a short settle time after the idle request is
> released before the registers behind the domain answer. Without it the QoS
> writes that rockchip_pmu_restore_qos() issues land while the domain is
> still coming up, and the NPU throws an async SError on the first cold
> power-on.

are you really really sure, this is the fault of the domain itself?

The regulator also can just need a longer time to bring up the power.
Looking at [0], it seems I actually encountered the same thing back
on the RK3588.

Only difference is, on RK3588 a fan5355-type regulator normally does
provide the npu supply, while on your board it comes from the main pmic.

Can you please try the following:
=2D set your power-domain regulator to always-on in the DT (so it stays
  on even when the domain gets turned off)
=2D try to reproduce your SError issue and see if it still appears


And for the other case, look through the pmic datasheet to find the
enable-time values and do something similar for the RK806.


Thanks a lot
Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D8acfb165a492251a08a22a4fa6497a131e8c2609



