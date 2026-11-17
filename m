Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885115;
	b=F10sQG+/Q3GJDb8lQNkj39x/p6mmLFcm57neeMhObKq7mmW3n8JXTOLjo8oZaln3cZ53
	 T3rqzVF7Ok+k60zlpbPQZjSXWP/+Bt43PKA1E88KPffxjBjuWHtIcWpwlM6lfeCE40ldI
	 6mk8MmEdBIiyMAFVdJQoMHys1kcArMNL+oUMdlwYEBJV7FIRa9rgYlK+SUSWK9ySp3WoH
	 vJOqEGZK+WxO9HMbkSrfxAlbWlOzA0KqoTq/FQ7jRJv4+BPTQO/ExmXgG9yVUXy/f6NFA
	 WsV8IDQioStprjEE13G0ZMoU/FMSC12c6TiROZo2AcU7ozzOgsyxzQ4p+Pwb1U/+M+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885115;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rAo21lH5YkrWf1H9lGvy6n3laU/lKZk+uFIHu6Dox1g=;
	b=YbgvJlgPjzUGPUwvvy64452dW3fGBDtrhHah7JwEjBjzv+dULg2C9wiE7/uelOP1baJr
	 CQHOhD/ETCjljHOnrVD0TTd81/HIWF7XbwvfjRYJiEx3QErOmhCZ5Ul1kDkID8m91vC/g
	 aSgWk16jPmKF0YYlGdhJz8uo4lMQsuY9/IiP4dCc3FCTG3mpokJKDTvyoDUZXyF/4IY/H
	 lEc7e8omDGxQ7dMfJvpaglENVWuU/5vwXre/uCD8+gg84JrpnC7Ypll7tg2SfVzOWQYvt
	 gdYmOx/sYnjziOmSQxf2LI2FjmRlGQvxCNvgOxxdXNfEfhjeqNzi7bUwz4fFswhOTSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMI16+oo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B88606A31C;
	Tue, 17 Nov 2026 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMI16+oo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250CE1F000C5;
	Tue, 17 Nov 2026 03:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885115;
	bh=rAo21lH5YkrWf1H9lGvy6n3laU/lKZk+uFIHu6Dox1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GMI16+oojz8C1YIHwc9EClS7kM1duCpaGdLZaKC5ItQpRUHUo98IPmOFJU4E9Zh1D
	 9hCNvx4OGYYNFAohF5P7+GAicUluZlkOX4rKx72hFy1lYNS1BD3UkvCueZaDvN+844
	 SPgUaGATijP3J0IqOBQpC4JxDb52hP3cTVQFkPN9KsgQAEo4eh/i7C7PIuDaMNYtuX
	 ytJf7lb4FPQhw+mDBT4y5pAUwzilzPBM0XkUN/q4PtmDFwGV+uTBHf5x9GVG3lrOpP
	 X7O7b6STFwaRk4uwdtqWyq56Td9IBCxCObdRDuUvjNiDMGiBe/y7oHnLLImP4HPVtz
	 Vbl0S0PXiiNEA==
Date: Tue, 17 Nov 2026 03:11:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "David Lechner" <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Laxman Dewangan" <ldewangan@nvidia.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Hans de
 Goede" <hansg@kernel.org>, "Jens Reidel" <adrian@mainlining.org>, "Casey
 Connolly" <casey.connolly@linaro.org>, "Val Packett" <val@packett.cool>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] thermal/drivers/generic-adc: Allow probe without
 TZ registration
Message-ID: <20261117031147.40f2ef65@jic23-hlaptop>
In-Reply-To: <DMWH7VNNWDQG.1BM1P88WUJZT9@fairphone.com>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
	<20261113-bat-temp-adc-v3-3-743979a8fd90@fairphone.com>
	<20261114001552.3ae8f05e@jic23-hlaptop>
	<DMWH7VNNWDQG.1BM1P88WUJZT9@fairphone.com>
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

On Mon, 16 Nov 2026 09:02:10 +0100
"Luca Weiss" <luca.weiss@fairphone.com> wrote:

> Hi Jonathan,
> 
> On Sat Nov 14, 2026 at 1:15 AM CET, Jonathan Cameron wrote:
> > On Fri, 13 Nov 2026 16:56:44 +0100
> > Luca Weiss <luca.weiss@fairphone.com> wrote:
> >  
> >> If the devicetree node is not referenced in a zone under /thermal-zones,
> >> devm_thermal_of_zone_register() will fail with -ENODEV.
> >> 
> >> Since the driver is now also registering as an IIO device[0], allow the
> >> probe to continue without the thermal zone.  
> >
> > Papering over problems, or expected path for some devices?  If it's
> > expected path we probably don't want to print a message with the
> > word failed in it.  
> 
> Expected path for some devices. Should I make this into dev_dbg then or
> remove the print completely?
> 

Either is fine.

> 

