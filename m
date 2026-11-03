Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697261;
	b=E+sBaKWJKm0XPvtSuxhN0F39NmbQAghu1n+lgWL8k+19/zBaBQwytxMiC9YBx5o4CS/q
	 Sn00Gx15EVbcXObehxPNpL+rtKX2kE5E3bowgCZf9WYv8qcVxKpPJmVQVn44482ew+ghj
	 j3DCqZEE8I2cy87U9IAKqJTZ17BP0DYKoiNzo7UuLpAy9A8HDbcU9PFMSXMUepFxUoKPa
	 Mh4p44DcCHnlnKPkMFpZnW3KqkqSUYxUB+65R6EZk/FD3WdddZg4EySp46O6NTXFKtmM1
	 x9ifW47b2sOXGNjttt1MqtZW8vkjasU6cGq0UJup+9yK1vngi7lH4whI9hIbB0iPLWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697261;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=xCKzQnE8sR8qGnyIMcveJ64Ln+A33qIBzCr/8Ncna5s=;
	b=vEW3OyDTqdkJxDAMVs/AGBsZ+ZcEjrvA+di6RWih+AcWhEC2MTA4s7NNMLqYfmqAcwEw
	 QV9FPEvtVgy2LNfRepoEaTHP6riKmLZczDwVR+bN9P0H81+NuoTE1RurpU2JEAd4mlTD9
	 8m/Nz0UkajwnLLICi6I8W7BQ+q0KP2h72a4kuUYREkEWQokPdZLTtorUjqjKyhz/s4w17
	 cN31zncz8rs5Dr9UwfE2UoNIAK1pYUqw7fRLPs5nt4SPtabgADAEnwPc5tAvvXc8IoQI8
	 gAFK3yTUwUeK+Z4Oeur2LciZg9yjly0HMwku0c7+bg9hQruLffqZU64L/XY90lxwCJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Az16B1NT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B4606A324;
	Tue,  3 Nov 2026 09:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 794B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Az16B1NT
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A9E7320103C;
	Tue, 03 Nov 2026 10:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793697257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCKzQnE8sR8qGnyIMcveJ64Ln+A33qIBzCr/8Ncna5s=;
	b=Az16B1NT/o8u9bVz4Vr+qtoUJMO3XnS5rLrEvivYNfOeg/KeYGFKJa8LvN/V523v7lH/79
	dKjT1Dj0L2tkZoPLOQYbfdaLEiI4+49lt+e0MAxy8rJLme1LJMizWuHIj3IuJqhIdplKzl
	bLdN24LfJoTlqzgYGPzLR7nqq8CoC8dBkvg2VKgJL1LKp2XvwAUqf3Q/cBzK8GgB83tSLq
	iJQT7CebcWCXUevcw24RNeD62XHc1PVw01VapBpiNKtOAGGnKnBK9rgWhkCY3EnEB6J/J/
	TZDqOnUvRwt7btSCyUqCt3QOIkm1cCXRPqacLNsX22HxcLv1l68DnXQC2AxoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793697257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCKzQnE8sR8qGnyIMcveJ64Ln+A33qIBzCr/8Ncna5s=;
	b=IeFNgT0IVHiRepot8IhD9+8MZxksgKp8QtZ0Q+NkRQKSzRW3F1st38bGCwY408Qds7atpb
	ASrtbeQfpuAnNb5kkd7A+fbJ8ddafXqTtv0cWMMKVkgzhTPcwxdGEQURAVF1Bq9QZ0rgTg
	9Vy3wLWnvjju/NCLna2Jd9dKEalVQTk8EXyJGFG8zWnPj2aNmEqFl0MlVN2ji7XxzsVrsT
	WQO+2MIY9f1v0UNM0UDw6LyRIoKSSMVnq3fAMy5ZR/NKyOiIELMNjRr/xIJYmGGI4VnjHD
	4JiOPXyDQ1eksy1+MAANficJxkHsVtWHcA8cTuH9WeEIu9XiQesit2LyMZgpcA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793697257; a=rsa-sha256;
	cv=none;
	b=MqelqDHcu32UrtpOsw3KKZGLgLnFSR66JSukkrD0iM4rky+LVtOW4DCdHiERKyp0wwyUUR
	GpeDDOCAgBKM7K8U1C36Gv6NbS5q0c332HXHoL93qzyNgEhptnCF4Q7rWM42PJSwcutHq7
	hj+C8jujlg6ifEOlQI652m1MHSw4+zhWckIyPos4F8hrlN7763yEA8xzS9Aogizms7TF/z
	N9uxspC3AcdMXAscx5zzdN40nfJrBNAnohLxQCGiVeRKE+pr0x0NTROgrjV/fgvjOKINoW
	XQbjuGVpvakYsEUAjDsft9Ml7OavlmNny2MoEjyxe4tOnmtQ082HCtQPFGF80g==
