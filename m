Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004133BCD05;
	Wed,  5 Aug 2026 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968564; cv=none; b=Jg1KLY7BxjGsOB4VopNV/drR16IpTZG9LvPKREYAHqdc5kyDdrt9U33LUpwyG3XwRzQviAphbHcnYVQpNqmsjuXQUX7EPgBbkb2XNEKuVzKqnHi59PEzqfgue9w+ATNh6GefDPkcGzfhjvYUfWfTbCBJ/lqFpUgnPxw+DApqL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968564; c=relaxed/simple;
	bh=3VdDvZ7VlZB4G/5KGO8LpztRCadiI8DcBO6EziPhcww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPJB/6OMzYQogOZxYbJL0HQi4FNwUmOA2islRmiX0U1boncpeWBB5r4R9Bt9Wkd3Vlkm9jJYzGoht6r0Sl9Mop18iEG5xHva8rcOBicBcMFKzp3zr5d6vGv3UiPDGO0me0UWQK+yZaG4UTtLj+1hQb9nZPPqTjSfqCvMkQnQFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i5Ou1FbN; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i5Ou1FbN"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hFlKC5B74zMlL8;
	Thu, 06 Aug 2026 00:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785968559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vitaPJ1/0YLkHqTJEs/ZTCtg7eWB6JEZx0pV0zq63EE=;
	b=i5Ou1FbNhMzgKOeo4jhLaG9cFgV2Kjht8KosjinmjyxoETMalIeRyQMlxXYjH7D+kUN8AI
	iXrHH2sdLDVm31mSlNMbXtwxD7cKRRodigjp95P7FPPu02G6asRC1iGQTc9HDt+zoGVD0E
	aU3sC0Co6YAcj0l+BktbDSqAOfORG797rsGz0Ywq2p2g+5B3ZEzNkE+AjUOKFe7dUm/DPE
	pCSVHsFLdjuVuvxXE3Wv9ncy8KZweJnWuJHAl+bukaIJZc6MY8DY6wz+FnPjAk1CJ5aTkn
	qVp7Jbsgqo8Yt5e9fVeSLTiVtLPCxPGgfce+UZDOemet/YD9Uow8NV/KbhlisA==
Message-ID: <42472bef-cafb-4633-bd7e-7e6f707fdad5@mailbox.org>
Date: Thu, 6 Aug 2026 00:22:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/6] clk: renesas: Add R-Car X5H CPG driver
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1785941595.git.geert+renesas@glider.be>
 <3f981753722de1ba871667be63460e89d299d635.1785941595.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3f981753722de1ba871667be63460e89d299d635.1785941595.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 00ba4762705b72c2803
X-MBO-RS-META: 45u7qioqppyfd15eaa44f15u86pde877

On 8/5/26 5:20 PM, Geert Uytterhoeven wrote:
> Add a minimal Clock Pulse Generator driver for the R-Car X5H (R8A78000)
> SoC.  For now this supports just the few fixed-rate clocks that are
> needed by the current minimal DTS.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
