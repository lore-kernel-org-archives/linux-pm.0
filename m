Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6C43C047;
	Thu, 13 Aug 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611075; cv=none; b=dxye3MFn+ndn9FVSHkfoGLGJ5TR7dPVvuyvCEDLzJIiUSqmsumsK82pCAHtGHytOIW9ZSMbTHymEMJF8PW8y1DqF8QV5M61DjG9HaeOGTxLu6Hy6+a0ZUQRhoNnltj62XnO5NJSclHza9c6Cv6fRieEfQWvfasBvM3SUIc0XXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611075; c=relaxed/simple;
	bh=f3/KPsBBroifBY/x1+qsQGeW7+UaKmEIgPQZzrBw1Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cClj6FdkWNsl8+nfRSS5RFFm2PWWfJ0H2ue9kZ1zK5qwBtgd5qfal1cXyOmSRcyD2ECkjh6Q8NwcRT8g0mosqmEFHNVjgY9FKrqgiUhgCD04HJkGOMVzXX7tFTENhg5n8s1aPLl779JyGH07ZAHSoLGawIs90KNEBRrhFERb7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYV4QiSW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYV4QiSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C371F00A3A;
	Thu, 13 Aug 2026 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611072;
	bh=dxFwWNpXsoqF4JYxqwH1P1tBS6gN5IiCOOgnJayn4hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bYV4QiSWiiXjOO5izt/O8zZXvXH6fUxbswgM7s37CXMKL5/MqGpYcNMIZU9qLsPez
	 tdmWjQxDj+InyZUud/Y25ncuFz66+cGwblsp5GmsBT6vxtD9JfMzISWCIlNhyEhqoL
	 Zcuzvek2IW0EGK7kBqia4qSOZhaO8FnSDK4Vgf4Ljh0nBIj0zrMMI4kkTPMkOGYevd
	 lHRtQQN3Rrk70R0G8gzkDDgdfEK9l4HRtS9Sl+WwU2KCjAaKdUfKvQnXhL5mXiNRwt
	 5p4gfdhhhEkQOZP8O3gvXUHoVdlmNnTygQG54iZDkpheLX33rbeEdDt3CKDbpz4A08
	 ROiZ0gI4z+jUg==
Date: Thu, 13 Aug 2026 10:51:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robin Snyders <robin@snyders.xyz>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: qcom,pmi8998-charger:
 add SMB5 PMICs
Message-ID: <20260813-festive-holistic-shellfish-1ee0de@quoll>
References: <20260812-submit-qcom-smbx-send-v1-v2-0-f504b8f9bfad@snyders.xyz>
 <20260812-submit-qcom-smbx-send-v1-v2-1-f504b8f9bfad@snyders.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812-submit-qcom-smbx-send-v1-v2-1-f504b8f9bfad@snyders.xyz>

On Wed, Aug 12, 2026 at 01:56:59AM +0200, Robin Snyders wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Add compatible strings for PM7250B and PM8150B, which contain the SMB5
> generation of the Qualcomm switch-mode battery charger. PM7250B uses the
> same charger interface and parameters as PM8150B, so require the PM8150B
> compatible as its fallback.
> 
> Clarify the IIO channel descriptions because SMB5 exposes a USB current-
> sense voltage while SMB2 exposes an already-converted current.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Robin Snyders <robin@snyders.xyz>

I don't get one thing - you used b4 to send it, so how could this be
threaded to some other email thread? Do not introduce custom workflows,
please. b4 is there to make it right, so just use it in standard way -
b4 trailers, b4 prep -c, b4 prep --edit-cover, b4 prep --check, b4 send.

> ---
>  .../bindings/power/supply/qcom,pmi8998-charger.yaml     | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

