Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DB37A839;
	Wed, 19 Aug 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133141; cv=none; b=aDM1QRMm/f9b6o9NVKlIOJ6fqFFFASweYBn2Hxt6EXH3otbXlzrQ4oIZHVs3vESTFdfYQVvOHHnHYjE0m0J9qcAfhZk1RUzCNp3T6RJ/0VCwwUdHasHoH/Oikfc1LXdZv6hIKgjfGgbulI3DNuGiup4ggAsHJ57mVunY03K+3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133141; c=relaxed/simple;
	bh=0Iuwhyf2mtHErp0gsHJMOgTCZUllNcHr3PSGJe29acc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt7eqZCYvd8CyUuJXB1Q4GyyswzxDZsxkjfoPhMpJDN1fALzAzXxO7JqWYzocpEueQNjOmmgUCyGmVwj/531gDeJDlqm8b6TGfweFUob/HACe4hADZTQjYGoKGbbY52lLujjWjPIWJWm7liayT5+uSrD0xOWVLKkyLO430vjOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi6F00zQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi6F00zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F299C1F000E9;
	Wed, 19 Aug 2026 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787133139;
	bh=htmKr8wrzhOuksy0WSYGeTFilrl0ymuvoTGQwdDcFJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fi6F00zQi+bhkN5m5k+uQ+b+gsurGvwSkEdNhgIRrIBJw/FbkVQ689JV7e+tHpsY8
	 wnh9WHpwaSAe0UcManfIjxW2q7CZZZiQINw3Bb1MZ6+e6cyIDv92UOwwtMOtVmNw2/
	 IPf+Q7PxE6LbXHoJcNgeW4YeAWAAHKUWoXep4UUUW5XPLTN/6nyCpkx/hgFVAAnn0J
	 ayEUHF6wf7ST0g56Q4kwEu23jY1vSHEZcw0BITithCqk2Kmi1jQTAptGoKuLQJdihy
	 PFnMcaQG+2uc3XvCBXdYXuDro7gEsI5Y8hiCElIJjSiON9PcyGa0WLN+Seu4vyVts9
	 Fj/ooktBK+OnQ==
Date: Wed, 19 Aug 2026 11:52:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Henrik Grimler <henrik.grimler@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, 
	Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	kernel@axis.com
Subject: Re: [PATCH v2 2/3] dt-bindings: power: bq27xxx: document bq27z746
Message-ID: <20260819-amiable-outrageous-sturgeon-98e7a7@quoll>
References: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
 <20260818-bq27z746-v2-2-0371e206665f@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818-bq27z746-v2-2-0371e206665f@axis.com>

On Tue, Aug 18, 2026 at 11:48:21AM +0200, Henrik Grimler wrote:
> Add compatible for Texas Instruments bq27z746 fuel gauge, which is
> similar to its sibling bq27z561. Unlike bq27z561, bq27z746 includes
> some protection logic and can drive external MOSFETs. The register map
> is a subset of the one found in bq27z561, with bq27z561 having six
> extra registers at the end at 0x70 - 0x7A.
> 
> Among the ManufacturerAccess registers there are some more differences
> mainly related to MOSFET control and deep sleep/shipping mode.
> 
> Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

