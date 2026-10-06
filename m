Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439362931FF;
	Tue,  6 Oct 2026 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278145; cv=none; b=BzwxcxBqbjr4gpi1wLbBO/sWR/glSQUwswGbYfQ8x/nZ0AyNudYZ1If5OQHo57SZmP5nJRN7PVZciwTnKcezbdqZHxx4YVi58YE0vXxHvCnFPXxDgeBGfS/7FsnmVxfSdah9rLSDFF/Qs90pHkvPxVCkdyMRF+A0mGqqMAA+b64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278145; c=relaxed/simple;
	bh=IC9jYlGcN33Cz769CDyMMeJpbLA96yr5Z7uTADJtW4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr1cPrqp2SFsXCStP9gUFfwho/KdR7PiLNinJ17NS+tki2wYb8fpgyHutdTabXdhASx4WI+bB6pm05xgrzTQNGuoeot6dIdbiSRpSs/dMntqpqgzQSw/xQU/qW8vVPDsWsNayTLEBaBwMaV/4mbxwZ8zXvlvYGsoejV93X3JNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXgcVwCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXgcVwCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490F91F000FF;
	Tue,  6 Oct 2026 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278142;
	bh=oavwmkQ4ETGA4dUaKiMnunlWg5wtQHH0vwHuNn7pQzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RXgcVwCPFtY9GNzxCb3FICtfCsJV9C9l6rKiqQ0Bc+1M2jltIGUAMJ0x/DqJSXvW0
	 v8FShLZ5922TcznQ0Md4U/tHTw425vZJuEoycFwzptAnSnYjbYFiofxG3Ad7fsm5vb
	 AGwvzbL2a30If51RXV/AJx5Qozn9Hhsxa7Eyu6WZWhk2H2HYZCVZ0club8x1u8p1Xc
	 1VLCVUp6IlIfJT2EB14SgxCWf61VVG1nvZ2n8/DRZPI0MDagGXB3AoV1UAMrPxi+Sn
	 XsUwTnGteccjeQJOOrinUydQUF4o63Cvyw5SgxP0iL7fbgfqUQVW6Fyr80RH2/4Q+Y
	 1Av9r/geeNqPw==
Date: Tue, 6 Oct 2026 10:15:38 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: Add support for system-suspend-only states
Message-ID: <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>

On Mon, Oct 05, 2026 at 08:59:43PM +0530, Maulik Shah wrote:
> Some domain idle states require system-wide coordination and should not be
> selected during regular CPU idle. However those states remain valid for
> system-wide suspend like s2idle.
> 
> Add a per-state system_state boolean and populate it from the system-state
> property. Make the genpd governor skip these states during CPU idle. Leave
> the system wide suspend path unchanged so s2idle can select them.
> 

Instead of this I am thinking if we can QoS cpu latency setting and block
system level states normally. Since s2idle is user driven, it should be
controllable via user-space and we don't have to define bindings again
if systems that use platform-coordinated needs this too. They may not
use domain-idle-states.

-- 
Regards,
Sudeep
