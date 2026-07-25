Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4B625;
	Sat, 25 Jul 2026 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941322; cv=none; b=u+MTXr7kmX3f1Tl0mITqa/HoBUAaBcsiRUSFKwKwZvNx6C3v4E1C/4KN55Pe2qIkua4OFQc3C5F5R0M6GB6chEpnq5AWKpwzzwK/OeKTno2ROrBkjiYa9/y38bWAe2VYmEfTY+tr2bGoVH3/64a1Frj3nbM0F0oJaoxDxqeZUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941322; c=relaxed/simple;
	bh=WQVuY/xHb9UemvXKHlOmW1cciHm15eKxer7SGv8pDsg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dSfLabOobBVka1URplU0KeAqE0oUqvfjBweQ6HGgkE+AwEVQYhJgO6kRSt23mTqeXgBcAjUI28vRN0aQ30rLeotcJAqo0cWeFSsroPHuLvPBj1Pl5IxXIERZmaJvmSn4uQ2c4yOiUhciZy8aDvAS0Wxn9bOkSYbsq7MLZ/uYkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB3D1F000E9;
	Sat, 25 Jul 2026 01:02:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 78EC3181F17; Sat, 25 Jul 2026 03:01:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <cover.1782683551.git.waqar.hameed@axis.com>
References: <cover.1782683551.git.waqar.hameed@axis.com>
Subject: Re: [PATCH v3 0/2] Add driver for TI BQ25630 charger
Message-Id: <178494131947.716677.16555003920225344121.b4-ty@collabora.com>
Date: Sat, 25 Jul 2026 03:01:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 29 Jun 2026 00:01:18 +0200, Waqar Hameed wrote:
> This patch series contains a fully working driver for the basic
> functionality for the new TI BQ25630 charger (see datasheet [1]). The
> other "advanced" functionalities such as USB OTG, BATFET control and
> liquid detection, will be handled in separate patches (after necessary
> framework changes) according to the design discussions in the first RFC
> version.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: Add TI BQ25630 charger
      commit: 7380075135496df3b07a61c002928af0582b2bf6
[2/2] power: supply: Add driver for TI BQ25630 charger
      commit: 81a10126cb33d553e9b08a5c09b0cb9835cab2d7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

