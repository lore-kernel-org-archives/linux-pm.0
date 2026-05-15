Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B353D6491;
	Fri, 15 May 2026 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828046; cv=none; b=OA8hIOz+vM32aF2Ej8981+5fFU7MW/lM8iQkxlq52/G3TGyKt6zFJFw/KsYpo5usSt++4+QxjKOGJ5m/OfMrQejK1W3UQ5lyC42HsefWmdJ4LjLeaUM+gMpd6RT/cM43EBG+LrKk3Y31BZimi59pvh1sPfkELdVTYBmoewF+0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828046; c=relaxed/simple;
	bh=Lx/U1ra8SSDupPDZQdxvqsryyhrncFVTz5Qi6+1kgM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvl7r/s1Ks3F+1qRdis59MxuqmA5SRYKdCDy3p8gIIVQW+jzcrKF1WWlFaY3mwMorzacCP6i2H4nOLbywFZ4azhjGoZ2CUiMnxQr6yb9dyHTXp7pD9ZCOBM1+3YbS7Nge8ddPojlH90zQCnGl+hwdKQ96svhrbY4VdKpcjiB9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7ntyYZO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7ntyYZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A88C2BCC9;
	Fri, 15 May 2026 06:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778828046;
	bh=Lx/U1ra8SSDupPDZQdxvqsryyhrncFVTz5Qi6+1kgM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7ntyYZOu0FDD+wSRf3aD6HZeJ0E38MRxwWhGq0Z3okfHmozWhZMOCcZ1Pk/saCrc
	 KHH9Lohq0TOMvpQhwctqrhfey1Cgyh+hgq+ICbZKf3KZzd9BnHm3ZqXI1cdCTfoKY7
	 /REn0mRQK+gQ2x4RyAxEKlRqVyAN0oMF+7f2InwK6EhKlrA+GOp2wlGX8GssT9gF33
	 OOwa0KCBdcT7aAJ3e7zlvYo7T7XuyxfdLIq+uXBNmLLHlaB6wy9QSHKQTOhVXoBQ3+
	 V+CgHv3aIxFMztskcBeeBJHJjcwcM1mFqVk6zAofBM8Kw+X32f8hHjao6dgufISZF+
	 HkmSb6+HzrJKQ==
Date: Fri, 15 May 2026 08:54:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom,eliza-rpmh: Add
 SDCC1 slave
Message-ID: <20260515-idealistic-vulture-of-art-fd1bcb@quoll>
References: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-0-13c03bc890cb@oss.qualcomm.com>
 <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-1-13c03bc890cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514-eliza-interconnect-add-missing-sdcc1-slave-node-v2-1-13c03bc890cb@oss.qualcomm.com>

On Thu, May 14, 2026 at 04:36:23PM +0300, Abel Vesa wrote:
> The Eliza RPMh interconnect binding is missing the SDCC1 CNOC CFG
> slave ID. Add it so SDCC1 consumer can describe the corresponding
> interconnect path.
> 
> Append the new ID to preserve the existing ABI values.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

