Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBA4503B;
	Thu,  8 Oct 2026 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791427366; cv=none; b=XGeGnaCdjKylTcgjn64nU8sN1ryyBNLO1KyGDR4P1Iv9zUZFpTOZKcq4WezOIdHFcxPgb9X+jag+TBq7v0WdEvRBp49cluWN1WOKDveECMb5kLvvyPO5FzwcG9arYxeT4EiQl6/a/eKTP1YFWTAHIOkTJk+CgpRh17xhZIgy4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791427366; c=relaxed/simple;
	bh=LYbbeUXjlG54Zr2iWGJR0e9+LV4cubRN6eefRFpkk6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUY9YmsJaa4+G4rTfWJkAUfiU/tE5UqQStyayh5mkEH9PulztZvaECAFnnyDS+7zbxHpSYAzpLzqpL+FASncSm2FYHI0Kv2Lu0TWJJd7xBbVX1Qho7ckg3udiUiw9TWjtmXdpZFh60OK/9xSzfDHaBi2kW+CE1jNR/zrBurWGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnAr6IIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnAr6IIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A031F000FF;
	Thu,  8 Oct 2026 02:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791427365;
	bh=kqosaf+Q/VJaHyGe9K/rhBnyBgCjwDrSRQ9qYscTxqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bnAr6IIChMXbyHpyYVtiHSNmfoTW9Fb89YGeS0tqMybD45ygPPD7jCKU1NBNmC06A
	 dqYylv8brG0CBaHNWXJeRm0hAPIM6t5wAgkWI+wmlGFp1w1iAM6up22ptvM1SKmOC+
	 KbXAGEQEhoz6x62LMstG2EwrLR57M1yRwDFQTpMBj0K0jbj/Z8+l9DyAxlnVi4liez
	 7uC5ESyl7tpp/0K+UktmKATbXammTy3Cqpq9S3YzCqaaJi35R7EsKT0VvMQ7RLo7Zz
	 1Lh4zKj6rCbbNkevwBdYsg796pLsRg38Az1xRZyqpINIoE3olzVW8Y2/7TFGupLYo2
	 hFSCSnU6CGO/w==
Date: Thu, 8 Oct 2026 02:42:42 +0000
From: Yixun Lan <dlan@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: spacemit: Add power domain
 controller
Message-ID: <20261008024242-GKA2005@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-1-0acd2b36b96f@kernel.org>
 <20260928183026.GA211865-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928183026.GA211865-robh@kernel.org>

Hi Rob,

On 13:30 Mon 28 Sep     , Rob Herring wrote:
> On Fri, Sep 18, 2026 at 02:40:13AM +0000, Yixun Lan wrote:
> > Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
> > Domain Controller is SoC internal module which is part of APMU (Advanced
> > Power Management Unit), it is responsible for managing power across multi
> > power domains, which includes power on/off, isolation, power-on sequence.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  .../bindings/power/spacemit,power-controller.yaml  | 43 ++++++++++++++++++++++
> >  include/dt-bindings/power/spacemit,k1-power.h      | 14 +++++++
> >  include/dt-bindings/power/spacemit,k3-power.h      | 12 ++++++
> >  3 files changed, 69 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml b/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml
> > new file mode 100644
> > index 000000000000..f869285f84da
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/spacemit,power-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SpacemiT Power Domains Controller
> > +
> > +maintainers:
> > +  - Yixun Lan <dlan@kernel.org>
> > +
> > +description: |
> > +  SpacemiT processors include support for multiple power domains which can be
> > +  powered on/off by software based on different application scenes to save power.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - spacemit,k1-power-controller
> > +      - spacemit,k3-power-controller
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +  spacemit,apmu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      A phandle to APMU syscon to control registers for power domain
> 
> Sounds like the APMU should be the power-domain provider directly. You 
> don't seem to have any other registers for this node.
> 
em, you right, I will convert this patch to auxiliary driver which will
make this dt-binding doc obsolete

-- 
Yixun Lan (dlan)
