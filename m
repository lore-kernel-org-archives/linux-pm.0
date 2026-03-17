Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6E3E3D81;
	Tue, 17 Mar 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759201; cv=none; b=dBNye7cfQbPjbwogLrrF7dq88CqwR16YiY1hr3prJOZ9UB8kpDzV+NPMJeg2cisPKRBp4uu4ODQAFVqhcVPoH16MSZNonDVRsL3kRu1HCvcwEHp/216I/ImLErIRklcZRNv+A+bsqdgpovx2BvndTmqVB1LjyZuCQOYVxRHtXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759201; c=relaxed/simple;
	bh=I7kw9exJBcwaelEwGhGD4o7uq4pFbSazi/czoXouoSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZrOLG/QJ7BYtDk0xYBo8WAsrddllxd7X5XAhMt1WUDHNoFhvhCXw/oemBE4tVUjYoMYN0nCjhQniGpufX9Jz5Vm7rimgFM8xUVEbaxkA6YUWZZoUqswjpjzoTII+7msnciRCdS2opzoPOJ0pfJiPZhjEpRGrDR3EmbaUjnO8v4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=D5kug5zd; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="D5kug5zd"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 60F4D411CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773759199; bh=/fwCaD20B8wGRxLcGaJtrFlicTuqaqinTYjruvMfDbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D5kug5zd2XlKhkDTTgcUhFcl3UCPaUYERjnELVeZqp3xZsOyMYNP5Iij7wrQ/yJld
	 yd1UND1Bi9lxtL/m6CjaCbLMXSYEFLt/aKmMFLZOztonm6OBG2WXuF9Cz56OxzpBS6
	 kN8KWUafKTqScPlVJqN8DP+5HK/nvE1+o0TW8hyr31Q/BuIQTrFdqnqR6uAW2l1Cng
	 N85SoN3h7z7Q0CBcigjB7VJcVMR/wx86nshWFt1MUgw0b9H/2AeNpmlRPmroqbv5P6
	 tvqAT+NwozKfOANiJic5fpnrHOK1j4bC3MyAT3vMeeKH3zD4cIhq2Ipe31zYoONAvz
	 Jl6s6GDUb7xgA==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 60F4D411CF;
	Tue, 17 Mar 2026 14:53:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, djakov@kernel.org,
 skhan@linuxfoundation.org
Cc: marscheng@google.com, wllee@google.com, aarontian@google.com,
 jserv@ccns.ncku.edu.tw, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kuan-Wei Chiu
 <visitorckw@gmail.com>
Subject: Re: [PATCH 0/2] docs: interconnect: Improve API documentation coverage
In-Reply-To: <20260312175341.2944154-1-visitorckw@gmail.com>
References: <20260312175341.2944154-1-visitorckw@gmail.com>
Date: Tue, 17 Mar 2026 08:53:18 -0600
Message-ID: <87se9ycxsx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kuan-Wei Chiu <visitorckw@gmail.com> writes:

> Improve the generic interconnect subsystem documentation by including
> the existing kernel-doc comments from the source files.
>
> Currently, the documentation only includes the provider data structures
> from the header file and incorrectly states that consumer APIs are
> undocumented.
>
> Since drivers/interconnect/core.c contains a mix of both provider and
> consumer APIs, this series uses the kernel-doc :functions: directive to
> properly separate and document them in their respective sections.
>
> Kuan-Wei Chiu (2):
>   docs: interconnect: Add provider APIs to documentation
>   docs: interconnect: Document consumer APIs and drop outdated text
>
>  Documentation/driver-api/interconnect.rst | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Series applied, thanks.

jon
