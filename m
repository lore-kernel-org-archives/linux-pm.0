From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] regulators: Add definition of regulator_set_voltage_time() for !CONFIG_REGULATOR
Date: Wed, 28 May 2014 01:12:57 +0200
Message-ID: <233568355.QJI3TVGr1I@vostro.rjw.lan>
References: <1780c3205893be8567fa29ccd86674e2f32555b4.1401192160.git.viresh.kumar@linaro.org> <20140527192923.GC12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60000 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752108AbaE0Wzx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 May 2014 18:55:53 -0400
In-Reply-To: <20140527192923.GC12304@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, edubezval@gmail.com, pavel@ucw.cz, lgirdwood@gmail.com

On Tuesday, May 27, 2014 08:29:23 PM Mark Brown wrote:
> 
> --wJgPvdDu+gj56kJ8
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Tue, May 27, 2014 at 05:37:29PM +0530, Viresh Kumar wrote:
> 
> > Liam/Broonie: Please see if this can go through Rafael as 2nd patch is dependent
> > on it.
> 
> Is that likely to happen before the merge window?

Depending.  If there's -rc8, then maybe.  Otherwise, nope.

Rafael

