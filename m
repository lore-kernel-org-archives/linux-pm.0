Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CF73A5440;
	Mon, 12 Oct 2026 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845935; cv=none; b=Jmupq1dqqTg5BUJSmD8aQkZvo7xfHeFyMF7m4c4xXqneBDTWpLBCYd46kNfM4dxx9bVjrqbEgvgxEdp+rNGfDvwixO/y3IUqhlY2BaHbXQw9uYGuZlx0f9GDxi/u6GXDfPnILOh3OEizxy2kEIMAs+2AzBaOxtDonv66cpbQgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845935; c=relaxed/simple;
	bh=HEEje7McDOxETsPcHD0Fa1nv4xRG1TwxJAGb1MDDAus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNxZqL0fUGS/2WTW4IDr3qxI2f8phzj42YDOhFOoVW+YINwJV1fSBzfaqmyvvPImeIWz4qXWmWu8+5yQj/j2X56wv5ZUeLmelIlUkVMOGrAM4Qw4cA+ks/L+H7SCUEmmrFhrELqrikq6qOiifflR+wWOfira4prii9QDWTH9tWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DlTbccM1; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DlTbccM1"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CD26280D5F;
	Tue, 13 Oct 2026 00:58:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7j6skB5oEUT; Tue, 13 Oct 2026 00:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791845932; bh=HEEje7McDOxETsPcHD0Fa1nv4xRG1TwxJAGb1MDDAus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DlTbccM10HWjMz1OL+3wToVKcE7x8qHI01ipL8K1aqtOEG27M++Rjk6uukzGRs1B5
	 vKHahqOL7EL6trBrwl3ntH1ljhq/xtL6DVUEWXuukiTHWiiOQEm6OVFuCvG8WoPpC2
	 DDsnoIeARStHj5Gg2L8NwcfKuU0R6Zinq1wBbZ+pEP5BoitjBN+desxVNUgH1BnAbM
	 kXOqGH1oEjMZcFaM9kfRUe27MDBwov9FhSfGsTrqxNHWYC4lTXurgKpcJBkALUzhqp
	 aHquQibydzMgV65DpUK2Sdu2MEaL0uqa065cLb4TRgJt2BahS9qVOQt7QoQAQiKNug
	 uZXfOcQj37FlQ==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: Charis Stratakis <c.stratakis@proton.me>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	regressions@lists.linux.dev,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the complete callback
Date: Tue, 13 Oct 2026 01:58:40 +0300
Message-ID: <20261012225841.15260-1-aliamemis@disroot.org>
In-Reply-To: <20261012225141.13683-1-aliamemis@disroot.org>
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me> <20261012225141.13683-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Charis, could you test this on the P1 Gen2?

(Resending with the lists in Cc, the first one only went to you.)