Message-ID: <88963fd1fd87123496a55e2002bc8b0dc2466bd4.camel@pengutronix.de>
Subject: Re: [PATCH 6/9] reset: google: Add CPM reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian
 Masney <bmasney+clk@redhat.com>,  Jerome Brunet <jbrunet+clk@baylibre.com>,
 Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>,  Peter
 Griffin <peter.griffin@linaro.org>, devicetree@vger.kernel.org, Tudor
 Ambarus <tudor.ambarus@linaro.org>,  =?ISO-8859-1?Q?Andr=E9?= Draszik	
 <andre.draszik@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Radu Rendec	
 <radu@rendec.net>, linux-arm-kernel@lists.infradead.org, Mariano Marciello	
 <mmarciello@google.com>, Douglas Anderson <dianders@chromium.org>, 
	linux-clk@vger.kernel.org, Jakub =?UTF-8?Q?G=C5=82owacki?=
 <jglow@google.com>
Date: Tue, 03 Nov 2026 10:14:17 +0100
In-Reply-To: <aukyyYhDCBUdIH16@google.com>
References: <20261026214359.3122870-1-briannorris@chromium.org>
	 <20261026144346.6.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
	 <8d57f0a1dc8a07838bf1320f9b79588196264ff5.camel@pengutronix.de>
	 <aukyyYhDCBUdIH16@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mo, 2026-11-02 at 17:03 -0800, Brian Norris wrote:
> Hi Philipp,
>=20
> On Wed, Oct 28, 2026 at 03:03:24PM +0100, Philipp Zabel wrote:
> > On Mo, 2026-10-26 at 14:43 -0700, Brian Norris wrote:
[...]
> > > +DEFINE_DEBUGFS_ATTRIBUTE(goog_cpm_rst_assert_debugfs_fops, NULL,
> > > +			 goog_cpm_rst_debugfs_assert_set, "%llu\n");
> > > +
> > > +DEFINE_DEBUGFS_ATTRIBUTE(goog_cpm_rst_deassert_debugfs_fops, NULL,
> > > +			 goog_cpm_rst_debugfs_deassert_set, "%llu\n");
> > > +
> > > +static void goog_cpm_rst_add_debugfs(struct goog_cpm_rst_debugfs_ent=
ry *entry,
> > > +				     struct dentry *debugfs_root,
> > > +				     const char *name)
> > > +{
> > > +	struct dentry *d =3D debugfs_create_dir(name, debugfs_root);
> > > +
> > > +	debugfs_create_file("assert", 0220, d, entry,
> > > +			    &goog_cpm_rst_assert_debugfs_fops);
> > > +	debugfs_create_file("deassert", 0220, d, entry,
> > > +			    &goog_cpm_rst_deassert_debugfs_fops);
> > > +}
> >=20
> > Please drop the debugfs functionality or explain what it is needed for.
>=20
> Ack. I think I'll probably go with "drop", but some notes:
>=20
> There's no real way to test and validate a "reset" driver without a
> consumer. There is no direct (even for debug) interface into the reset
> API, unlike in some other subsystems (e.g., GPIO). I believe the main
> purpose here on Pixel drivers has been hardware+driver testing, so one
> can test reset functionality before hooking it up to real client
> drivers, and without adding fake drivers or extra debug code (a la
> "printf debugging").
>=20
> (One might observe these results either via /dev/mem-like access to
> registers, or even through external debug peripherals/consoles that can
> monitor the status of the underlying component that is being reset.)
>=20
> This all would generally be in an early hardware bringup scenario, so
> admittedly it probably doesn't have as much of a use case in the
> upstream kernel  -- it's a long shot for this kind of hardware/product
> development to *actually* work directly on an upstream kernel, with
> upstream drivers.
>=20
> ...but if I were imagining a better way to do this without bypassing
> reference counting: perhaps it could be useful to a have a
> debug-oriented "reset client" driver, that could bind to arbitrary reset
> devices, if they're not already owned, and expose a sysfs or debugfs
> interface like this? That could fill similar use cases for this sort of
> hardware testing/validation area.
>=20
> But anyway, I understand such a proposal should definitely come
> separately from this driver submission.

Thank you for explaining anyway. With that use case in mind, I think
"drop" is the right choice for now. This functionality can be
implemented in the core and use reset controls like any other consumer
driver.

regards
Philipp
