Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192910;
	b=Ghx+nyRMSM+ygPGgWTo760IwXfYsmN1Yb+MC8U1JiUFzNsuvvvso5eXqkKlDOnQIyhHc
	 5HzmYDezE4vLgoLnszedk7YP5dx1WF+wogpssyJgaxK+4ABzJeT3WOUv1tYsq2CRWNDfU
	 WOzYiZ61b2XwULc3woCUpX5xZVMOzKuStNHB2+DmkZlGSOiviars0OfkNTJ+70QihBa62
	 jYc8gIQMcvLVf0kxgZkUu3BntbUtlRfZMw7PSAHI3gMrwgNfePValOP1VVRfo4fbb2Fag
	 voprFXPM49moMK0Pgay1ScTIMEGe92cRcrcTxUEykwaVtBBHVWjrSQpBthmTMgZXlDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192910;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=PiQz6PgPos/707nSB4nxYG8jdpkp2zuCWcTnuP8mOnI=;
	b=guobMmTY3rzYwlinm7tBC8uCdrjOE5L98cQURfCBzlbBxhaJhHXDoo9QhODcR4qckbI6
	 IHcv2ZV1cWkWQ8jIXF0f0RGK1gydhPc8KbCV6BiE5KU+W9YC6BuLFFh/zArDxTR6XDYlQ
	 /HFIBRO10Jh+sFoYAWyB4v/OcC7zF1tFe6RqJYsY+vxVS/e+s1L2HaoBO9ggGBrX+xxY/
	 chvFAP7Sh7XWS11jCf/WzyHnptey7RCmWVDPHeDnZ18I7vx0+2VGIweF/VQBKio5JMKkI
	 wAMN117jWlP2A7dzR9chjFs85eS9gD0BSi7OyTJwblE+JwDVdFlXwNUPw8Sdpoj9yuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6d5eool;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461C606A31A;
	Wed, 28 Oct 2026 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6d5eool
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C52A1F01825;
	Wed, 28 Oct 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192909;
	bh=PiQz6PgPos/707nSB4nxYG8jdpkp2zuCWcTnuP8mOnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O6d5eoollfMPr8CDsmx+k9ZZDqtHZcsy5Lh4ruPwzuQ/B0YKQtHtqAtxfgFCinCad
	 +C8YAuNpysfBYpvCwaLBZyKPUoy2l8Fv2io5cRsMrYuxGQ9jffzSTreasdrva5qj52
	 5c+d8qSlyDQ/mVu/ghBwHZuqQhRNZGOgJLbylIfFmTmoFhNzolQWuI/HABmvN7yvdy
	 ejPM9nn4Q0maps9VqvlBw2i/6Pdb2ZqRssSm1IC9BzAmtV0sRUv+9c7n6el2/9YV5V
	 7Ov6T8U1m2t0PYL3FOIQZ2ONhNYTML0BQC9ct7iZNBlIji80dFypY70p1uWyoxrpp1
	 Yi+q1aGQZgkuQ==
Date: Wed, 28 Oct 2026 14:08:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, maccraft123mc@gmail.com, 
	zhangqing@rock-chips.com, zyw@rock-chips.com, sre@kernel.org, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, lee@kernel.org, 
	Zetarancio <zetarancio@users.noreply.github.com>
Subject: Re: [PATCH 4/5] dt-bindings: power: supply: rk817-charger: Add
 rockchip,gate-function-disable
Message-ID: <20261028-handsome-monumental-honeybee-fa1a91@quoll>
References: <20261026174834.1652309-1-macroalpha82@gmail.com>
 <20261026174834.1652309-5-macroalpha82@gmail.com>
 <15875856.JCcGWNJJiE@diego>
 <PH0PR19MB997338FA74EFF7CD338356EB88A5602@PH0PR19MB997338.namprd19.prod.outlook.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PH0PR19MB997338FA74EFF7CD338356EB88A5602@PH0PR19MB997338.namprd19.prod.outlook.com>

On Tue, Oct 27, 2026 at 10:53:10AM -0500, Chris Morgan wrote:
> On Mon, Oct 26, 2026 at 08:23:40PM +0100, Heiko St=C3=BCbner wrote:
> > Hi Chris,
> >=20
> > Am Montag, 26. Oktober 2026, 18:48:33 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Chris Morgan:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >=20
> > > Add a boolean attribute for the rk817-charger to control whether or n=
ot
> > > the system power is shutdown in battery off mode. The BSP kernel sets
> > > this value unless a device-tree attribute is present, and this attrib=
ute
> > > is to replicate that behavior.
> >=20
> > Devicetree is supposed to describe the hardware, so your description ne=
eds
> > to describe the per-board property this represents.
> >=20
> > Just because it's in a vendor-BSP is generally not enough justification=
 :-) .
> >=20
> > This is especially true as you wrote in the cover-letter that no known
> > board actually needs this right now.
> >=20
> >=20
> > Heiko
>=20
> The datasheet describes this as "Whether the system voltage can be
> shutdown in Bat_off mode" and the register itself is described as
> SYS_CAN_SD. Maybe call it "rockchip,can-shutdown-bat-off"? Or given the
> fact that I'm not aware of any boards that would need it today, should

Why would you like to add dead code?

Anyway, describe what problem is with the hardware that such property is
needed.

Best regards,
Krzysztof

