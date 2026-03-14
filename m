Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322A19CC14
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773474017; cv=none; b=aEm9sy3cZGNv/wvjtvzID3waCWcH6iZ/IceeAo8xzLJA6rRlLBxnUPvQD56ulrXQT9jNJzbr4qtN7Q0/dnWaLTAXPOSeai7fr5mVPGv7UWxoSLtibtcvYGueuUmSOqVfCfrCyBT7KVKhc1GZv5i490JEUOy7UiSQFYBxkFxT+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773474017; c=relaxed/simple;
	bh=jr47S8Omkd671RmRpwVUVeGq79Jq1P9/cSVeCw/uis8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAoJF42SwcxN2ybtOoCILY/h7RBubTb7nxSTlvgeI04LbXaTeRkLnHwJkPDbpMx8qt6smIxmfGpK0Ogi1LITxZLrE5Z1L4fACj2zPVsvmUH4T/yRiiPRg9ueLkOcDmdzi4fO1YcStigeyLfIssglWEHqVqOJFVnDeTUAr2mH/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOu1zzQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOu1zzQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F916C2BC9E
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773474017;
	bh=jr47S8Omkd671RmRpwVUVeGq79Jq1P9/cSVeCw/uis8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=VOu1zzQe+2Yc0ZFpfntKg/CMWuzKeWujXrmWicC7XhZE0fF/reknaXH1ch7dgAJRX
	 8dKORNHxbrVdXcLjewURgcrue7eJMHWrVug2WvioUOG9/zM8Q8mj0rPDH8iAfszfAo
	 o/r8kjQs3ApJW7CXTwUWADBSH0tCEiexiR7XZ8LHgVfUswprQaZut8lGw/nAlJ9Etn
	 oocTr2M/9+tWHDBkjff62v8eVVXI4Si/WnPQfqlnrAF81chdzxGW4XusBZF4aZz9/S
	 WPJZEs7giLAM3nlSJsQnMOflj+gZzSqKRUNhAXaDnno7lZpQzvHS7sntOBwR6tWRhb
	 KP1P/RcG4lOoA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so3738836e87.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 00:40:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/VQvZTIEDGAg4mfPgYjN6pNpJaJkAgUkMwsbhMQUJcRt8TxkFK7EvRhc3EGR917qN+U9tNzxnsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wiMDTAG3OAM6jK1rlntoBF4hUj4s811LlF1eW7YJmx00/F+G
	RO4/DBm/xKzuXpZo3BvUJ0vPUvDXNMCpi6I8WNn/xMXlyiagZkR7lmR49qiqt+C/4lDxzUmAtBm
	DTxswtAOlCllUHq2M4DsDrPJYev492ww=
X-Received: by 2002:a05:651c:3251:b0:389:fa42:b278 with SMTP id
 38308e7fff4ca-38a896a7e7amr21812631fa.14.1773474015748; Sat, 14 Mar 2026
 00:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com> <20260305-b4-pck600-a733-v2-2-ba6bbed7d253@gmail.com>
In-Reply-To: <20260305-b4-pck600-a733-v2-2-ba6bbed7d253@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 14 Mar 2026 15:40:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v65h4aXPAfZ1KnsxgxwtOmfu0ZKbzHjYoG3auacpoBg57g@mail.gmail.com>
X-Gm-Features: AaiRm50gm5CxKsArz3g0RHJT9DAFqfRxhiIS2xZcN5maI6-RPumGZgYHHPT9O04
Message-ID: <CAGb2v65h4aXPAfZ1KnsxgxwtOmfu0ZKbzHjYoG3auacpoBg57g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pmdomain: sunxi: Add support for A733 to Allwinner
 PCK600 driver
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 11:34=E2=80=AFAM Yuanshen Cao <alex.caoys@gmail.com>=
 wrote:
>
> The Allwinner A733 PCK600, similar to A523 PCK600, is likely a
> customized version of ARM PCK-600 power controller. It shares the same
> BSP driver with A523. According to the BSP provided by Radxa, unlike
> A523, it doesn't require reset, as well as a different pair of delay
> values.
>
> Make reset optional in the sunxi pck600 driver and add support
> for A733.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org> # matched against BSP driver
