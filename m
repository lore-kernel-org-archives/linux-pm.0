Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB118FDDE;
	Thu,  2 Apr 2026 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115561; cv=none; b=ZJ96Z9tW3VJSne08t2QrW8LZFBHgX+UvhtB8a5mUjFZ9uF5Ex9+Oim7v3MSDshguAe6Dg13HMyPb3x7viCF64Vv/BFHyXp4w4DxoP/TV2UHtas0ZwEQEKxiWZcwkw3LTrmjDtbJ8vji3E6uHe562GA0zQsWTukrLb5zvshmta18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115561; c=relaxed/simple;
	bh=no6QOf/VFhguYHVORKuUHdwtLtBKZ2459unNnteq/hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlZIDIBjF0+2TQpX7bdz9v53oDj9sDx8rrEdGt+xcsuG+R+82fV2Fwfd3nueWgdS5iSY9OUzZqDTdIkMA17OzCbAg/guwq5vs0aVHN+ZMsAJrZQfZbs3gj6xQVabjhriEm+FF2Dml4my3dUvzqwvjrAP0JwkBuCxmfXUNOY2e0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBnzc+PX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBnzc+PX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584F9C2BC9E;
	Thu,  2 Apr 2026 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775115560;
	bh=no6QOf/VFhguYHVORKuUHdwtLtBKZ2459unNnteq/hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBnzc+PXAxhL6UdbS47xiK1BwjKryy20q1Pgr+/C6MN38wbFYU56toFcHxODXn0T7
	 iXlH0O7X2+kz8nzHtc04NSUetwgJPs4pzEKF+SCRaqZABPls9tSs8CFAxYuhEJBSDI
	 n8eQFP5D56x6YNeaHdFKzA/zqvxwpRaKpM/dnvDCBukxZM8diEqyUBXbGbfFNoxpsJ
	 GAFQLmX0QUaLAy0nMAhreIMcrhKk3LVpPLdpe7tOIeXEXxMuA3rYAK+31ioTj3NFIa
	 LbiqVvi9XmsyY0RVB7BE+H8P6nCAzZ3DHjbXa1cE5QZmzrz1o6ng1Djpqf9AiehDH9
	 qDd6ZFdbuqGUA==
Date: Thu, 2 Apr 2026 09:39:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akashdeep Kaur <a-kaur@ti.com>
Cc: praneeth@ti.com, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, d-gole@ti.com, vishalm@ti.com, 
	sebin.francis@ti.com, k-willis@ti.com
Subject: Re: [PATCH v2 2/6] dt-bindings: opp: ti-cpu: Add ti,soc-info property
Message-ID: <20260402-sweet-wise-coyote-138ff8@quoll>
References: <20260401105404.1194717-1-a-kaur@ti.com>
 <20260401105404.1194717-3-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401105404.1194717-3-a-kaur@ti.com>

On Wed, Apr 01, 2026 at 04:24:00PM +0530, Akashdeep Kaur wrote:
> Add ti,soc-info property to allow OPP tables to reference the SoC info
> device (chipid) for establishing device link dependencies.
> 
> This is used on K3 SoCs (AM625, AM62A7, AM62L3, AM62P5) to ensure proper
> probe ordering between ti-cpufreq and k3-socinfo drivers. The ti-cpufreq

Nope, sorry, DT purpose is not to perform probe ordering.

If I change Linux to load k3-socinfo before ti-cpufreq, then the binding
becomes invalid?

Not a DT property, drop.

Best regards,
Krzysztof

