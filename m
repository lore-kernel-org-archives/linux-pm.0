Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C93B7B8C;
	Wed,  9 Sep 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988991; cv=none; b=F73eW2KQp3QYLo+a/pBt1uJDq++2RFcYAHNTT9NA+Lzhz8MpGwYaFP5qHifagYI2assEfzKjWgcYjBquIglOWal+vTZ6QNCt0SeQsC1Hf2JjOXClqya0DSy2J4Bzg326BgIdwcpb7lrqolUOo48wwY4iTXIp8IIjfSsJye0tE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988991; c=relaxed/simple;
	bh=WgF1g+JZqEuJhoap5lcKQUreVNG/xmgwflmTiV0SF+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZvKDLt4nVZF5dvjZr7k1AuSsUf9fRCO6m5KDCiVZVyf3htJNmst9ITwMZi8CoG8/GQmpd4OfId8KVVE3GR+paLePgCvOjA/vYdRREd+FxgtcAl9uvDgtsghbTgr10D75nVOVK0K+XopbRIN/1g6mKqPauiq/yOBeIdf8YWgKFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681421F000FF;
	Wed,  9 Sep 2026 21:23:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id DC799183378; Wed, 09 Sep 2026 23:23:05 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 "Andrew F. Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, 
 Dan Murphy <dmurphy@ti.com>, Henrik Grimler <henrik.grimler@axis.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
References: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
Subject: Re: [PATCH v2 0/3] power: supply: bq27xxx: add bq27z746
Message-Id: <178898898587.889628.12427531193512447162.b4-ty@b4>
Date: Wed, 09 Sep 2026 23:23:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 18 Aug 2026 11:48:19 +0200, Henrik Grimler wrote:
> bq27z746 is similar to bq27z561 but with additional protection
> functionality. The standard register set is identical, but the
> extended registers accessed through AltManufacturerAccess has
> differences.
> 
> While working on the series I also noticed that bq27z561 supports
> interrupts, but the dt binding marks it as unsupported. Fix while at
> it.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: power: bq27xxx: bq27z561: allow interrupts property
      commit: b7f6f24bdd4a089fd33b7a2b13ff291d89b86b60
[2/3] dt-bindings: power: bq27xxx: document bq27z746
      commit: 0105a07b43a912392f56e3ad3255f907df0c17ce
[3/3] power: supply: bq27xxx: add support for bq27z746
      commit: 608f8932f9da62720c1dd181f0ca9f9d06372d89

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

