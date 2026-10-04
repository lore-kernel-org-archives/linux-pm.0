Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1C4746B3;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136007; cv=none; b=WCEaCdHw48gedovw6kXvHqxc0V6fP393E19+Q21Y3DrSi3XfSDeR1TQiBqF+9h+cRnBQ+YdSz9AtiUZObIxG6XtO+KesenYbPMup9JqKNvSGFORs0TTMrBKRp1TorwS/pYLsDy5BavEw/rs2GWcie2lWa8wOnDTcSiTuKyIiu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136007; c=relaxed/simple;
	bh=7XTdcCqjivu1BKRkkS+/55Z448JOKrjMxhytpUM6YQ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XLw3+RxE/bKUB/XOaIi/Db+hMmqdjCdDrD5jiojuDoiC75rDDJ7iAwNQYS8JwyURY0qcjY/hXUVkfd686N4WpMB6zXrvLOqCJMCor4+XkgNcPDhzfEJjMOFPDHwk/dBDKox6sr/sPiGK26/ZHM61BgK6K6RWwE4gb/pR+6C0dJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DFA1F00893;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 113F2182ABA; Sun, 04 Oct 2026 19:46:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 "Andrew F. Davis" <afd@ti.com>, Alexey Charkov <alchark@flipper.net>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261002-bq28z620-v1-0-bdcc10d42519@flipper.net>
References: <20261002-bq28z620-v1-0-bdcc10d42519@flipper.net>
Subject: Re: [PATCH 0/2] power: supply: bq27xxx: Add TI BQ28Z620 battery
 gauge
Message-Id: <179113599805.190565.453635655373283924.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 02 Oct 2026 16:02:53 +0400, Alexey Charkov wrote:
> Add BQ28Z620, which is very similar to the already supported BQ28Z610 but
> drops some registers and shifts the data flash layout as a result. This
> means they are not strictly compatible, even though the existing Linux
> driver for BQ28Z610 can drive the BQ28Z620 with no changes, due to it only
> implementing the (unchanged) standard command set.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: bq27xxx: add BQ28Z620
      commit: 5526d100dd4785bb41793fb758defe24e14f61ab
[2/2] power: supply: bq27xxx: add support for BQ28Z620
      commit: 5d32ee3bff8bc943095d04e801e1b45f1c695753

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

