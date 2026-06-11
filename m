Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C37339858;
	Thu, 11 Jun 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196142; cv=none; b=nJGtbyv/bCYtiRWCqRaS0PnFoUiAZvx0oS/kP02MYLwBhE51Ca1Kj+pp2LbsPKTdYO6+9dA6cyxI+9pQsr0ASRbWdiMAzFurhyT00Qu0mHAP3YpiI5uBP8H6iZfuMpJMxIlxTdFos+Xjgk3KzKBdZ2V7BKMJjRXuvJnRDarYlVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196142; c=relaxed/simple;
	bh=4EvDpNGjZ48U64aeTEMEtfMiTK/jKSwmFRilJYIQr8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGUzLB+9Ux8SbNzcXMj2+AAq+//H4fYcTSl9+aV8Yt4tDbCZngdatV7TZGDJBaAEFjDjHKbHLC0DDz55j/VqQ4IxVdqVNkFhivu4/p68T48b1x45kIq3SKVGAa3wZWFALlS4VZ4VOUuHUXhOH5RahjpRYT+0RCm336+5hlrK9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK41nXFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK41nXFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D104A1F00893;
	Thu, 11 Jun 2026 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781196141;
	bh=sy3HEPhYZD7bIlmZpQj2exwmeWCZxbjTt4XXdiBMCvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DK41nXFWpbBA5b/YjFCBpAsWZ7RKjzpM4n1YymbqWSHskDYdtdaqNMUdb96bIdrwk
	 pZfqo7AxONa2HGv5StoFWjSZN8hcy0CTcDt8B34i+Gx50ZH9vbJDyVeh19BwfrSbVK
	 lzTnsyShyBLjblGLMSoqZ5uh5N16OFPXKsQu0DqWYxqvmg+7sZTm5D0+Zkj0vnr8/O
	 grzW+p+Za0InJZRBdvk64lCx8jCy6mUzz7tI1LD9seZFvrG38gviha2xj5gFhhwJ0I
	 53XZBMGe2OM+XXRHlsZmooLO74H6pzF6MBJh2E232LARjxoSGvYrLJmuMJefPx80SB
	 Y4zoePvXDEd7Q==
Date: Thu, 11 Jun 2026 17:42:11 +0100
From: Lee Jones <lee@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	John Stultz <john.stultz@linaro.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v22 08/13] mfd: core: Add firmware-node support to MFD
 cells
Message-ID: <20260611164211.GD1212816@google.com>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
 <20260514-arm-psci-system_reset2-vendor-reboots-v22-8-28a5bde07483@oss.qualcomm.com>
 <20260521112638.GD2921053@google.com>
 <CAMRc=MfqaCjiALZyVBHQs=Taft1M9xmNTFvQHWPrd5PgcTfJDQ@mail.gmail.com>
 <20260521132419.GA3591266@google.com>
 <CAMRc=Me5QS4xA3PJWXNuRP1N_C+w3sP9ZvqH36GNh2Ebc9hwcw@mail.gmail.com>
 <20260521162705.GH3591266@google.com>
 <CAMRc=MdiwwX_XH7JFW8HuLvYA_ao50fjj0Oip2WMM4QROHRiFA@mail.gmail.com>
 <c034a7c5-7215-4e96-80cf-ef0c51f8291b@oss.qualcomm.com>
 <81680397-3bbd-4f66-9166-546c8fe753fc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81680397-3bbd-4f66-9166-546c8fe753fc@oss.qualcomm.com>

/* Sashiko Automation: Reviewed (0 Findings) */

On Thu, 04 Jun 2026, Shivendra Pratap wrote:

> 
> 
> On 25-05-2026 15:04, Shivendra Pratap wrote:
> > 
> > 
> > On 22-05-2026 14:38, Bartosz Golaszewski wrote:
> > > On Thu, May 21, 2026 at 6:27 PM Lee Jones <lee@kernel.org> wrote:
> > > > 
> > > > On Thu, 21 May 2026, Bartosz Golaszewski wrote:
> > > > 
> > > > > On Thu, May 21, 2026 at 3:24 PM Lee Jones <lee@kernel.org> wrote:
> > > > > > 
> > > > > > > 
> > > > > > > I suggested it because of its flexibility. The alternative I had in
> > > > > > > mind is something like a new field in mfd_cell:
> > > > > > > 
> > > > > > >      const char *cell_node_name;
> > > > > > > 
> > > > > > > Which - if set - would tell MFD to look up an fwnode
> > > > > > > that's a child of
> > > > > > > the parent device's node by name - as it may not have a compatible.
> > > > > > 
> > > > > > Remind me why the chlid device can't look-up its own fwnode?
> > > > > > 
> > > > > 
> > > > > Oh sure it can, but should it? I'm not sure it's logically sound to
> > > > > have the child device reach into the parent, look up the fwnode and
> > > > > then assign it to itself after it's already attached to the driver.
> > > > > This should be done at the subsystem level before the device is
> > > > > registered.
> > > > 
> > > > Leaf drivers reach back into the parent all the time.
> > > > 
> > > 
> > > But drivers don't generally assign firmware nodes to devices they are
> > > already bound to. This is racy as in probe() the device is already
> > > visible to the system. There's no synchronization of device property
> > > access - properties are assumed to be read-only for a registered
> > > device.
> > 
> > thanks Bart/Lee. Any pointers to take this from here?
> 
> Hi Lee,
> 
> To take this patchset forward, it would be helpful to get your views on
> fwnode based addition in mfd-core. Maybe, a member like "*named_fwnode" in
> mfd-core and then a lookup logic, or any alternatives?

Can you please make your best pick and resubmit the set please?

I'll comment on a fresh set with fresh eyes.

-- 
Lee Jones
