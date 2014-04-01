From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH REPOST v5 1/3] powernv, cpufreq: Select CPUFreq related Kconfig options for powernv
Date: Wed, 02 Apr 2014 00:03:07 +0200
Message-ID: <1506880.SKUfks4BOU@vostro.rjw.lan>
References: <CAKohpo=jvswNPmUPEbS79bSp9ZWC1e3DjaEUX=O4CWMXfufHrw@mail.gmail.com> <1396336408-20954-3-git-send-email-ego@linux.vnet.ibm.com> <1396345609.28055.7.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63361 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751844AbaDAVrT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Apr 2014 17:47:19 -0400
In-Reply-To: <1396345609.28055.7.camel@pasglop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, svaidy@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, April 01, 2014 08:46:49 PM Benjamin Herrenschmidt wrote:
> On Tue, 2014-04-01 at 12:43 +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > Enable CPUFreq for PowerNV. Select "performance", "powersave",
> > "userspace" and "ondemand" governors. Choose "ondemand" to be the
> > default governor.
> 
> Rafael, are you going to take these or should I send them to Linus ?
> 
> (I'd rather you take them :-)

I can do that, but the timing is pretty bad.  How urgent are they?

Rafael

