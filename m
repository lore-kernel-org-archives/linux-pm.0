Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D183470EB5;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136002; cv=none; b=Sjricp5nfCqVGElURSjtHnR8/NLiY0/pJHmJ7QAse6srYXUAQT0KfZxc1wbELdWjDbJwlCWAQ9JL0vfptweUPBrnIFyKYWNCXEOnm3dG7C2qrodDVZypYeK6FozNzZcRJyNKXm4BqBkwuAW6wqP8nTlIHAXth/i8nqJx7bLkTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136002; c=relaxed/simple;
	bh=63SluiMu9JFttwjHv7+TrLaLgKhyhclAuU+MGDN6RKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SSMYaElqk8RLmu6ummvSW/ciFi7DOgyQimG/dq3NliLALKAKJsoYEmXoRm5yF+6fsi3NfwkSdT5pOVx0Qgosag1uija2nk7cVEm4xayejfyCW5n256BhwLjbulSzAUZ5EfPPt2U2MAhX4pYaXAAiwxdLq0euOw3nlAejouKPNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EB81F000FF;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D7EC9180B21; Sun, 04 Oct 2026 19:46:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260925-ab8500-charger-dt-v3-0-f80b8d295e2d@kernel.org>
References: <20260925-ab8500-charger-dt-v3-0-f80b8d295e2d@kernel.org>
Subject: Re: (subset) [PATCH v3 0/2] power: supply: Correct AB8505 charger
 device tree
Message-Id: <179113599787.190565.16764785848031450003.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 25 Sep 2026 10:59:23 +0200, Linus Walleij wrote:
> AB8505 retains the USB charger from AB8500 but omits the separate main
> charger block. Its charger node consequently has nine valid interrupts,
> not the fourteen interrupts used by AB8500.
> 
> Adjust the binding to describe the variant-specific interrupt sets and
> remove the five nonexistent main-charger interrupts from the AB8505
> device tree. The binding update also limits the autopower_cfg description
> to AB8500, since the corresponding AB8505 register bit is reserved.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: ab8500: Add AB8505 charger
      commit: 80d28539c1f9baab72210501729d67e3d9daa4b8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

