Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59249CF43;
	Thu, 24 Sep 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264079; cv=none; b=ZfV7sxnbxOFamCk0ljhon8z9QNvy9zGI4xQbuj06hmze3+pkM/rjn4lZI6n1rQb94xCN7TjsYAqVSY8ytzRtXDWe5QEYcvwDrmBZ6ULY0hxcOneIWPcGr7guCTO9KO1/B8bYgIrgwm1dtaxracfb8KLSLstnWHof2EseFSRvqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264079; c=relaxed/simple;
	bh=lm2frTX4PmhGYZEhN3/Vdc73jPbQF8yV+Z3T+AHyZyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSR0v5h9bsvdvONxwYZF7yGet6xWlmjFyOgMFC80NtH4hGEKWSVQ64zIHfy6seu4l3i6UWVeMhew2RmCvrlk7x8ykJHSATFbNwdr74Oeg4qujy/2LJQti7FOqZZ//vJlH8TyP5xeTi1YflzLgiBS6trBTHNC0rPhS67+p3OStnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxc1vMvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxc1vMvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705491F000FF;
	Thu, 24 Sep 2026 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264077;
	bh=W/Ljat49QaUj4eL8f4hzZRQRMOMmyTOMPP2vNAZzWmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oxc1vMvw+VtiJW7aIeXGqs+p23tQHLToK5Rh1ixS12xZIfTfwD7B/dIdeSrQvC5D9
	 el7EjZPTbBVCg305SzIcrCzGNKOLDrSkKalBhcY52zbFsqapiBmZIfiXgHfEyjph0Z
	 yY9xgZMVDw0prRfwFB/FvZsC3X/x8Rq4WT9boB1JTbDaXJjOh6udrFIgjtjz2m7K8r
	 UF+4zZA2wi6/b8MQMRIz5engjCZZCs0hYY1VTiDVCRc90H7156PG5ayw2DZUhn/a8f
	 HVWt34/7+pj8fdkFx0emyp0lThMtvey0AWWd5bF1fwCiMbSBv5s0JAoF6ffgD6ZHCP
	 YrlTjg3mbYLWA==
Date: Thu, 24 Sep 2026 10:34:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-pm@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: airoha: Use one thermal sensor
 cell for AN7583
Message-ID: <179026407528.231290.11921306500711802178.robh@kernel.org>
References: <20260915191131.25214-1-sochnev.v.74@gmail.com>
 <20260915191131.25214-4-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915191131.25214-4-sochnev.v.74@gmail.com>


On Tue, 15 Sep 2026 20:11:30 +0100, Vitaliy Sochnev wrote:
> AN7583 has three temperature sensors behind the chip SCU: bandgap, GbE
> and CPU. With no cells a thermal zone can only refer to the bandgap
> sensor.
> 
> Use one cell to select the sensor. The AN7583 compatible is new in
> 7.3-rc1 and no device tree uses the property yet.
> 
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---
>  .../devicetree/bindings/arm/airoha,en7581-chip-scu.yaml        | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

