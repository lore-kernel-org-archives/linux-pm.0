From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Thu, 27 Mar 2014 22:12:47 +1100
Message-ID: <1395918767.5569.99.camel@pasglop>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
	 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
	 <20140327093050.GA27777@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44081 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754802AbaC0LNK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Mar 2014 07:13:10 -0400
In-Reply-To: <20140327093050.GA27777@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On Thu, 2014-03-27 at 15:00 +0530, Gautham R Shenoy wrote:
> > > --- a/arch/powerpc/configs/pseries_le_defconfig
> > > +++ b/arch/powerpc/configs/pseries_le_defconfig
> > > @@ -350,3 +350,4 @@ CONFIG_CRYPTO_LZO=m
> > >  # CONFIG_CRYPTO_ANSI_CPRNG is not set
> > >  CONFIG_CRYPTO_DEV_NX=y
> > >  CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
> > > +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> > 
> > don't know how Rafael want this, but probably this part could have
> gone
> > through ppc tree..
> > 
> 
> That would mean multiple patches :-)

We can always fix the defconfig later but I am also find if Rafael
carries that bit.

Cheers,
Ben.


