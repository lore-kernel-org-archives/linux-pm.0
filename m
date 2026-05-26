Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967F3DB651
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788897; cv=none; b=BidjgRDVMCNCHMBK0cPBYyGrdZ4IaJvZ4P+xJhiKc+Pwy6fawamfwg1UjJHJDHF/z7B0v+UOq3/qmMfFPTOmuZAP6KeUdD09g2qg7dBbN1pH7gK2T2hp/0PN1R72KPKC4fvVghWSHBU/haAsrelCWJQwDvO7KQyHgeCYOxfArrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788897; c=relaxed/simple;
	bh=6xgiU7UHk0fyH8OtVpuJExgRt0VbjZpUEjJ/frbR0FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9Vb1Q8BglISZCBvwSG65aUuqyPC2gA4F4+LYWNrXvo5MtR0mGDmrTza0hC/1TUwbP59POZIOaelScOvHaewjXx1XLyh+nPlbnBhB9u1yWvGVHMfDih+DKLdTwNip040stl9z60uxqlSXXbUpRfB26tlj+mACK1vXFdzXF7PZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVZlTsys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVZlTsys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EDE1F00A3F
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788895;
	bh=6xgiU7UHk0fyH8OtVpuJExgRt0VbjZpUEjJ/frbR0FA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NVZlTsys9BWdtHzTDLDn5rfEhTbtLxyyJGzF9yhWAnDRt41GZGQkchM1KVUs4BE+V
	 1ZfotqeJQVRfUIDBM6RJ2k1gVu2eBPsu9O+FeP6SXfWF/fNjDthrrS7mHTkNCjm0tu
	 z8lXLoRuCz3oM81VIG4KNypW0wZMBD+C0W5bBLTTQrUkpCxFSnVeLs5s6QmfusqyrK
	 2DZ+l73jxUWSahhHCjeNnze7jpJ4/4lfxQqN/demRkAnfOOJj/aQiLbtdK7j/e7uRU
	 bs0KQ9vbAJ0Tk2r4RTaxzHBYygw2z2HFkI95yphzgxLV8SHOsGkb3Hm9fXVZm2Odf1
	 r7Hx6MJKvNEGw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-392445f11c5so105831711fa.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 02:48:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/FBHEPZiazyM/puacEzPbW7r+fA4SgBdAzEw3dxdJBCXs1DFVUJFb4hepyJ9+H3hWyu6KngYq7mA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQs04+348CPcpxYmpRDB6mDrlKw8MVFJxJ9IsUnoQkZrGt1Cv
	ZQ8k+1PU5d07C3LmSdMP3T4ZH9mMc8bqQ8by/pyJNhZzLoqn3HVxe9s9IKdO4jzXVkzlpKfsBM1
	QDNBnQzimTtJnetV2MZ4yr3RQ3v5srEAZtoTT4tFcJQ==
X-Received: by 2002:a05:651c:20cd:20b0:38e:94c6:b706 with SMTP id
 38308e7fff4ca-395ca1c8679mr43054031fa.7.1779788893678; Tue, 26 May 2026
 02:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515090149.3169406-1-wenst@chromium.org> <CAMRc=MdnjRRMVzxPkkrPhQ4dz7rsK8-HKUp9cQ0z11apL3escQ@mail.gmail.com>
 <CAGXv+5HC3dqgcE3KnKzakHHWFHB6m_X42orOkNUvZvp=SL_O8g@mail.gmail.com>
In-Reply-To: <CAGXv+5HC3dqgcE3KnKzakHHWFHB6m_X42orOkNUvZvp=SL_O8g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 26 May 2026 11:48:01 +0200
X-Gmail-Original-Message-ID: <CAMRc=Med-_0GSYzoFBRiwFzBCK0DZqJD8_SEBxi+zwR20GS-HA@mail.gmail.com>
X-Gm-Features: AVHnY4JnWCndh1h2w4rgycQThCJN5e2R-74Cpg5S6rpAEGBFVHeaeEFDCnabd1Q
Message-ID: <CAMRc=Med-_0GSYzoFBRiwFzBCK0DZqJD8_SEBxi+zwR20GS-HA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 10:06=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> > >
> > > I expect some discussion on this patch, because a) it adds some
> > > OF-specific code into an otherwise generic (core) driver, and
> > > b) it doesn't yet handle USB 2.0 / 3.x shared ports; it ends up power=
ing
> > > on the port twice, which negates the port reset part.
> > >
> >
> > I understand that you do this because the port device has no OF node
> > assigned. If we wanted to call pwrseq_get() for the port device, is
> > there really no other way to associate it with the correct pwrseq
> > provider?
>
> I suppose we could tie the "port@X" node to the usb port device, but
> AFAIK no other subsystem does this so we would be introducing a new
> pattern.
>
> In the M.2 pwrseq driver, we would have to match by port node instead
> of its parent device node. We may end up with different behavior for
> the USB target vs the other targets.
>

I imagine, we can check the bus type of the parent device to know if
this is USB?

> Also, the "port@X" nodes only exist for the OF graph connections to
> connectors and/or muxes (this series doesn't deal with the latter).
> For directly connected devices, there is a "device@X" child node
> directly under the USB hub node. That node is what gets tied to the
> the USB device.
>

Is this a problem? I don't think I understand what you're saying here.

Bart
