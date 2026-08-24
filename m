Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03136340A6F;
	Mon, 24 Aug 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590704; cv=none; b=YNWE0RG43gkiTQoXsazeYxAvgw/pMb+8riFGAnHOOV/28R5NDbU/qbI5XTO7o/sZtL5q6wQj17AkOH7lR1R0uy9Mw9yuSJLv+1/Ax9YJuFxpE99kBOqCev7FaVyI3nPJzuFJtbtLI7KLHozLg8UgXtqng2Wc4FfDW7WAU1Uatvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590704; c=relaxed/simple;
	bh=nXeV9O76gPmw3lmTBuEd8ScT2ZzgR7QG5eqQkhmkWNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YteHjV/trydIdjELjKRh6flbJVfHaR5S3syHjrscbuUV3jDbiVAxvzqnFIBTQeTAyUhdSZeBa5rEK1Xwa56QD1ZcKRFpzy8rB61rJTSqZTiWrM2ZwXMola79B7SQuOokWWjldT5cEf+VMWFlIAE+PQQV1eE1vAsR4ZUsxr32lQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lPWdxE/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lPWdxE/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FFB1F000E9;
	Mon, 24 Aug 2026 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787590702;
	bh=P2CXq+y1GMxq88DU8XiGGhuM8F5nmDCYXtimNhHu3rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lPWdxE/Bc+Fw8WuquGG7uth+btHc635dkuetKWhT9uNaat2xEKuymIh5sn+GD5dZk
	 poE/gOQlmzXM55qg4VPoAVWL6LBs5lbXwSu+4kQdcbawjP22gV7c3OLdq+xggpqbaZ
	 iwMk8A+K2irr3zoEjeJThOeTIL6MFQwInbKvN9YQ=
Date: Mon, 24 Aug 2026 18:58:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH] thermal: change thermal_class to a const struct
Message-ID: <2026082446-lagging-ominous-0a35@gregkh>
References: <20260811061530.21789-1-jkoolstra@xs4all.nl>
 <CAJZ5v0i0PQEMTOT6UqWO87jCdV539ns-KcP69n++eQsz_NG0zA@mail.gmail.com>
 <2026082411-flask-rewire-434f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026082411-flask-rewire-434f@gregkh>

On Mon, Aug 24, 2026 at 06:56:05PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 24, 2026 at 06:09:33PM +0200, Rafael J. Wysocki (Intel) wrote:
> > On Tue, Aug 11, 2026 at 8:17 AM Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> > >
> > > The class_create() call has been deprecated in favor of class_register()
> > > as the driver core now allows for a struct class to be in read-only
> > > memory. Change thermal_class to be a const struct class and drop the
> > > class_create() call.
> > 
> > This has been deliberately changed the other way around not too long
> > ago, in commit
> > 
> > 34f54003643e thermal/core: Allocate the thermal class dynamically
> > 
> > and it was then argued that it would be better to allocate the class
> > dynamically.
> > 
> > You seem to have a differing opinion.
> > 
> > Is there any plan to remove class_create() from the kernel?  If there
> > isn't, I'd rather stop this back-and-forth dance and leave the code
> > as-is.
> 
> Yes, class_create() is going away.  I didn't notice commit 34f54003643e,
> but that's the wrong thing to do here.  We should just revert that
> instead.

And we are down to only a very few callers of that function.  I'll sweep
the tree again after -rc1 is out, apply any pending patches, and drop
the function entirely then.

thanks,

greg k-h
