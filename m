Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077E3A1A26;
	Tue,  7 Apr 2026 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547732; cv=none; b=PP25z8DH4csBZlOEG1n7nWhmoWMZVA1JTbUz/mBjTI0ZOgkRnED1h6vYbAxz+QI1OczlKUQDvfIb2TZYnod+JJQnm24zzDaEi8NymNm28EYmUhKmCtUT8NsLubVaXwXhTqC8gAnURWFTxcTAyE6ApfnN83eaEo+WjcVIvMlMvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547732; c=relaxed/simple;
	bh=sPzm/Nez1fn/x3kwZsl/isvL5S/cIA1EMnGc47K4a3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIRETR0XLh7dQ5N2Hg4c5pMB/qegLqS8DE8oJLDh6gMCZrV7noT4CHL5LFOxXJBhJEk01RA7Cxxz4rAN3Jh7bkwwhkndPAx7mAvleF5TEaSmeIpB0pzLNxMwq+GCDFbqxB2VH4gj6nX//tZJf3cUGKbJpcC+SCRYleYlU12B8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSbQtWXi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSbQtWXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D5CC116C6;
	Tue,  7 Apr 2026 07:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775547732;
	bh=sPzm/Nez1fn/x3kwZsl/isvL5S/cIA1EMnGc47K4a3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSbQtWXiQ4bD1RCyJNbixFjkvK1y+S9MqXRC+zU+BeIt5t/ym/mclYVp6+aoAS1G7
	 RGdsSn1MM+IyRSUCYetSG5ZOVaIChjmYexpJoVMePqznku74UnYQFERP9e/FzDqvKz
	 qbjmnO+BpBaq1NabZAA5PMBSleM4+2De/QUg/sHFmOeEJk1/6evt0cASOj5k5micpz
	 yle+q1wrEZnCMPm7d703TeYNYH0NgRRXBsQ7pG3bN8NWJrcasJuDM5w6GsFi2MdYZa
	 LRZfW78SiszUn1K6smsp2QZDJsNEyDo7UASJ+jHEu2cX9HrAdnpxkiNocDA07LIIHo
	 eRrpc+OfW+7lg==
Date: Tue, 7 Apr 2026 09:42:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Hawi SoC
Message-ID: <20260407-prehistoric-inescapable-loon-cf0dd0@quoll>
References: <20260406-icc-hawi-v2-0-6cfee87a1d25@oss.qualcomm.com>
 <20260406-icc-hawi-v2-1-6cfee87a1d25@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260406-icc-hawi-v2-1-6cfee87a1d25@oss.qualcomm.com>

On Mon, Apr 06, 2026 at 04:04:41PM -0700, Vivek Aknurwar wrote:
> Document the RPMh Network-On-Chip Interconnect of the Hawi platform.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>

Same fixes needed I wrote to Hawi upstreaming lead in private. That's
why I gave that feedback (privately) very fast, to avoid repeating the
mistake. So since private feedback was ignored, you have now review on
the lists.

All Qualcomm previous patches are poor:

document the RPMh Network-On-Chip interconnect in Mahua SoC
document the RPMh Network-On-Chip interconnect in Eliza SoC
document the RPMh Network-On-Chip interconnect in Kaanapali SoC
document the RPMh Network-On-Chip interconnect in Glymur SoC

Made by the same people.

Why can't you look how Neil did it for SM8650? Or Luca recently for
Milos? Or if you cannot look at non-qcom commits then Rajendra for X1E?

Best regards,
Krzysztof

