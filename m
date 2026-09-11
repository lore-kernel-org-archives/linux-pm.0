Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5523F54CB;
	Fri, 11 Sep 2026 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108436; cv=none; b=iH8AaCGVNCdN097hfS0jeO+tlRt9UnbB975BzxkTPcRtpVzOD7Gtuz7d1gJZyPilCtmt+UXHwyxWGPm+PWJ3JBHGoCRl4aSzGPMblYMQvnRYZd49bGsOuf3J1RQ2jhjyVrRAmW1l5dXzwxWIlLKwnY+S2C7kotithqxWyAgpnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108436; c=relaxed/simple;
	bh=HmXNcA1YAnZLx3RPO+XZdE0dPg1yJCRKOMe6ArOea/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvFrTVmWD5tiIllzQ2R+Vsufe5r3osIshYJ/ln7u3tgwJzr9AyK48bvfZl4/qblUS34ImD/q21AgUYcYrQfxRYjncHyHgn1A5gUdNaiW07myvA4LcdUYRSIhfY0MDLTLjvVHh5wNlzQOyM3jm5P8jxF+VQe8s+sFWWyw7f+QuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/g3ckjn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/g3ckjn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3056C2BCFF;
	Fri, 11 Sep 2026 06:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789108433;
	bh=HmXNcA1YAnZLx3RPO+XZdE0dPg1yJCRKOMe6ArOea/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r/g3ckjnar/MDHt+ZqIrsuDZhWgjyXrV636yYh8ZfnFuQ+xjkGqFAf6U4iTCJKyBp
	 qBqXav3n+bojCQgciefQfjjHABg5iN/4Qpx+IzcXBdXjCO0+eKw2RXijySd+FG0mUm
	 iBp1xc9NmQJkAG4APYT4+YtVXjgMdFRIqjPA04Ruj3w1YvBMVd4n6OU+pOgCrJ30vZ
	 NAaZhBJHfrQxo0/N5fUChSS81LZrKwAVdKgVPU5NYQQ3p724nXvaGftFv4vrVT5m5/
	 gSmGy7QHLVRaoC4C9gtKfUTLWjkU5orkgB4nfdiFsm1euRcZOuU72qu8KNA9z94VpV
	 sXlEr9N2gAlmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BD8C88E50;
	Fri, 11 Sep 2026 06:33:53 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Fri, 11 Sep 2026 09:33:01 +0300
Subject: [PATCH v4 3/3] ARM: dts: mediatek: mt6323: add EFUSE support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-mt6323-nvmem-v4-3-626dd17531dc@protonmail.com>
References: <20260911-mt6323-nvmem-v4-0-626dd17531dc@protonmail.com>
In-Reply-To: <20260911-mt6323-nvmem-v4-0-626dd17531dc@protonmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789108431; l=757;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=8n+fwUrTUb93L9BoRmKvxttEJdPZMxj+kOtwP+JsFd4=;
 b=CTzhpfAQ2JrxbDwtDeNSwlTRehA3OG/8+Wj29z/uu4TxNqsytlxToaaU8G60P12k1QN0PH0nW
 fFhYnVZ8CFACnGdt3jae10uvRf8zfys39SxRrT+lwb1fuar3urSgvns
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add the devicetree node for the mt6323 efuse.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6323.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6323.dtsi b/arch/arm/boot/dts/mediatek/mt6323.dtsi
index c070f4b0936c..c2d08d29cee7 100644
--- a/arch/arm/boot/dts/mediatek/mt6323.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6323.dtsi
@@ -19,6 +19,10 @@ mt6323_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
+		efuse {
+			compatible = "mediatek,mt6323-efuse";
+		};
+
 		mt6323_leds: leds {
 			compatible = "mediatek,mt6323-led";
 			#address-cells = <1>;

-- 
2.55.0


