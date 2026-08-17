Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D826FD97;
	Mon, 17 Aug 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953010; cv=none; b=nOXdbEkXjTqtOFacihHBPnyWyTvsowCu4AXhYdyK3/wiPZt2SAvPlQmDYVwHxIxv6S+FBjJM+PQtfZCzcBycT4/79zVhjCW5lk0XI7AH12jlh/zdEh8vQ73TeoHem9wCeOasDOimHSXfUaPmuXXVXHOQf2gznPfvXDOApfoSkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953010; c=relaxed/simple;
	bh=q47hcBB+hbDO7x10kT/l7QAB9di5nqZi7e7McBeUi5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFD/o57nZDjV0bzUrfC0VRU4rqqR1GpH4qVh64DSIYpctN6lgEH6JJPEyC9VKdhKDiSPwfEdh/yeuIgOnHGG/Eh6dWlbx/eJdcz4AGwRZJFwKQU1AKHRAnc3tOV/rv+H8xJDv9I+Y72Dific3B9NimdTxr7tUvNOcTphaBUG2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp7WQpdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp7WQpdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CE11F000E9;
	Mon, 17 Aug 2026 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786953009;
	bh=q47hcBB+hbDO7x10kT/l7QAB9di5nqZi7e7McBeUi5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dp7WQpdK1wqDxPaTK6iSGsexYfhwXsvpb4QzJ3FcBjkUppfyup+bIRcsfQ/BpEEhd
	 Aktsxg98TupwJ/W4HdzNLZwzgFHtjCrDAxWIfE06nbckwAH1tqRP3vu1OTOM7YvxWU
	 A+uF6AB1Wyf/2jzI1KONr+QvlXoOl6O2n64aNBa9AsCxetPRMqvJ35eV1V5mhimc5n
	 ingt9HY+Pa9JA8k0Kahghd0s7uK/mjMqOzNHdvo8rryWMEcFPQVTuiEZ+rF1iuo2hd
	 q6qUI1hIytTavsUOiWEebUaQlW3urpDtqinv65KHt1poLB0cMoy3O1ybQD55B5STks
	 UTC9gSDlAv6nA==
Date: Mon, 17 Aug 2026 09:50:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Henrik Grimler <henrik.grimler@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, 
	Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	kernel@axis.com
Subject: Re: [PATCH 1/5] dt-bindings: power: bq27xxx: document bq27z746
Message-ID: <20260817-talented-brave-clam-f5e6e6@quoll>
References: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
 <20260811-bq27z746-v1-1-3a4fa38205cc@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811-bq27z746-v1-1-3a4fa38205cc@axis.com>

On Tue, Aug 11, 2026 at 01:47:43PM +0200, Henrik Grimler wrote:
> Add compatible for Texas Instruments bq27z746 fuel gauge, which is
> similar to its sibling bqz27561, but with more protection
> functionality.

"More" means superset? Driver code says it is compatible, so this has to
be explained (explicitly requested in writing bindings btw).

Best regards,
Krzysztof

