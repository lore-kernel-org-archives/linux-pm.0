Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792985318;
	b=mTBYHpiO+FxeEjr6YiLqdBpR9qecdZeZPTw60nY/9eNJYK3OSoMg6ciLXM3X/3510Eo8
	 aSwf9rLJIXDKu/xacEQszl4znodRsmUbn8rnLVkWNtw3Q8iDB1UTEycwYHCh5BjxZkdmn
	 KdNgiFEWVy2Yqspv4IbZkWb9RoZY49brHFzLehGE6ri6RHXHNFycAFCw1meSH0E1xP5ih
	 dzGR5s96qTCkTDzAVAQK5s0JoLQu2r54Kg1fdRbW5a4gqmZoO8lJIKmHMIVdHNQ7+8IsR
	 MoElc15lyDZaHdZ5pS65gfnHHRIvdrDu+dZocjw3J9oKVRbkiQp07PifvUtNqTXimvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792985318;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IBTIDqwOl1+d46ImoEeLOzyLK0EFe7V3OxFlPnB6uyI=;
	b=oU4t2yjgB+n2sF00RcUp0+Yh4lyuQ4mlTqe1ofgBiwr2EvzHhGZnL01V3vYupVt9TWdj
	 hGbmTumc5Q6gtI/UFH872Es4fu5IIPjE/s12Jsy+iP5571q0lLH3Jg1EeE2tSbZ9SeG5l
	 WWVtDdCSSIH3H49p8M0JZWs8bc1xUpZHzSv14EmSiEitP4F6VXd27m77b/bTHQRN0lS33
	 m3yPyY7uJT960GEWu+iCMSAsgtZGtal8+LIeIAvvCRZWGABSz84SMSQS1z4oS3CPcRuHd
	 RRnf4MvpUsHmzG2Et/B5TpRXaMme17FMpHWXbJXi8wWq7caCfkfWqImocx38irGR6qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPpLnzG0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2942606A31A;
	Mon, 26 Oct 2026 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPpLnzG0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812891F01825;
	Mon, 26 Oct 2026 03:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792985317;
	bh=IBTIDqwOl1+d46ImoEeLOzyLK0EFe7V3OxFlPnB6uyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nPpLnzG0MOXaR8f1nQhOyTOlgMuzh7aXsnVxXR0uhdNrsOBTte6gH3getgjIz0oyI
	 WVF8aKXSvc9K5gLKNDTk4ky9/dOVv4K10LXUJaEThTDxW3aciLHoGHBGJXyuMRkl9r
	 hZcL1+YZEV1/K6FaTDFzJuRkvoEkutu1FuOenRmErIFMgygnSjqe6Ms6Gk+vI9glJL
	 anscKchc6T3flijFN02keZHU4K4NfSs23bz+gbOqmEF3TTIce3yxaSrLHSn1XH3Geu
	 cNDH3/ejrSZ7wafGCn/RG2FcV24Ab3ggxG4pVx/7C1Z6vESj9jqRGrK7otvnMyq9VB
	 URPpBxMapQxVA==
Date: Mon, 26 Oct 2026 03:28:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brian Norris <briannorris@chromium.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson
 <ulfh@kernel.org>, linux-pm@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 06/17] iio: adc: rcar-gyroadc: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026032831.358af9a6@jic23-hlaptop>
In-Reply-To: <CAMuHMdWNuVOnn9KwYuRm5TYsMEf362V_4fSwQGp3fOfR_i7jkg@mail.gmail.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.6.Ia4649c7263a5733426a8778ac4b2dc459f3ffef6@changeid>
	<CAMuHMdWNuVOnn9KwYuRm5TYsMEf362V_4fSwQGp3fOfR_i7jkg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 11:23:38 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Thu, 22 Oct 2026 at 02:01, Brian Norris <briannorris@chromium.org> wrote:
> > This driver propagates the return value of pm_runtime_put_autosuspend(),
> > which is not particularly useful.
> >
> > Returning an error code from pm_runtime_put_autosuspend() merely means
> > that it has not queued up a timer or work item to check whether or not
> > the device can be suspended and there are many perfectly valid
> > situations in which that can happen, like after writing "on" to the
> > device's runtime PM "control" attribute in sysfs for one example.
> >
> > For this reason, modify this driver to simply discard the
> > pm_runtime_put_autosuspend() return value.
> >
> > This will facilitate a planned change of the
> > pm_runtime_put_autosuspend() return type to void in the future, similar
> > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> > type to void").
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>  
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Applied.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

