Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB419067C;
	Sat, 30 May 2026 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139285; cv=none; b=Yz0cDB2KBmpV2ZgpKoBFAFbBx5tB9bl0eQICQSkJJpwpxYHUGNIg0fIde/mNvsk2v32LI3PwzTTelsvTzCWwfULJ9W5hcMsz4HxqrC2ob5kOjEN/kiQVTdstzmX3myYe0vlrKnof69l0hQQDgfCmUNvYxPAxn53Jw1EeXFxjVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139285; c=relaxed/simple;
	bh=OXWZos6Dle8fAOPCysJuJaxARteW8/eqIVr6Rikpmgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dxsk/QggmYnPQ3PhzaQUZRWsAR/MUzaHHg0KwukMIES5kEW5wLlY7lp224MOzV31oLJG7hptVwAWG64xpHuzLfFZMl8n9J0pjWBXowhrlYAzTDNetbG06B+59D1JQnztwH0j548qO5uwvPhzRoccOmRMnarahufrr8nXUsXxXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSfTd5Vf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSfTd5Vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDDB1F00893;
	Sat, 30 May 2026 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780139284;
	bh=H60wNIlCfeQ/C3eV7ITTXXDQqIrlqopFqnGrs8jajTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HSfTd5VfyrBeK2P04qZjb2+KCbELHFcXPxffCPKBdDBMq+xYN7vXM7c+la/LCfwKq
	 Df1Zm2/sDBAWGhPibAZ2LAS0CcRRFkgxSJP2TFYN22EktkGyYzfiYf+2JWG46tfGHE
	 CaCu90635CW9kvbniX+bDY8Ree6XnT6gW1DBwALiIU62XSEJsAqM2i7MOjP/uWPuJR
	 E9ZUXjKaJIlxFWQs5bJTJyeq6KK11pV08+A2EMYzOE9roLtUiDccW1QT8ZfeqI7Bf8
	 YvwW+EJzEcZw6d6VhZbQOHVTzp2lsmKP4cBtuiV685ojIYXHIubZ4pVE/yC04aT7do
	 rrsL58UAiO2WA==
Date: Sat, 30 May 2026 13:08:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,shikra-epss-l3: Add
 EPSS L3 DT binding
Message-ID: <20260530-victorious-resourceful-muskox-cdeadb@quoll>
References: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
 <20260524-shikra_epss_l3-v1-1-b1528a436134@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260524-shikra_epss_l3-v1-1-b1528a436134@oss.qualcomm.com>

On Sun, May 24, 2026 at 06:03:35PM +0000, Raviteja Laggyshetty wrote:
> +  '#interconnect-cells':
> +    const: 1
> +

I do not see any differences against OSM L3 binding. Why isn't this
device there?

Best regards,
Krzysztof

