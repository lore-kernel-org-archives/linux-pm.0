Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3113302CD5;
	Sun, 18 Oct 2026 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792318903; cv=none; b=ail9dJ1tCnmzDRuWe/E3dUuBL2JHjnNMOSdxBu4qFuB1pgyWSncoHwcJvVti48+NJxAC0hsj1Y0BkW0ns3pslDBJtTsDL++AWL2vSHgQu5DBzmSkSqQa3aQuC0IpsuPCjfZNxev+zHJvyLGGyrE64fOVCG1TB0iaQHX3RlHKmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792318903; c=relaxed/simple;
	bh=n11Z132RAyMNmhgNlOOeOmT/DFQ/gvLBuBvqrhzbyE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oRMEDyJV/LMnt40P5ldf2CFViNWC9pqPE/5/hbZ1feZ7eG2cwByOoLBQm78JsNtzrX3kA4Oj8W98CLWaWS34vh5xs6oEVrkvarTaPYi06GjggssID5ml68sMblet1fv97MpGxRFEe/RtOeZvMWZdcf9ZKfDz8Tm9V5Ic4FU1Ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAF91F000C4;
	Sun, 18 Oct 2026 10:21:42 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 91B8118026F; Sun, 18 Oct 2026 12:21:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Igor Velkov <iav@iav.lv>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261018-gpio-charger-offline-v2-1-482795f9e27c@iav.lv>
References: <20261018-gpio-charger-offline-v2-1-482795f9e27c@iav.lv>
Subject: Re: [PATCH v2] power: supply: gpio-charger: Report discharging
 without input power
Message-Id: <179231890057.130998.16480203927596950957.b4-ty@b4>
Date: Sun, 18 Oct 2026 12:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sun, 18 Oct 2026 03:57:53 +0000, Igor Velkov wrote:
> The status property follows only the charge-status GPIO. Without input
> power a charger such as the BQ24133 releases its open-drain STAT pin,
> and depending on the board the GPIO then reads as charging.
> 
> On Kobol Helios64 the board runs from its battery after a mains loss,
> and the charger reports online 0 with status "Charging".
> 
> [...]

Applied, thanks!

[1/1] power: supply: gpio-charger: Report discharging without input power
      commit: f0f400459bf6a037e70768de623fff3f8920b8bb

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

