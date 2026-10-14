Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C263AB27B;
	Wed, 14 Oct 2026 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990934; cv=none; b=K0Q8K8EZtceYKIrc6WBtJyb1qlW1QEONgjUDsNKQaJWTlSsrv9QKRpVdbJEOqam6PBs2bt25ZB0zIxzVRUimcDSpjnbDqSdUHY/3EqjzUF0Er2ZmwbkR0OA+zNtMx1mF/xb9CrACYxRyFPQin0Bb2XJp8OEx5eHfCxsnwDjc/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990934; c=relaxed/simple;
	bh=agyryjZEzK0M2hQOByp3o2vRDdw+ErOUT6ZTZ0Nj16U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YgTKdTLyan8tFjkzM2FEDbLBqu0n/i+n8QhqITybCe1RsCqc8G62zD+/RDyNenb8Pwm5TB9AjzuQ8hkdHhh/Y3pap1ArwtfZD0ModK7aSEzUwGdJD2CmoSWZ+3yGxYlo8Od9scyNKLmXTHSVjxR+6PDQnNE6p6srgX2nPauBC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T60oS71/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T60oS71/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1C71F000C4;
	Wed, 14 Oct 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990933;
	bh=N5peGRE7JeLBURqgzGuy+k2qGL/GVit3+SF1nIv/4lc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=T60oS71/Ht1wcXsUw1LVY99TOkoYx847NJ87c4mHCcRFlwnqaAEffehrwK5EOuX9B
	 X9ImlNi1g414Oesf8LzSRtqdoTj1GMp0kc/x6/CL9eBjhtBilHpyvCE2WsDWuyycXw
	 GYglHtSwJerJJnusriLEj54SUSG3few8rwRcogxo9v5K7NEf0HhUxmi05Abdqhu3yV
	 QABEqxOVMSoh9MGxEc8R/mHbuYedZBaE09v+sI9H/Ku3Pqfg6VVC6TB32LIqpSpGHy
	 +aLTirQYPiIa/Pv5j8JnsFH4CeEF4J/etU6rPtkpxF3EMqbXmr//jiOexq8jROnEsg
	 ETRBGF1o+H52Q==
From: Lee Jones <lee@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20260921232649.3132592-1-robh@kernel.org>
References: <20260921232649.3132592-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: Add MT6397 sound DAI cells
Message-Id: <179199093070.1189352.17803579225122726032.b4-ty@b4>
Date: Wed, 14 Oct 2026 16:15:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 21 Sep 2026 18:26:48 -0500, Rob Herring (Arm) wrote:
> Document the one sound DAI cell provided by MT6397 PMIC nodes.

Applied, thanks!

[1/1] dt-bindings: mfd: Add MT6397 sound DAI cells
      commit: 198f3bfc6658c2f1a75cf0e9b03231242cc711cf

--
Lee Jones [李琼斯]

