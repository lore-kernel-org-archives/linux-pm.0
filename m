Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129333EA967
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897198; cv=none; b=rYHOqff2STwdFL2pzKRw0ZMnqFtQLWcSujAUOr/A8RiqcysUiqWFBXshtLJMw0kIwqfgRDU2ZYU5RbuC5ZiPYkoq6NVFU/a/DlUBf/FYm9qk2l0i8e/BbUSuChSXmvlsgWd0vIv4PbEup9GTcINbtOv92AHm20H4cExWtOpo8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897198; c=relaxed/simple;
	bh=4AMZou3BZexPhp9w/h5VtlhpWqxxliNTreCtBnAhm7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNN/V1zBdjtAy454lL+eboCO23YkdFrzihZBJWgdngFgHRGhpVX/xHrdjpYS4ADlHULdEGySetK+1xvbQKGfj3liLn7cOWFdbYgA9Ta3AZGrgxMciqBgq71RNV1wcjwJyhlEld0WvHNjBnEdMoV7NzL0AZ5QUL4VZ0BeotGrjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8KL7atj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8KL7atj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF291F008A1
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789897195;
	bh=4AMZou3BZexPhp9w/h5VtlhpWqxxliNTreCtBnAhm7U=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=f8KL7atjNwkScTIsSWnT74N9Nea2wXa3T0R6qm6PFRZGMBOYoBpx/NfQ+5+zKQRzG
	 1hJ4/Oz0eEfGxs13wslAjjzeqPnxrWsVgzodJBY4R6+lKjnS/F6uZNuqUbjEc7kwrv
	 AGJ7PJqIiT8Nn4xkYGPwQxsosMlZ3SgOkh12VNFr6xNJ7yan8VBS5C57ccqEzvb5sJ
	 bTlbfF0djSJa+T+vUcxvOonapjr+c/uue5toXN2U0k/oPVreBXWZfUoxG2GCbop0hN
	 qKhJuU7hH8CpDh9fCQi2+23blEe9ya4S1PXImMBJySUloqERntexW98lNRHDm0WU61
	 1obNtU5/4VlxA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff16c0e6so14193611fa.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 02:39:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwbUTd+NcwFLQjBJ/dTTmiC/4izNEKWDnnFcGJNtY96WJ1OLiJiU4CsK0i1JW8/CL08vakBgmDTvg==@vger.kernel.org
X-Gm-Message-State: AFuF++n5dveUa6TfeVefFJlf3R958+6eWB9r20HsHYegHr41KhR5QfUX
	V+vBUTmABuiNjcYrig8a6LZbhFr6ivRn2UFRIhxjOfe+VWuSGKvyOim+qToUl99q1sVa2EFvzym
	ci/MbgYcREcg//C0DOBcPUHt7cbVoBgc=
X-Received: by 2002:a05:651c:2127:b0:3a3:74b7:fc08 with SMTP id
 38308e7fff4ca-3a5fbfd4f36mr17073761fa.20.1789897194049; Sun, 20 Sep 2026
 02:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913145527.18148-1-iuncuim@gmail.com> <20260913145527.18148-2-iuncuim@gmail.com>
In-Reply-To: <20260913145527.18148-2-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 20 Sep 2026 17:39:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v65v=2kC-9GrscGi=RXuARZYVNkmEkNhQZ5fFXnQsmL6BQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xk5hFqet9lFlmVe7uaLm2rV_go5OhWrqP8yaEGk0kqgWkXxxEJqM8dWAo
Message-ID: <CAGb2v65v=2kC-9GrscGi=RXuARZYVNkmEkNhQZ5fFXnQsmL6BQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	=?UTF-8?Q?Juan_Manuel_L=C3=B3pez_Carrillo?= <juanmanuellopezcarrillo@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:56=E2=80=AFPM Mikhail Kalashnikov <iuncuim@gmail=
.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> Add dt-bindings description of the thermal sensors in the A523 processor.
>
> The calibration data for both thermal controllers (THS0, THS1) is split
> across two nvmem cells at different offsets, requiring the two cells
> to be read and merged. To maintain backward compatibility, the name of
> the old cell remains "calibration" and the new cell is named
> "calibration-second-part".
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
