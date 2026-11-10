Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293871;
	b=xUTwpdM75ubKlBGzeyf3LsWxUyWLPjYm0TsUZ3CtqHRUwRlpanLARr7V3w4q67lAR7Xl
	 IKswko9HmyJXfLcQSom9F8VJhNEr22cT/UqkXZnx3W9l5Z2HiyqSxqikO90QGz+zS+H3q
	 M94jQ2vrdNHVq5c06UcKwlEPYmOsQZdvRXOdekTcg1HNST4b/XGcLwnzjXKqf1wa3VWPl
	 pumL/TFHcgZsM2guWA75ViT8PHarEIWlIpP4aEA1hsmR2RmI4SWDBnCu9CikbmX0H06AF
	 ELL18PoEFZMPfEfyPtrYO6wclChRmDPvGZJ9o+7oP2VzZXsYeiax8zw13M2HJ2hxPVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293871;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=4EvMf0by9y3frfgbrO5BXjHEggxHN/vxKwRpOH8GzjOT1/thc/gRatfCaqBJCWQ4P5zB
	 8oIe+s3xd+tI0zCZT8Misw/RLmpdqB02rX24LNXonbVwkKKgRez2z9v4BWUkjVTf7Kj3z
	 AUZ7DL+NSZhIbOeob0VU3svkFE+5nTCkvu5yO0qmVCkeyLi/oaJbtastw4e7uxOx6ATY2
	 kHDr3Qhr4AhkDXyZzzmDCxYn36CeDeLx2QFTfZmqpiVN1BT++TyCjEaMBYtf9DiSx060e
	 42TYQ05ngrwh9iuGMJogEbWpAPo0T33bc9X0ZzoH/CgEhP2qU5TPSEASDmllodeNefw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvHx87uR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E2606A31C;
	Tue, 10 Nov 2026 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvHx87uR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DFD1F0089F;
	Tue, 10 Nov 2026 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794293870;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FvHx87uRV2aBUNfuhWvTypqzTGByWg8iLqANGrsIeuJW7uaM0OSMwz1WlPtVsrmxG
	 Yq7+x7UNE1R8chUFrD8FbLE6YeoAuFg6uCP8s3g7bNuQ77yokuSRRm4u95PmYq3QWC
	 R712F6LgzeKFLP+yG8Q+e85+pDp0jHOO+6dRyz+qMLBL8+71q4xfWfqYT1KcTf9kMw
	 3cb/6uMfE6KK4BqDKyPDVs7ypHMbvzy5GQ33ZmQVXmEOvPdFl3BLiLDCGsSZFpyNve
	 fI5gwa5iQBPiVE9DdIjdhutjNLpgUTW7+2/fwU1aOIhEaOD0JzqXV9MtnnWcT1lEXM
	 8+j+cZ7IJZsNw==
Date: Tue, 10 Nov 2026 06:57:48 +0000
From: Yixun Lan <dlan@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Icenowy Zheng <uwu@icenowy.me>,
	Iker Pedrosa <ikerpedrosam@gmail.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pmdomain: spacemit: Add power domain driver
Message-ID: <20261110065748-GKA1988@kernel.org>
References: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
 <20261108-04-k3-pm-support-v3-2-b9dc0857039b@kernel.org>
 <DMQHSDTR177I.1HWHAF4FWTFQ5@linux.spacemit.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DMQHSDTR177I.1HWHAF4FWTFQ5@linux.spacemit.com>

