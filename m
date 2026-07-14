Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341853DDDB8;
	Tue, 14 Jul 2026 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784068063; cv=none; b=sD/krdvoG9beZ8wZZgIr2U4dM9EA05IWq6EHGR96J3NbaVlPCT2QbAUTB3nftgJGMNhQYyXCzLJD+GNbYA3+9OcMPvsrwB6V5o21C3KPceiz9k+lr9igXuBk9oTu+fSvshdE8sml/ISYRp9HsGDxY7m4ug1E66JZ/LNSTkKx/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784068063; c=relaxed/simple;
	bh=Uvef7YKJUXYqCm5aExFKb8Tw7REPmDgnpnOqM6wlPnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7by0ielMjESMvRcUh/5niYz08kLj1FLIEpwv/0eHy5tT2Fsre8WokGgWzl4psXvFthvAdHk0qCzP8zXJOzZ+TDwNJk9VeCF3SeI1DjecnI1NXF1w5BS4WtdtmpaJcs1fCqZxAFY+34ZXfot+58gSQFvwt/HGCHHato8f9XzQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUlIvnrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUlIvnrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC111F000E9;
	Tue, 14 Jul 2026 22:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784068061;
	bh=GURWIME1ZSYy0zDc3cKEdN2A+uXckH8Iygm5TS+0l/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bUlIvnrt1ZCAaflYzXFQ4qx6L0rgJvcIBRTTYhrloEUsm7KAxg7vg6fNsmjOsXYfd
	 To5UtCsRhKbn5jo4aEx4n15aky2h2AVfkgTorkYZPjzrGzP+d+tSSTXqFu96BlS2Ky
	 pq0VIGFxBMEUfH3Q4ZTTjHu4rAG8P1ZHkJ/INbjXsmFTF7tAthTHmhEeoRAarD9ane
	 jE7+tpkTWUA8oIRs1orW0TTNSkmeWfe9IDefRL20nfeaVLPXYqAm59v5YAsaMkcZzu
	 NC/TJoSsE5LtsfiJHgRyYbG+cTmFbUtcbIEiZQmcIRw6IbwRRz8y53ucLehiaXP6TA
	 c66oDRnvcP/ng==
Date: Tue, 14 Jul 2026 17:27:40 -0500
From: Rob Herring <robh@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Eliza
 BWMONs compatible
Message-ID: <20260714222740.GA3177936-robh@kernel.org>
References: <20260708-bindings-llcc-bwmon-eliza-v1-1-3c7dbcbae87a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-bindings-llcc-bwmon-eliza-v1-1-3c7dbcbae87a@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 02:57:20PM +0300, Abel Vesa wrote:
> Document Eliza BWMONs which has a BWMONv4 for CPU-LLCC and a BWMONv5 for
> DDR-LLCC paths, same as SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Applied, but this should have gone with the .dts using it.

Rob
