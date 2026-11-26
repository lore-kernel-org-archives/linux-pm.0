Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707236;
	b=R/O/4FrZ2YIhI29YEZKdGAViOMwG2FxGHjiwFHKfWF2ACC4M8UiSGgzfV6SfuAZShqKy
	 MT2mqWgNJasDASiMqbydFjO/YXbVhOqXoLGBIcVKXjPWS3Rjmb/5t8WTRRtZgMoDLxdQY
	 ODUfuTHnUHlr61QMc7gZ5URKOH/6wqVTYfEZemN4mZAN6NOcjXmLANdfo1bG4gqR+ZCbu
	 wLPqmHISsjiz5Y0eR5atF1Qbzn5som+Wn+4LbSlR0nNG6O9jZXtc2QIqYzV7oPJQWmDKz
	 5Ur3fONEeyc931OSOJwAmC5EaQV4auu3vsGmD9daBdxTFQeoTeOgM9igVn53uBHqGmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R0nV4W+3k4nIH1noIyZb7CKek5JKvQVvEcpgjr5MFIA=;
	b=4OvtQEb1TK8N/eFhCEsdcW+3iLKpAQ6LU5hQvKfLpPAdLcjxFZU/ZpnUWAys/poBnnt2
	 qYgX040PuAwN6PeFaNGdclj4lk9by4NyA1J8Mvyn5HQdLhIsQMbODRtR36CPwsicf4i08
	 4mJUFZNW0/YICV4f6QMlGoPHzb4s4yWQWcahnxB5fiO7hyT0aJQRqCtEaVHXbo2XcAJ79
	 miwZ9dmb3wRQ4NA0FvAciFfAgPURHU9TRJOI3ASlPfOULBXSGLZtqomKmBcVxs5FWkYRj
	 6mVVvTo+EEjFTwAeRHWJrGTg+A5uA+ATNRUNkAfMqE4ApsaztnOu4YtAIseowV3hvvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XApmaMX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7045F606A31E;
	Thu, 26 Nov 2026 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XApmaMX+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A89951F000C6;
	Thu, 26 Nov 2026 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707235;
	bh=R0nV4W+3k4nIH1noIyZb7CKek5JKvQVvEcpgjr5MFIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XApmaMX+MLKqq77XGKkuI/KX71CQ8SFdpJLS3LC5xrUuGZ+TgIwpikvJZGcqlIkWd
	 FVn6JPmSWlop9KeScEfDc0Dlo7JrBolIJORs+aF5fE9n3sfyx22ciOOLzIBGy/QLhU
	 JLmQguqGsu1BiRh9GR7F1uMKUhtzorTsLPwEZCVQPwj73y2Aln5ms9NFFwXSuxjD5J
	 HS8zVqfVvqJr3Y98VAZQ85bv1vGEjN72wgBIb8exHdQS52lmYzxrU35Ho1HevrVaQf
	 0I5Z8h8f/Q7KzPp5aNAoNhXyGrKauzEQ1voRpxbETgevJEheTNs4CSJtJBjem/XkiM
	 QlK6HUuk95YTQ==
Date: Thu, 26 Nov 2026 16:33:51 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] power: sequencing: Allow desc=NULL in
 enable/disable stub functions
Message-ID: <ujnzfnj666gkvu6zdpsqt7qovc65fnthxirlykeinjcgy6islj@ya35vuxrl4cp>
References: <20261126081155.501493-1-wenst@chromium.org>
 <20261126081155.501493-2-wenst@chromium.org>
 <CA+V-a8tqzDTbMu5375vub=DBHmpJWW2TvUGKfsuPf_gjpSuC=w@mail.gmail.com>
 <awgoaQTep07E_w6i@shikoro>
 <awhNqrbdy_pJ9r0T@ashevche-desk.local>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awhNqrbdy_pJ9r0T@ashevche-desk.local>

On Thu, Nov 26, 2026 at 05:18:02PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 26, 2026 at 01:39:09PM +0100, Wolfram Sang wrote:
> 
> ...
> 
> > > >  static inline int pwrseq_enable(struct pwrseq_desc *desc)
> > > >  {
> > > > +       if (!desc)
> > > > +               return 0;
> > > > +
> > > >         return -ENOSYS;
> > 
> > Bike-shedding alert: What about the ternary operator? It is nicely
> > concise here:
> > 
> > 	return desc ? -ENOSYS : 0;
> 
> In long term this may grow to something else and ternary would be harder
> to read. (Gave a comment with my true love to ternary and Elvis in particular.)
>

I prefer an explicit early return.

Bart
