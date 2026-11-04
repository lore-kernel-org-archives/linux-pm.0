Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796229;
	b=BMPihAsoYZvyKMTvxwBTvPChx52OVqjVNwg/y5N+FXNVbuEIcj03RGTmaqSUXYXwiS9y
	 IWtCL5p/1QmS/TuLJ5L/ZfI+/6zELoEb25Ic6Njn48GVDpYFu5HbLmFyMKd6TOnlMlIwf
	 pxTQMPxzy6e/G/D6ruUdRxp7qvevLIRASejcClX/ZELCuEsA7FKoApIXfVwnKTAcyJ6S3
	 YAFEzKMgRRXRhdglWzIWslqeGov4WXnFA6sdm8FBTcoP5l9JPsQpD6TXQhm4AP0SlZ2NG
	 XyY6kSmJOyTn2hqXY6xbKGBs9n4QSj7CJeq5lXgF09YM+le4to3sEsH7V6OLu5n8zIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GXpfgjmWTp5nqsqu9wlvALydryieE4OWdqAEcXQgt18=;
	b=nBuVMwLrmHAgTp8tRY8NWkVmuiu3HYcIWySF04MLZn6AWHWw2T74iQDDBz4DxC+GZxrE
	 XtTKzFgeCmre3rqagkdmekXMjnfA2brgvjYNA+S/NLgfitMg+k0mT9lYxqSjNa3gbs9Ri
	 rS/JVlAbpb1nQDSF7bV7H1370R1Kh1m8stFsWnFtOGbJiScVEQVw9K/eQx6+fOnRFFB78
	 FURiaTm9Cp98UmkTGWn0BginOWudbRdwkhB1wl0PDKO/sipuaNXjAAlVraWJk+2yGvJBp
	 OGS6Esic35y1PUtu6IY/1k04t6/JxaANzBwW6LCoDh6AA5Fmjc06ZCIZn6GzKIxVlMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBASwH2b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97877606A31B;
	Wed,  4 Nov 2026 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBASwH2b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE6C1F00A16;
	Wed,  4 Nov 2026 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796229;
	bh=GXpfgjmWTp5nqsqu9wlvALydryieE4OWdqAEcXQgt18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IBASwH2bvt+IHRnImqCVuO82GZ+OjSvbQwXe/XvqTKzUbhmvpAdt+EwC6XlYFoqyQ
	 JN/YT5y7iriVyZaurr9jwY1wMn8oJERYsmRqBe6ouNgevV8KUbC2WtBOp0CthAaH/U
	 JTY9QxRFS8U83JZMMvb5yR+BhybHl3D+UVLQ/T7g/6+EVZq+zVvgUiOV9MQ8ev6xRm
	 vprMO4AvytyzB/ihRYNm+RMldgGg526lOZQjJKuwpwVe+/Y/ZHZzJ5k+S0mEJWOEpw
	 1Ueca9JSGMt4QDi1kL2mw6jeT8LLaqqslndUQa4aNanmFTzxM9wk5RHgMl50nRcpx/
	 wbkPyDwxc+7Cg==
Date: Wed, 4 Nov 2026 13:43:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: thermal: thermal-zones: add
 hardware-binning trip properties
Message-ID: <20261104-chivalrous-terrier-of-honor-9b3d2f@quoll>
References: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
 <20261031-thermal_bin-v2-1-d76fd073ae98@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031-thermal_bin-v2-1-d76fd073ae98@oss.qualcomm.com>

On Sat, Oct 31, 2026 at 06:52:47PM +0530, Gaurav Kohli wrote:
> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> 
> Differences in SoC packaging can be used to provide multiple SoC SKUs at
> different thermal and performance characteristics. The underlying SoC
> remains the same except for how much heat the packaging can dissipate,
> thereby influencing the critical trip point at which an SoC SKU needs to
> be throttled. This SKU-specific data is typically burned into fuses
> during manufacturing and can be read back at runtime.
> 
> Add two optional trip-point properties to describe this:
> 
>   - 'temperature-bin': an array of per-bin trip temperatures, used
>     instead of 'temperature' when the trip depends on the hardware
>     revision encoded in fuses.
> 
>   - 'thermal-hw-bin': one or more bitmask groups describing the hardware
>     revisions for which a trip point is valid, modeled on the
>     'opp-supported-hw' property of the OPP framework.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml | 57 +++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 999ad40a20d5..62590dfc77bf 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -152,6 +152,55 @@ patternProperties:
>                  situation where the trip gets constantly triggered soon after
>                  cooling action is removed.
>  
> +            temperature-bin:
> +              $ref: /schemas/types.yaml#/definitions/int32-array
> +              items:
> +                minimum: -273000
> +                maximum: 200000
> +              description: |
> +                An array of integers expressing trip temperatures in
> +                millicelsius, one entry per hardware bin sub-group defined
> +                in the thermal-hw-bin property.  Each value is the trip
> +                temperature for the corresponding hardware bin.
> +
> +                Use this property instead of 'temperature' when the trip
> +                temperature depends on the SoC hardware revision as encoded
> +                in fuse values.  The platform driver reads the fuse and
> +                registers the hardware-version bitfields with the thermal
> +                zone; the framework then selects the matching entry.
> +
> +                Exactly one of 'temperature' or 'temperature-bin' must be
> +                present in each trip node.
> +
> +            thermal-hw-bin:
> +              $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +              description: |
> +                Optional bitmask(s) describing the hardware revisions for
> +                which this trip point is valid.
> +
> +                Uses the same format and semantics as the opp-supported-hw
> +                property in the OPP framework.  The platform provides N
> +                32-bit values describing the hardware it is running on.

', in a format specific to the thermal sensor provided in
"thermal-sensors" property.'

This basically ties it to the thermal sensor which will disallow growing
the thermal-sensors to more than one phandle. The plural in
"thermal-sensors" name is confusing...

> +                Each trip node may provide one or more groups of N 32-bit
> +                mask values.
> +
> +                The total number of 32-bit cells must be a multiple of N.
> +                Each contiguous group of N cells forms a sub-group.  A
> +                sub-group matches if, for all i in [0 .. N-1], the bitwise
> +                AND of the i-th mask and the i-th platform hardware value
> +                is non-zero.  The trip point is enabled if any sub-group
> +                matches.  If multiple sub-groups match, the first matching
> +                sub-group selects the corresponding temperature-bin entry.
> +
> +                When used together with 'temperature-bin', the number of
> +                sub-groups must equal the number of entries in
> +                'temperature-bin'.
> +
> +                If absent, the trip point is valid for all hardware.

minItems: 1
maxItems: 32

Best regards,
Krzysztof

