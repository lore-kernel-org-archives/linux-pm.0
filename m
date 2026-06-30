Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18F2C235E;
	Tue, 30 Jun 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832018; cv=none; b=hOQCnad+g/9MeBUzP3XMjTZ+tqZcv61T5UabBvyOAci5dtKM6gfh8JuACn/BJyItwr6qPwY5igspG7fgtl1H3/NC99H6RQRbn5U1sfXtk/vWcsAGBrihNvpdN00vrEA7Kuh4HS6bDWSswUt3bZhGeV4ZTa1Lbx9SiO9McRUXEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832018; c=relaxed/simple;
	bh=ddd5nFk6HZnzFzbw6Jc4Os3J5GUa2PDKNyyiZAs+zaI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEzH/9majMv6w1fdqLTvDQ6nIp7YUIXdTyEjXQ5QUl31hugbOFsQqliKQ/qBvF4X84yJiGfcFjXI1EgQJxBQWQ20O6NClxPPrzOeIgHBSttp8c2Z+d9zxtK5aeSK9mf8s4W8ld23SXEneF4CbIH2JJaUanxbofHdmAxHxfGbKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KGw0nMd2; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KGw0nMd2"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gqRM072GBz8swT;
	Tue, 30 Jun 2026 17:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782832013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvcasnePEEpk54Kk2gu0D4PLMNe04Pkcm0wLQLpZBNU=;
	b=KGw0nMd26zlxfbKAnryt/6ZFiJBPJ6JNXHuoZqPscq1eJto32yAf2gpWSXkSOGF1NqFeRA
	s3E98dJS3RKyp4nsb3oRf6eFyBF5zz5wNVwejNSJpWay6z1gW+BUswwrEEWltrk+EAQXm/
	/asRYYFQ6MnKdZE1KsyesUZTspldiKix4gDYljCsc0KNnavRXRfjU8+76el14xqhhOcJs9
	tc+08vKpOWe8N125GyqtJKaX5t1xxe+2zolf6F2eGYyJlP3WTl8YdtWzcYuw5nB0ktEAVs
	gs49sRgPN5DqolmqK76Isfb1e+13tExjBOdPv93LH64mvngnh8Po9grh0URq/g==
Message-ID: <5a4bb6aba4616d1a73ef9b5629f22ed61882eafa.camel@mailbox.org>
Subject: Re: [PATCH 0/3] Enable icc-clk support for Qualcomm IPQ9650
From: Manuel Ebner <manuelebner@mailbox.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Michael Turquette	
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney	
 <bmasney@redhat.com>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org,  Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 17:06:45 +0200
In-Reply-To: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
References: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: d6b2c0e86fd9608152c
X-MBO-RS-META: n95qsm97o7q6rsztba4bquoonb4pgiar

On Tue, 2026-05-19 at 14:17 +0530, Kathiravan Thirumoorthy wrote:
> Add the master and slave=20

coding-style.rst line 340 suggest:
> For symbol names and documentation, avoid introducing new usage of
> 'master / slave' (or 'slave' independent of 'master') and 'blacklist /
> whitelist'.
>=20
> Recommended replacements for 'master / slave' are:
>     '{primary,main} / {secondary,replica,subordinate}'
>     '{initiator,requester} / {target,responder}'
>     '{controller,host} / {device,worker,proxy}'
>     'leader / follower'
>     'director / performer'

Please consider changing terms.=20

Thanks
 Manuel


