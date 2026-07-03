Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB9370AC0;
	Fri,  3 Jul 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064966; cv=none; b=GM0SazRyLbHFK7YqsXiGf5C5hdYTKcqFsZiTagk3xa58+LSGQ/3Uy1iiIX8g8aX7lWupNyec4qV3JU2x3kEpPd93tnumO0h0K6c1OhbNgAA7GSrcgqRJ8azJwEWx/NyeuSYyov0VLfKYh/uK1OO/pm8EDNY0MnlY0GscVELk9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064966; c=relaxed/simple;
	bh=fQqJiiIDpR6OKJLeYYYy7tsAcBhxx0nsZjA0nKhOyDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2CQoUBG5wt6I6NoTAqfnlUOTJD45aLfMpgelG6785Zj6fhE9rInQmuD95FbYQczvqGjwwJfVhIk+GDqpp4RuK7vM5ikql56fml6PYBesC3JpLkQNdphBiGUgLpY16pR7Ph8WmlBwDBq89KDVYPqW+25VFQcKj4FJNjZYzS3noU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebgAnrmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebgAnrmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32661F000E9;
	Fri,  3 Jul 2026 07:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783064964;
	bh=68Qi0IFfsyuroQCNkiNf3ckXfY7NPL30TBvWb8DTwG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ebgAnrmxgieUMjDYs/HyDxK59xvCz3S5EgNI932KOrb34iw7Iy9ujbWyutPg8QWjW
	 9N2sM5Ga1+BULMnKDZzF1mfVE+nzNk63mbZXw2JtcoHcX3Pgm5oDJ9DSea9F5vv/FO
	 XBUXCSv+EmOIRVbK6g9gXH4kxU48eGtGgycSpzbH5ptdcRr5XsBKklf83z/uqJkV7i
	 pf7b8LaLRF38ffP0diE60wIlgLQYRDPy/xLOi8g4aRcGFmT5UpBmaPB4Hj9U8irdAN
	 HaDWfZQj1hx0k0AJ5Xjt4vlFMp32e6pUJqx2a4Xk5OmCHVV58NTxxDmXfXfuDMb7Ss
	 KwJJv0jbitZNg==
Date: Fri, 3 Jul 2026 09:49:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Amit Kucheria <amit.kucheria@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v4 02/10] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Message-ID: <20260703-quirky-impartial-oyster-caab0d@quoll>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-2-3882189c1f83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703-qmi-tmd-v4-2-3882189c1f83@oss.qualcomm.com>

On Fri, Jul 03, 2026 at 10:33:05AM +0530, Gaurav Kohli wrote:
> Document the optional #cooling-cells property for Qualcomm PAS
> remoteproc nodes so they can be used as thermal cooling devices via
> the QMI Thermal Mitigation Device (TMD) interface.
> 
> Qualcomm remote processors expose TMD endpoints that support thermal
> throttling through firmware. The cooling-device specifier uses 3 cells:
> 
>   <&phandle device_id min_state max_state>
> 
> where device_index selects the TMD endpoint (for example PA, modem,
> or CDSP software mitigation), with constants defined in:
> - dt-bindings/firmware/qcom,qmi-tmd.h

Full path.

> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  .../bindings/remoteproc/qcom,pas-common.yaml       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> index 4607b459131b..ef11371058c4 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> @@ -79,6 +79,14 @@ properties:
>        channels and devices related to the ADSP.
>      unevaluatedProperties: false
>  
> +  '#cooling-cells':
> +    description: |
> +      Cooling device with three cells:
> +        Cell 0: Cooling device id

And here you provide full path with device IDs.

> +        Cell 1: Minimum cooling state
> +        Cell 2: Maximum cooling state
> +    const: 3
> +
>    glink-edge:
>      $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>      description:
> @@ -95,3 +103,34 @@ required:
>    - qcom,smem-state-names
>  
>  additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/thermal.h>
> +    #include <dt-bindings/firmware/qcom,qmi-tmd.h>
> +
> +    remoteproc: remoteproc {
> +      #cooling-cells = <3>;
> +    };

Drop, empty node.

> +
> +    thermal-zones {
> +      subsystem-thermal {
> +        thermal-sensors = <&tsens 0>;
> +
> +        trips {
> +          alert: alert {
> +            temperature = <95000>;
> +            hysteresis = <2000>;
> +            type = "passive";
> +          };
> +        };
> +
> +        cooling-maps {
> +          map0 {
> +            trip = <&alert>;
> +            cooling-device = <&remoteproc QCOM_CDSP_TMD_CDSP_SW
> +                             THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +          };
> +        };
> +      };
> +    };

thermal-zones are not relevant to remoteproc.

Entire example feels pointless - how is schema even applied/matched
against it?

Best regards,
Krzysztof

