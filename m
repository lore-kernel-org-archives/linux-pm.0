Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494486;
	b=1D//P30l2+IIRRLrn7GIJkzYniIJXsgmCegoSAD7SXlwNg9vXqDsOZRnejn1AXX3mn01
	 POryoGQx/styZH46Sk16mnSypyrrvjyCXlvzZuMbV8QZhAGTqnDovlf/HZityW8n8RSxx
	 hjYuqKWjTsD8gEN6O/U3+KOua0OuJ1HZR6VsBrLLFEW7r5j6160yVQ5jRXKF+I5X8y3qZ
	 mioSWNFIQydd/qiAEWg/AEwGZT9VXaC30zUFR0Q9K/cRwG1d1E2X+iJg6zb/+j2ofnNuB
	 jkwQMQfCzI26OwcPlFu7hGl4Ry+rLruFXtfzT4lCNqZOYYX15BmqbtosTPRXJrLdNSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494486;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vuetuOMcXl7Z9VetHlJKUvaUZnnt7YAI79ma6kC/W1M=;
	b=c/k3kpY2aRtk4HIoUxT48obkKi5tNLfH7g83qnGL4eyPMGLS/QjEVIwnMksqL5lJC0r8
	 MDiKBUN2Knj/hKgJysnX/vPqIOiYzBHZ0J6oVjOZGQ9sWOq1Sb3uxVkLfJ0LNIf/X1dR6
	 8pAHq+QV95yBJkpSb+sn1sqGWWGMEbpR/0ETHL3PNrcTKv/Hp0QfJJa0LeWQD3MO3CMC8
	 yuPw1tvkPDU38ujg0uityI4JCud5aMysmwgHZYQGUYTIMoqXqUTSge21DGDO6TmUFi5jb
	 N9860He0ZYC2Zv1ZseXXBDGmRCbAlSGWGgfSEslopYYRFLP17B9/fSCVh477TIJZZMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Eekg1VTb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC49606A331;
	Tue, 24 Nov 2026 04:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC49606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Eekg1VTb
ARC-Seal: i=1; a=rsa-sha256; t=1795494443; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Cr1Rs+QodrLqQQ20hcMUtR7OGvnCP5i0DEoyl4qdrHQd7lrieXsl6gJ7cMVHwyuKJUWL0SF24FJpIr+h5xzL8lbvCRi0PkJoU0JGqOepBz1f43uvI5tsWVt4Lm5vRkVqNAyda2il7VTDbD/rv4WXgA+cz/shIf+kl9VRbTMMCMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1795494443; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vuetuOMcXl7Z9VetHlJKUvaUZnnt7YAI79ma6kC/W1M=; 
	b=T2/Rr/7HnJ2gG7bzZcVE/01JzR07zi8t9YLg0pEeZOC1ehE5eiUor1gTSFGsf7ZjLjvYdo/UipOQaGEzO7jZIEpThyg06kEKmtM+cXQzn/UlHek7LsOpygaN/klwy5UfmScVKLYxWP0xkKWfGe9qdzayl3tjnp4KXky+8f4j7zM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=Eekg1VTbLiA3RT5+LuRlMnci8jA7g7lxoiL0RFN0JBFtn5He01n3x5e/A0nv+RzdplzEX0HKgQ8WxqXC2mycPrD5U0+O4F05Y+5Lp7aVKv0xNHQQl+a8S4p9MGeR4iuWqDN5+lcs65ovS0hoS0CsARDAaJQgv4YBEsbL15L+os4=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=vuetuOMcXl7Z9VetHlJKUvaUZnnt7YAI79ma6kC/W1M=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795494441932964.2980390085781;
	Tue, 24 Nov 2026 05:27:21 +0100 (CET)
Date: Tue, 24 Nov 2026 06:27:20 +0200
From: Igor Velkov <iav@iav.lv>
To: netdev-bot+sashiko@kernel.org
Cc: iav@iav.lv, andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org, linux-pm@vger.kernel.org, maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com, wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev, florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com, shenwei.wang@nxp.com, Haoning.CHENG@cn.bosch.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 4/5] net: phy: run a postponed PHY interrupt handler directly on resume
Message-ID: <179549408701.90856.922626687148@iav.lv>
In-Reply-To: <179548270110.3135.13757603939004535921@kernel.org>
References: <20261123-b4-phylib-mac-pm-irq-v3-v8-4-e9f706e79614@iav.lv> <179548270110.3135.13757603939004535921@kernel.org>
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

> Can phydev->interrupts reliably tell us that the PHY still has its
> interrupt requested at this point?

> Is this read of phydev->interrupts really serialized against the write in
> phy_free_interrupt()?

Agreed on both: some resume callbacks set the bit again, and it shares
a bitfield word. I will gate the rerun on a separate bool that only
phy_request_interrupt() and phy_free_interrupt() write under
irq_pm_lock, in the next version or in a follow-up, and update both
irq_pm_lock comments with it.
