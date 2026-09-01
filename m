Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89A41B8F8;
	Tue,  1 Sep 2026 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228615; cv=none; b=mG0tJ9KEv1s8Bxu6cU4I7Tk7Vea0rE6lt7ojiS6LmRAjp1a3Mp+ECeDxE6R8e065RImis28tHkU8/5k2pxl4HgqZYrxs9Z0HGX6EAMwVHCnaqTNZQTaOJLTJMOklK1b+b2LbpGbfHF85pWvLdO10BS+AXfhdbjga+1JAPiF+QTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228615; c=relaxed/simple;
	bh=KfsGfxoXO65tdZ2tvFzZST54gjFK+k/N9O+vHkUseTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+XORCxPunjNlfaPANbD82XbXhuW70qYnFWeyucpwfIirHiSDWtlI87CxJ8b2beKJkzlHhSfyFUZVg6LjrZwXwlAWgIubZ28fJ4SKpX3fHNf9VDKjRcEF+/AgDS7ZTqtsWitK01gY1PzTDCgKtRN8MndbGEn5Fm2LBubupTr2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSXjZL9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSXjZL9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5011F00A3E;
	Tue,  1 Sep 2026 02:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788228597;
	bh=dXzdTvnD6ykXZHyNmAvqjM5i4/yFIOYUmzQ7w/KPzwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lSXjZL9gNbSRf/03PROvT8wqKjpGVSSfIXgkx4NFCJI6uhs7/iI9H6Z+wLcAPk/Dr
	 1ghlot3266jlOf6KcTtTsBwZR4qm6HdXjGDodZbo61ZQ7lhgiVZ4iN8i35Ch/Ehju+
	 VKBrzM2jIbbrvqmM4SyQy3peUaJW9gE6LZJp4yz3/tUw/VZvJ19nZ2YsI/vaeUjHVp
	 YfM0uoh45y8o0wlRvUXHLloJ7aX/bNJmUkhZfmASDICNS0eX5wXlZ8FOpxW7KRtMOf
	 1IcCR37p7oofrjs5F6VbaBUStYehE2b+hb+zSK/uP4c9L6gjPM9mIub8wogDPavdIa
	 JdSN0TCxVSk0w==
From: Bjorn Andersson <andersson@kernel.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v6 00/13] Add initial support for Qualcomm SM7250 SoC
Date: Mon, 31 Aug 2026 21:09:32 -0500
Message-ID: <178822856275.1835959.3848131517961346933.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Aug 2026 15:01:43 +0000, Sreeshankar K wrote:
> This patchset introduces foundational upstream support for the Qualcomm SM7250
> SoC (internally codenamed Lito).
> 
> SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> and 6x Silver Cortex-A55) and Adreno 620 GPU.
> 
> [...]

Applied, thanks!

[09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs
        commit: 1c8fe8863780705aba77893fade65f728e82b67a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
