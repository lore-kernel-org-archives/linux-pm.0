Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC233403F8;
	Sat,  5 Sep 2026 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607931; cv=none; b=bDO6cH80FkxUF+GSOwPv3Up7DdFCSTRKZa7HKnBFQNpitdUVuoYglGkSNSy+ilX6MGiwAeaZotHpH8BdprQ9Mr1HUGfp9ZF/8tPWGPqlWBzyEjuuPKebzAyRqSuVMr3xcZRm/qB4TFS74FoHLcy9jR8nNLsxvrNW4ywJvf4mLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607931; c=relaxed/simple;
	bh=KPgCAQDaCR5IqGlKcjIldAVhoYnTXvtlBae0nNTIR90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxtK6ujYqY0+PBxtPKoIwi85eUb0VIwPN4UaNCAlO0ma9WCMDPFpibwSDoGqCAYof/VrL7TfHjlKMEaPXz1uR7oCNuGDjM8YcEDfym8Em39oJsP8rjnQwcMwIVTtaKAckiWcfnivU1UVPAaT6o7yfsemdrHcy4jRgCAzMJTe//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EI1FmdZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EI1FmdZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383661F00A3D;
	Sat,  5 Sep 2026 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788607930;
	bh=u1mCSdap8EpKqZ+b8GT203WeV+0ASGDGtnDxfJT8fAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EI1FmdZQETscHvLCnLj3TD8ezP5sTSS0FaYeDegsBiKQEd93ERGxLuzIFoAqmkAxT
	 QVFYqZmzF2NfEN8L+y6m6ckPbreoexmSsO+1HDG8wxwIg/TcuKsYKqP/Sk0Yko1VnO
	 caGI/HV1rlAf59FK6aT+GM6UYEhyQC82iyil5fTI=
Date: Sat, 5 Sep 2026 13:30:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v8 07/16] usb: core: Move struct usb_port and related
 APIs to port.h
Message-ID: <2026090516-nutshell-handiness-37f9@gregkh>
References: <20260904084158.1341550-1-wenst@chromium.org>
 <20260904084158.1341550-8-wenst@chromium.org>
 <2026090430-botanist-ungodly-0299@gregkh>
 <CAGb2v65MSxL+r+wqMjPKVSh9aS1gkn8og6oBinSXDdipnoOyCQ@mail.gmail.com>
 <2026090433-chair-tidings-5c99@gregkh>
 <apvQlBEgHOW9MCxN@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apvQlBEgHOW9MCxN@ashevche-desk.local>

On Sat, Sep 05, 2026 at 11:19:32AM +0300, Andy Shevchenko wrote:
> On Fri, Sep 04, 2026 at 07:52:37PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Sep 05, 2026 at 01:24:20AM +0800, Chen-Yu Tsai wrote:
> > > On Sat, Sep 5, 2026 at 12:47 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Sep 04, 2026 at 04:41:46PM +0800, Chen-Yu Tsai wrote:
> > > > > |struct usb_port| and its matching container_of() macro should live in
> > > > > its own port.h, matching the split we have for .c files.
> > > >
> > > > Why?
> > > 
> > > This was requested by Andy. And to me it sort of made sense.
> > > 
> > > > > Move them as described. Also move usb_port_is_power_on(), since in the
> > > > > next change its |struct usb_hub *| parameter will be changed to
> > > > > |struct usb_port *|, and becomes a non-static function that only
> > > > > references |struct usb_port|.
> > > >
> > > > No, please don't do that unless you have a really good reason.
> > > 
> > > Which part? Move the code?
> > 
> > Please don't make a new .h file.
> > 
> > Moving the function might make sense on its own if you need it in a
> > different file later on, but do a move only, and then change things if
> > you really need to do that.
> 
> Isn't this file to break possible circular dependencies?

If so, that was not stated here at all...
