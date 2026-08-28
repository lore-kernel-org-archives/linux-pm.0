Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE463A9D8D;
	Fri, 28 Aug 2026 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787956976; cv=none; b=Dg7iL4zKpTcZgFMCPKse21w/uTCICAXR1D1+lNglaldh10Azxvc7Ue5pAWAn/UcamC21YwjG3sfnUjMJBZJ0Z4jG3udeSwUueBod/dMtqxRcqrK60GRTH1kLfEfSWiNF01mfr/uRbBKKDfEyRAlzQo2G8+AC9RGSppVagme9Vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787956976; c=relaxed/simple;
	bh=+gKrXaV0K5LwXD+YCGILsWOokn9aA+NBo2sD9gEb2bE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPX2k4WH2+Z1PBpitN1W4ezAqv2xsFJ/Fj5XhLbG2jj8uoZaHTjPMMLwBXS22JDuxXCqVH6w9OyibJGTMPehb2wM7UpBIOesL0s2T7+Y9Y55vl4QCcQGOgP0ccwEBU3/DstwV7EiLmanjEUyPu1iR8EiFG3MRgTLFSUsn1HsJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLmkZPNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLmkZPNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD8E1F000E9;
	Fri, 28 Aug 2026 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787956975;
	bh=5hKLPOq36vmvfKX7z2ySw0CgWhGkB5LM/+RY4mcIPvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dLmkZPNm0/wL1iJu/NYp06T3dXGkqZiXLd3UHbFE7WbeXUBwNAqujxgiBS+UAlf6u
	 5zkI8gqxM4PcChM7o6zIKiqi9+FjvdsQKxPbx/0mgXYGnyIsHwS5k9KtDVP185cAw8
	 kZKOtwuww4rv+sIy+3LaC6WIvL3XT0TfZmVOsTpi6Oo6A2wdQKXCXXuhYCAUcqPd22
	 awIDrtJCMpnNEcnWDFgr6kPSH/BuqA+Mb3ud3rxIgp5F6OIrwBGEaxp1XPO79l9S0t
	 91KuyX9RzfCXdCT0kQClW2UDSarGXVjDwABlLkjFdJp5XKvT3ZD28XjQcSuF2G0Wtf
	 Wzz3TTTFaeIAA==
Date: Fri, 28 Aug 2026 23:42:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Amit Kucheria
 <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Guenter
 Roeck <linux@roeck-us.net>, Vinod Koul <vkoul@kernel.org>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/qcom/spmi-mbg-tm: Import IIO_CONSUMER
 namespace
Message-ID: <20260828234249.0c729e5e@jic23-huawei>
In-Reply-To: <apBLL4x0h2kUaz-n@QCOM-aGQu4IUr3Y>
References: <20260827103555.883018-1-shengchao.guo@oss.qualcomm.com>
	<apAzGkXpnMYHcnqJ@ashevche-desk.local>
	<apBLL4x0h2kUaz-n@QCOM-aGQu4IUr3Y>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 22:35:27 +0800
Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:

> On Thu, Aug 27, 2026 at 03:52:42PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 27, 2026 at 06:35:55PM +0800, Shawn Guo wrote:  
> > > The IIO consumer interface symbols moved into the IIO_CONSUMER namespace,
> > > so consumers must import it explicitly.  Without it modpost fails on  
> >   
> > > 'iio_read_channel_processed' and 'devm_iio_channel_get':  
> > 
> > iio_read_channel_processed()
> > devm_iio_channel_get()  
> 
> Sure, will update.
> 
> >   
> > >   ERROR: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses
> > >   symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but
> > >   does not import it.  
> >   
> > > Fixes: ebf1d03dab96 ("iio: inkern: Use namespaced exports")  
> > 
> > Shouldn't this be backported to stable kernels?  
> 
> The offending commit just landed on mainline during this merge window.
> So there is no stable kernels concerned by this.

There is a fix on the thermal tree. I though that was enough. Maybe this
races with that fix going upstream?

Jonathan

> 
> > 
> > ...
> > 
> > Code wise looks good.  
> 
> Thank you for the review!
> 
> Shawn

