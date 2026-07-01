Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370148C8C0
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2026 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911724; cv=none; b=u2xGPHlKT7BLdrZErDok6qgLStF5mRtieDZr+qqwc/QlrSLC4fGhOyzxUfKz/nAybTGm/YdPK5uDNQncvQNfqgYHFmrl+L4UhhzywYhqme78wT3N/WaDU1UsPoiYjkYnNCyzuctmdbTWAOZyy7+hZXdo2UuxydO5qmtkP5OAWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911724; c=relaxed/simple;
	bh=Y266Fi8WDphMFnn7zhSQbuTm4ywNbfR4vRsceUY1V3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQCqmgTpuxw1qzcrRgVIM70A7nfShXomRSxtmouZObbZ7v8aosWDaPptR+0zdkMcaEqKQkw6ApRp3Obp1ojBg7J+hDmwH4Do/QB2XkTAw6Mppkfmqu1o4RuT7e+NYgXRRB2ER6w34beE67/xVQO6zqdLixS/uaIwbZfgB1xDh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0NTsl8/e; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0NTsl8/e"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F1225C504E1;
	Wed,  1 Jul 2026 13:15:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EBCCD60288;
	Wed,  1 Jul 2026 13:15:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8999104C95C0;
	Wed,  1 Jul 2026 15:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782911719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Y266Fi8WDphMFnn7zhSQbuTm4ywNbfR4vRsceUY1V3o=;
	b=0NTsl8/etNf9pJcmoh01Mwa6FHJ5tjIR9UovTpsCQPRaSNQgdtfqcLKaauBsGaMuC7M/Hs
	vy6gdWdxJ4vBxMikLRqhfMDUgtE0wMlxUuwZH4poJt8N4H/Il8x1TD4xXOkgd1vB1k7q02
	yZOseRkKAqYzcEktqUwqL7sEuT5MpHEzO4juQyPDokLmy20JfvKLiLf+8GGiw7E+943ppJ
	SrosFLVtJqV+BzD+FvwERAsRqfql1YnLs0wz8i2gIC+9CkdaW06bFOYjWS2Nhat+0tDAvh
	AaDhNODW1pLgSvg4YwDQABYUWDZYlCM07bwceXHmCflFr3/OS/elu2XD7i1ilQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Bryan B. Lima" <bblima@usp.br>
Cc: rafael@kernel.org,  daniel.lezcano@kernel.org,  rui.zhang@intel.com,
  lukasz.luba@arm.com,  gustavoscorrea@usp.br,  linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: armada: Use bitfield and bitmask macros
In-Reply-To: <20260701010802.99029-1-bblima@usp.br> (Bryan B. Lima's message
	of "Tue, 30 Jun 2026 22:07:18 -0300")
References: <20260701010802.99029-1-bblima@usp.br>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 01 Jul 2026 15:15:16 +0200
Message-ID: <87qzlmrguz.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 30/06/2026 at 22:07:18 -03, "Bryan B. Lima" <bblima@usp.br> wrote:

> Replace manual bitfield manipulations with FIELD_MODIFY() and define
> constants with BIT() and GENMASK() to make code more readable.
>
> Also, remove offset and shift constants for clarity in use of bitfield
> macros.
>
> Signed-off-by: Bryan B. Lima <bblima@usp.br>
> Co-developed-by: Gustavo S. Correa <gustavoscorrea@usp.br>
> Signed-off-by: Gustavo S. Correa <gustavoscorrea@usp.br>

I find the BIT/GENMASK conversion useful (I would definitely use them
today if I had to rewrite the driver), but I personally kind of dislike
the FIELD_MODIFY() macro and don't see how it improves the
readability. I prefer plain bit operations. Nevertheless, fine with it.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
