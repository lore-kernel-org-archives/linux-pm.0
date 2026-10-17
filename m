Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877431E834;
	Sat, 17 Oct 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274196; cv=none; b=AILVqwElwIsFxdHg0XMJsuf4f0Pcp1p6zmIaCZFbF6DXGwW7Y0nerZ4PDFnuI6Wdsp+29x8ZE4wf3yEloNmVJ/HPjSSKJGVyi26sgf5uWh3/13eSuimVcXqv4P0LibiMQEpKsEmBRtF/YkQVOUk57b4khgiun8KxszDD2/gVITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274196; c=relaxed/simple;
	bh=8KVAiELWLxpH9VcBZoQs4409lGF/WHmQaK/nW3rKHJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R1hs2Vi2TReHF0+ViaceNqTl9sPVyUkS6z5YwYsvzMEWLbruvBZRIWpirhcepEEEYOS0MBmHZwud98BVlRbEIyk5TpkFegpEIF/5O8WUVZbrpORa7R640KsfeKQETn1QS8F5ZVS8mm4wv2BksimBZd9DmVC+ifihz67AoL25YIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D661E1F000C6;
	Sat, 17 Oct 2026 21:56:34 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 59D7D182317; Sat, 17 Oct 2026 23:56:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 phucduc.bui@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261009112429.33318-1-phucduc.bui@gmail.com>
References: <20261009112429.33318-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH] power: supply: generic-adc-battery: Propagate charged
 GPIO errors
Message-Id: <179227419334.76434.9019120802183204132.b4-ty@b4>
Date: Sat, 17 Oct 2026 23:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 09 Oct 2026 18:24:29 +0700, phucduc.bui@gmail.com wrote:
> devm_gpiod_get_optional() may return an error pointer such as
> -EPROBE_DEFER, but gab_probe() only checks for NULL. The error
> pointer is then passed to gpiod_to_irq() and the original error,
> including -EPROBE_DEFER, is lost.
> 
> Check the return value and propagate errors from the charged GPIO lookup.
> 
> [...]

Applied, thanks!

[1/1] power: supply: generic-adc-battery: Propagate charged GPIO errors
      commit: 36b0abe904ac9cbdce6161d9c7c0bcac963bb3fe

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

