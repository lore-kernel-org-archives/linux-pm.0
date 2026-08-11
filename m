Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629733556D;
	Tue, 11 Aug 2026 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470269; cv=none; b=L5gOyueDmrnO9G+k3NxPCOUxMorYv8GjnYGTgso6euX/erR4BbguXw4OVmLu8gGPMsTzuzWbLJj2Ah11mzjJtuWKuIWlKaCblu0O/WFMS0lEAJe6SOHEn+nYGPTJiAxT1y6KnUlM2eOxSVHjIJbmIpvVpJirjzTQeBT75bwebmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470269; c=relaxed/simple;
	bh=Wf68rvcntKfFUxSZ8JNK0ww5GMYZIpguYK3+BuNbzyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4vUxyacX0EecdSeE2jLEvgFmgKM7N3FvutBG8hwnHUfOPM+36zZywIWlpLL5q3iOHamdlj7MifhFDJpKLJVrWaHRq5CKwoG1s5+UKBXqDmuUO9+TN7ZyTlOvgzYEA+KYP5iPF7xVswwL+fEOvC0+IZezQwCicvgsNv6mC5nVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MblLye+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MblLye+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB7E1F00A3A;
	Tue, 11 Aug 2026 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470268;
	bh=cdvFOT76fT3/wsaA52TRbulm6sYGo3o2Eg5wrAnV4VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MblLye+a5sfCUTxTv14mL5SvnmR4TLdXPDXrKxEMSt/lGXGlUoo4zlyrL8DzS0Uqv
	 ywtcnQ6nvwy4GM2JzhEv5/v/fxOPypqGMevzf7ZLoIYVi2r/8h53Rqh0A4NUjDm5rv
	 OvaIJlIouFNzfz4PDSah59EeZJ8/O4eZzT5lZTtNYav/2jNK5WYnSg+BoJmKP2qslj
	 F9AZsaSQQQ4SUAGVSzVQsN0CQQFsmvUzbdQcx2EQidMzIFGohci6lnoiuKvvTDltLw
	 i/9h7BNxwjQqBZJmP2LIiKbSRN4Sf1Wy3BPNkW4Lu6LeIg7MAjLgBKnliXnnmP+ud8
	 AMSTzKrZlKsZQ==
Date: Tue, 11 Aug 2026 12:44:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eduardo Valentin <edubezval@gmail.com>, goledhruva@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>, daniel.baluta@gmail.com,
	simona.toaca@nxp.com, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>, m-chawdhry@ti.com,
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: thermal: ti,omap-bandgap: Convert to DT
 schema
Message-ID: <178647026659.2708833.1011801377452880804.robh@kernel.org>
References: <20260811-ti-bandgap-v2-1-6fec2a71c394@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-ti-bandgap-v2-1-6fec2a71c394@gmail.com>


On Tue, 11 Aug 2026 00:19:28 +0530, Bhargav Joshi wrote:
> Convert Texas Instruments OMAP SCM bandgap from legacy text to DT schema
> 
> Add "ti,dra752-bandgap" to compatible which was missing in text binding
> but used and matched by same driver.
> 
> Document the "#thermal-sensor-cells" property, which was missing from
> the original text binding but is required in practice by all in-tree
> users via the common thermal-sensor.yaml binding.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
> Changes in v2:
> - Dropped unnecessary interrupts in if/then block
> - Dropped extra examples
> - Link to v1: https://lore.kernel.org/r/20260731-ti-bandgap-v1-1-aeee6a658520@gmail.com
> ---
>  .../bindings/thermal/ti,omap-bandgap.yaml          | 177 +++++++++++++++++++++
>  .../devicetree/bindings/thermal/ti_soc_thermal.txt |  88 ----------
>  2 files changed, 177 insertions(+), 88 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

