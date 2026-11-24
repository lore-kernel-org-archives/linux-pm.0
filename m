Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494478;
	b=mfn/QG+JINWb2LeXhAOMyvnbcL4NayIFdnepHrfLGO8XkvJnbWyxdIuRVKfVPB/D3TIz
	 MVB2uymqHcs6p8kOlcvkgXSYATspBQwF0wGxErt5nB9dcZTpiUlPH5q4R3iV47m4jCGr5
	 2pfVfJPonUME7wU3QMqU9zmoTZCxfygxyX6kvZINCFquo07Gm/8AbXgtNcA1vmEUtv0BM
	 1eLjJ6//LPuCXhnO53bJhkKtczjyJNSFhN4okn6ZgBy5SnzsEznaWdEHpnN3itmBvwtgC
	 a8BeTqMcMVPJFxTNLE++F0EdoWxRsBwGn0mu9xSnNDp5vBYIOomvF9TY8jaxcYYZmaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494478;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4+V4dSRGnzJ/VnBrav+/YZ8i/rQ7LsI9He/HzxOZObo=;
	b=GOT759WtE2dSp9ROsJfgBJZwOBPkGmr8kxTk9YDhd6Vd+oEx7DbPZlBmq/thD3wu4naC
	 kAFVKfqF+1z8r+sYyAELB+blqm50zWb8dfZ+KApFtXmRa3LjMJdA8aqLS1EaPKo81BoPo
	 uldkZ3wGMecP7puhmK3frBgrp6/HA6ulaRcOU8hXudJhCSkjDLePIcwOFICP13bfWFDd1
	 5TZtBMvXV42RqNSC0/r+vCOEIuO/IfwcriNzx47h1bdJiBzfNEFS8Ran2K15pGuRx5ORr
	 r+zOWa8fdWMpc/nLdyFtfmIFGEMtRLiKWLQ7MmdZNn8znndTEeginQAaE4YCJ2hqDow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=PkRezWk3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F7606A322;
	Tue, 24 Nov 2026 04:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A76F7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=PkRezWk3
ARC-Seal: i=1; a=rsa-sha256; t=1795494420; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ENDkdvJleOPV+g1ulm2XPp2ajq+wL1ROaBUYZl4g/bYpinUNhffVai3/Sz964Hu0Y1JOrX8F8aeS8SJwRuGD9wem48XXslivjnw7KXU3n6aXcCnVbS8ePywwUovcJABvlZGqMOs8Emxia6bLiKig28e3xO0K9CrTg8LpcJRcJuA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1795494420; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4+V4dSRGnzJ/VnBrav+/YZ8i/rQ7LsI9He/HzxOZObo=; 
	b=fgFrYNl+nSlzp555z1gIy4JU5efaLRkASiLhr9bRV1aTzgfaf6fpd1SWR6Q7EZXKNldbxEa3p+4z6T5BHczCba5vBONaSksS2V/vT9Xcm97oTeizAyFc7Bmw2eDStBGuNyBxCyotbYWWIqcAn9GZQ7ZKkSY98UAWgWXXC5xSyrs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=PkRezWk39gKolyjHUxOIqzxoT9JZB1u2/1ecP74wq/KyGJ2t6sGkwZqAi527j6KumLib5Ftm0ySYy2+St6+DWpZ0fxLWz9nkbOxgs7vMD6/D5dtwK79ucHl4WT1/SPmOdxWxfnClUGnTem6iOlEc8c/wfg+4D0xB9hQO22/I/5g=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=4+V4dSRGnzJ/VnBrav+/YZ8i/rQ7LsI9He/HzxOZObo=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795494419197698.9156739315267;
	Tue, 24 Nov 2026 05:26:59 +0100 (CET)
Date: Tue, 24 Nov 2026 06:26:57 +0200
From: Igor Velkov <iav@iav.lv>
To: netdev-bot+sashiko@kernel.org
Cc: iav@iav.lv, andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org, linux-pm@vger.kernel.org, maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com, wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev, florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com, shenwei.wang@nxp.com, Haoning.CHENG@cn.bosch.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 2/5] net: phy: fix three paths that unbalance a postponed PHY interrupt line
Message-ID: <179549408687.90849.139754794817286@iav.lv>
In-Reply-To: <179548269886.3135.1487195148841555901@kernel.org>
References: <20261123-b4-phylib-mac-pm-irq-v3-v8-2-e9f706e79614@iav.lv> <179548269886.3135.1487195148841555901@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

> Can a stale irq_rerun here turn a stuck line into an interrupt storm?

Yes, this is the first of the three cases the commit message leaves
open, and it lasts until this PHY resumes. Closing it needs to know
whether this PHY's disable still counts in the line's depth, and phylib
has no interface for that.

> Should this check use phydev->irq_rerun_line rather than phydev->irq?

Agreed, it should match phy_request_interrupt(). I will fix it in the
next version or in a follow-up.

> Is this PHY's disable still counted in the line's depth when this
> enable_irq() runs?

This is the case the cover letter lists as not covered: another user
requests the line before this PHY does. That the enable can also cancel
the other user's disable_irq() is missing; I will add it to the commit
message.
