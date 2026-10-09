Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D94A43FF;
	Fri,  9 Oct 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560026; cv=none; b=RFe/0i8MGjLkJ9wzRhTdhoMqPkOPfCNWN7AQtaXIpJOYxMj2iEsm99kjT59Eudm1W/4HS+84/Q4CvhDHyYf68ZvNgO426r5S6xv0HowhbfT1klGHPRHcbeVZiwDTBrY4Iw6RPo+V1NHDTbQKhP1GG1tNr9jK7cW9lVbgBURBsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560026; c=relaxed/simple;
	bh=bUTkjukO7bxbyv+o88ajSOa0TXgDcFefVbvdaFI1UQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3Jp3pFZRYBfV5rpZgkwKqxNWaTOh/qyl0FWP6nI+OzqKc+DOoJe7zJVNbRFFDZns2nivP1/81tXmuRm1a0ps7hdb/UYg8WroQC2yGjv2+mRljz10GcG9MNCXiFy07yRjOR4hqgvYTQzlNowmsTI+u2ASCtg8anpLw1/Oq8Fg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgd4EbRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgd4EbRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE511F000FF;
	Fri,  9 Oct 2026 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560024;
	bh=p1YiuwOkmVmw2TR3U6ofYFBJqolf1+GepxpnmmNdj0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wgd4EbRqsKHfqf2MAhNBuTTEeIXUShu+oxcLKEnC2crXixpIzqHuTgQiTwgLVKv6/
	 Ny3pr4tzUQ8YyI89eFmpOZoWsWzdFzsevTbT1NVLuecAaQkhCGIdvPXP1sjbg5Vloe
	 tql/dCSczJQnpSEdoqaVDfeEPqH9yg75ybcheoi9AaLzduQIn7/HR8eCl5lIZWC1a3
	 Ua3BOsLawZl1KcEQ+WmESuvpIty+HbtpsFhsRvB3DXO6LiLgfU10rz6EHE/plIPj4u
	 y8v3sHjrf6rC3Gqm5r52nFF4aKz3pChx/dw1md25cKkM1FMQ9FEroVu8EHuLHf/B4d
	 TT4Xyarrgdn6A==
Date: Fri, 9 Oct 2026 16:33:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Harini Katakam <harini.katakam@amd.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, git@amd.com,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: Re: [PATCH v4 4/6] dt-bindings: dma: xlnx,zynqmp-dma: Add Versal Net
 compatible support
Message-ID: <20261009-adf9c30d2d6f7a25bb1dc041@squawk>
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-4-55f5fe409c55@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N9GlTL/oEVtyOx8o"
Content-Disposition: inline
In-Reply-To: <20261009-adma-pm-fix-and-per-channel-reset-v4-4-55f5fe409c55@amd.com>

--N9GlTL/oEVtyOx8o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 09:30:13AM +0530, Golla Nagendra wrote:
> From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>=20
> Introduce a new compatible string amd,versal-net-dma-1.0 for Versal Net
> ZDMA. The new compatible requires xlnx,zynqmp-dma-1.0 as a fallback.
>=20
> Add a reset property to describe the per-channel reset line exposed
> on Versal Gen2 and Versal Net. Mark the resets property as required
> for both Versal Gen2 and Versal Net, and not applicable for other
> platforms.
>=20
> Note that making resets required for Versal Gen2 and Versal Net results
> in an ABI break, but this is unavoidable. While the driver works in many
> scenarios when no other firmware has used the DMA prior to Linux boot,
> there is no guarantee the channel is left in a clean state. In observed
> error scenarios, a reset is necessary before Linux can reconfigure the IP
> after previous use by other firmware components. Due to configuration
> differences or the DMA being left in a bad state, DMA functionality fails
> when sequential software components use the channel (e.g., firmware before
> Linux boot). The channel can only be cleanly re-configured after a
> per-channel reset, making it essential. This ABI break is only applied
> to Versal Gen2 and Versal Net where the per-channel reset capability is
> available.
>=20
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> Co-developed-by: Golla Nagendra <nagendra.golla@amd.com>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
>  .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   | 34 ++++++++++++++++=
+-----
>  1 file changed, 27 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma=
-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.=
0.yaml
> index 2da86037ad79..ff8c9a0e5559 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.ya=
ml
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.ya=
ml
> @@ -16,17 +16,17 @@ maintainers:
>    - Harini Katakam <harini.katakam@amd.com>
>    - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> =20
> -allOf:
> -  - $ref: ../dma-controller.yaml#
> -
>  properties:
>    "#dma-cells":
>      const: 1
> =20
>    compatible:
> -    enum:
> -      - amd,versal2-dma-1.0
> -      - xlnx,zynqmp-dma-1.0

This used to be an enum, so please preserve it as one.

> +    oneOf:
> +      - const: amd,versal2-dma-1.0
> +      - const: xlnx,zynqmp-dma-1.0
> +      - items:
> +          - const: amd,versal-net-dma-1.0
> +          - const: xlnx,zynqmp-dma-1.0
> =20
>    reg:
>      description: memory map for gdma/adma module access
> @@ -59,6 +59,9 @@ properties:
>    power-domains:
>      maxItems: 1
> =20
> +  resets:
> +    maxItems: 1
> +
>    dma-coherent: true
> =20
>  required:
> @@ -70,13 +73,29 @@ required:
>    - clock-names
>    - xlnx,bus-width
> =20
> +allOf:
> +  - $ref: ../dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amd,versal2-dma-1.0
> +              - amd,versal-net-dma-1.0
> +    then:
> +      required:
> +        - resets

The change here for versal2 is an ABI break (new required property) and
needs to be split out into a standalone patch. The new support can go on
top.
pw-bot: changes-requested

Thanks,
Conor.

> +    else:
> +      properties:
> +        resets: false
> +
>  additionalProperties: false
> =20
>  examples:
>    - |
> =20
>      fpd_dma_chan1: dma-controller@fd500000 {
> -      compatible =3D "xlnx,zynqmp-dma-1.0";
> +      compatible =3D "amd,versal-net-dma-1.0", "xlnx,zynqmp-dma-1.0";
>        reg =3D <0xfd500000 0x1000>;
>        interrupt-parent =3D <&gic>;
>        interrupts =3D <0 117 0x4>;
> @@ -84,5 +103,6 @@ examples:
>        clock-names =3D "clk_main", "clk_apb";
>        clocks =3D <&zynqmp_clk 19>, <&zynqmp_clk 31>;
>        xlnx,bus-width =3D <128>;
> +      resets =3D <&reset 0>;
>        dma-coherent;
>      };
>=20
> --=20
> 2.43.7
>=20

--N9GlTL/oEVtyOx8o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaskJTgAKCRB4tDGHoIJi
0nYQAQDoViJPC2UPwMN0oUIk0GyH01JuNpqn1aqCxqop8YyWBQD+I+ulv/qRdx5e
yIcfLs5EJM8GnSliJPXOA0nAJDWMKQc=
=cwYt
-----END PGP SIGNATURE-----

--N9GlTL/oEVtyOx8o--
