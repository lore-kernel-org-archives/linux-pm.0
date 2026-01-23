Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF53033E2;
	Fri, 23 Jan 2026 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132645; cv=none; b=SV6sQ5OQp/mFO6A9EOTkz1Ob90whaeb+abLOpqBgfSiLGhudpXkF3DTcWqFn8Rhm5c95XOf3VQpmNhM4STKYcKj8mvM8xcBFDvsADW86ht6d+o5J6ql2QIQfuIEwuMhmdCFzb6Pc8soPtD+MumJI4a7Jp9NArhLycQ9fUW0pbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132645; c=relaxed/simple;
	bh=5hbyjhex9kITqfDLBxrxOd0hxO79EBXto59nVbh5+k0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=lfGavWoFc7REA/sNV+em+4cpaWm0pi3/yiuBKHV8mXt8oKH7kJhQtcFVLkyytvlNdT9XvJ/21XcG+67Ogxh2gYFytEcriJMPpTCC2yfiQIKg0dYCmra3bbbrbVAlb7OLNP7ofdjvt4OIUQNm56v6QLvhj44hBvepJBS2pcDciQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev7ziae6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev7ziae6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB159C116C6;
	Fri, 23 Jan 2026 01:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132644;
	bh=5hbyjhex9kITqfDLBxrxOd0hxO79EBXto59nVbh5+k0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ev7ziae6QynBpEoXuTw+tKhHXcIE6jAWIJ8Qr4jlrhkDwCxQ23DuGDiS8KR5RkSBO
	 XJJKpRuEQMSyjtyKqowRIVTALbgQikLe5jDmniZRcVpmFPaW3AcmIyqXFk4IfLj6Sj
	 d6njx51cvVSdwerUkssiTHBc178UZXFXkMNbtl+QFgQTAlNrfDESTq4wVDotoeMcEb
	 bRjoVzHnuNazboD8Eux2r9CZ7wFAKlyfBZECNF9YwGmZt9Ho1RYi3tHx6Gp9VVm7Fm
	 vMgE+1xnKi7d0Z/CrKlixDgaoCxuRtSxaREDd+af4Ps1QYHHJG/+Il6LKx/Ms0pCCS
	 R2oB6e7BPXgNA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com> <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/5] dt-bindings: clock: mediatek,mt7622-pciesys: Remove syscon compatible
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org
Date: Thu, 22 Jan 2026 18:44:00 -0700
Message-ID: <176913264088.4027.8181442365263055794@lazor>
User-Agent: alot/0.11

Quoting AngeloGioacchino Del Regno (2026-01-13 04:00:08)
> The PCIESYS register space contains a pure clock controller, which
> has no system controller register, so this definitely doesn't need
> any "syscon" compatible.
>=20
> As a side note, luckily no devicetree ever added the syscon string
> to PCIESYS clock controller node compatibles, so this also resolves
> a dtbs_check warning for mt7622.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
