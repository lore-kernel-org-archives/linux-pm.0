Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D547533C;
	Thu,  1 Oct 2026 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842252; cv=none; b=XJiAgLVgimGQfxaKaRyz6XQLp+ZuwU+YuAi6XaDzwDaS43VxjvDVHoscRHlkXn8lMuX7Sm2GovQ8X2HXp+SDEpM1UvGgOYpva2mdtjGy9qL8xxnKe7bahiTFhWmVJVzyMJOl+rkd4l/ekiOLEHozhSPAGpXzaayxFShmpY897qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842252; c=relaxed/simple;
	bh=ZGbR4aB3RIriXOPKFAmkD07CgNPUT4F2e8vEKPFVn6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C97gXRxoz7rEKgzqmBvPCpXl5WILtxF+tqRCj4REiEcOCNMjylBhge8zMME5azUXUOQ72hZM2A6ro41zlpJ5cOmazjXIWICMDOgN4GVPYMeog+mvdEjPwntjfF3RHjtAgONnWYDuy/wThSmZ4e5J7dRQjNmPFf5T5bVOUf9G070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7XCn3CZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7XCn3CZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DADD1F000FF;
	Thu,  1 Oct 2026 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842244;
	bh=xA3sVAvYHgl3WQ28VzOBB4tFDEYxog/63WIwwHEYI4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X7XCn3CZSGnU/DQEmbXVC2KxvWCaEWE/zzE/5M55htl9YGHCXHFjOp6YeGsR7OeAd
	 /4PPfWTaMxcg3UIFpvkQnhcY/2wB27X33HvsHzM2ItcdXe35hp0ubkDElO66v/2lOh
	 e1c7Wdc+Mx/sn8x6I61TRHK81zT6Tdz0KIXJyoSWQB1sEMbsVIEGkyLA2yZHlNSSLq
	 dEMDNj48nab0mvRjtLxt4bl0uVgfoMab5blRzn7MQ9+xD3hEgPx5xjt8FKb08P/6b8
	 PKkCQSsFpNuD4c8WYbmcQ9oJe+aMHdVJ8L9wjr73Qms76SZ9t+4OQcK20mgNxti279
	 oseg7fbZiO+Dg==
Date: Thu, 1 Oct 2026 10:10:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: power: qcom-rpmpd: Remove unused
 MSM8953 indices
Message-ID: <20261001-noisy-jolly-labradoodle-fba5bc@quoll>
References: <20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org>
 <20260929-sdm632-rpmpd-v2-1-97ef8858161b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260929-sdm632-rpmpd-v2-1-97ef8858161b@mainlining.org>

On Tue, Sep 29, 2026 at 08:28:30PM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Remove unused MSM8953_VDDMD and MSM8953_VDDMD_AO used for MSM8953 MSS
> because it is using mss-supply as a regulator.
> Define RPMPD_VDDMD for SDM632 MSS because it is using mss-supply
> as a pm domain.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  include/dt-bindings/power/qcom-rpmpd.h                  | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)

I don't understand how does this even build.

Best regards,
Krzysztof

