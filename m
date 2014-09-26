From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] PM / AVS changes for v3.18 - v2
Date: Fri, 26 Sep 2014 15:40:55 +0200
Message-ID: <3441765.RqZP2CZNTR@vostro.rjw.lan>
References: <7ha95nikqh.fsf@linaro.org> <20140926081534.GA27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50198 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753782AbaIZNVF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 09:21:05 -0400
In-Reply-To: <20140926081534.GA27755@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, dianders@chromium.org, heiko@sntech.de

On Friday, September 26, 2014 09:15:34 AM Mark Brown wrote:
> 
> --gBii9oQw/U9UOygZ
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Thu, Sep 25, 2014 at 12:05:42PM -0700, Kevin Hilman wrote:
> 
> > The first pull request was missing a dependency on a feature that went
> > in through Mark Brown's regulator tree, so it wouldn't actually compile
> > properly by itself.  This version pulls in that topic branch from Marks
> > tree (topic/voltage-ev branch, already part of -next), and now compiles fine.
> 
> Please in future don't pull anything in from my tree without a signed
> tag (speak to me if there isn't one).

I was assuming that this was discussed with you in advance.

Should I drop the branch?

Rafael

