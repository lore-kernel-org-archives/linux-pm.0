Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5F490BE0;
	Fri,  4 Sep 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544707; cv=none; b=sn99m8Tvy46sMW+OdANyzkWI3MiP0ZLB3VDzgRSM2aPEGuZi1C+loMXo0reQqi0FjpFmS+iwI6Y+alhJe4FGEtvpCOFSZH4NwrawnhBR7bTAtgeLlaXGNIa0EjSFBsBd5zymkpLZq6cbhByylG4/mG7qv9x0KGrYBX/l3V8OyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544707; c=relaxed/simple;
	bh=HTjFSxIaUz0HkG0Fqpc3XJlOucy3l+W4m0MAeJmz5BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXz7Vxbw1glUvM/1pF08J23nIZSq67n6nSK9sSPv74xtXRFsz2BzAkYZxXLsEbFfd8U1JAUw3WukcOpBNU9jnf987n24lpM+ubxJvZR51iyL/BNInR9+oNA9n981rFnP86Q4BJEKa3vNYFBgDMx5fDrK6IlLorJbtrS0375qLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vVcWPcqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vVcWPcqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49421F00A3D;
	Fri,  4 Sep 2026 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788544705;
	bh=rP0jvIe50D9VMNBI5Koq/QnFNW7rOKsTaV7j4xp9Y8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vVcWPcqG1059ybsmrz21hgN6wQuwVgT6uzFHmLEnROtsmnN/CAYwVKSDtG9lGAiEU
	 tkd1yZrHUaZHJ3eumLByHfJe9TNCknpujWUJKGpAWuMus+fTvh1G7TZqTS6TzxZoq+
	 MFxyhH9d1b8/dxyRr8Dhs80vd4pcoiD8qcdKqe90=
Date: Fri, 4 Sep 2026 19:52:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
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
Message-ID: <2026090433-chair-tidings-5c99@gregkh>
References: <20260904084158.1341550-1-wenst@chromium.org>
 <20260904084158.1341550-8-wenst@chromium.org>
 <2026090430-botanist-ungodly-0299@gregkh>
 <CAGb2v65MSxL+r+wqMjPKVSh9aS1gkn8og6oBinSXDdipnoOyCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v65MSxL+r+wqMjPKVSh9aS1gkn8og6oBinSXDdipnoOyCQ@mail.gmail.com>

On Sat, Sep 05, 2026 at 01:24:20AM +0800, Chen-Yu Tsai wrote:
> On Sat, Sep 5, 2026 at 12:47 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 04, 2026 at 04:41:46PM +0800, Chen-Yu Tsai wrote:
> > > |struct usb_port| and its matching container_of() macro should live in
> > > its own port.h, matching the split we have for .c files.
> >
> > Why?
> 
> This was requested by Andy. And to me it sort of made sense.
> 
> > > Move them as described. Also move usb_port_is_power_on(), since in the
> > > next change its |struct usb_hub *| parameter will be changed to
> > > |struct usb_port *|, and becomes a non-static function that only
> > > references |struct usb_port|.
> >
> > No, please don't do that unless you have a really good reason.
> 
> Which part? Move the code?

Please don't make a new .h file.

Moving the function might make sense on its own if you need it in a
different file later on, but do a move only, and then change things if
you really need to do that.

thanks,

greg k-h
