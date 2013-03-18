From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Mon, 18 Mar 2013 12:07:14 +0200
Message-ID: <20130318100714.GL18519@tbergstrom-lnx.Nvidia.com>
References: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com>
 <20130312134913.GD3514@kroah.com>
 <513F4208.4040207@nvidia.com>
 <87zjy7m77d.fsf@linaro.org>
 <20130314085916.GC18519@tbergstrom-lnx.Nvidia.com>
 <5141DABF.9050002@nvidia.com>
 <87vc8sk09p.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:14959 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab3CRKHU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Mar 2013 06:07:20 -0400
Content-Disposition: inline
In-Reply-To: <87vc8sk09p.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Mayuresh Kulkarni <mkulkarni@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>


> > - If such a domain is going to be needed very soon in future, it makes
> > sense to avoid its power down for at-least that much amount of time
> > (which is what the proposed patch does).
> 
> ...and is also what the pluggable governors inside genpd are meant to
> allow you to do.
> 

Unfortunately this is rather akward to implement in a genpd governor. The
governor only gets called when the genpd core wants to power off a domain.
It can then say yes or no. You could start a timer and on expiry call into
genpd and use a flag to indicate to the governor (which will be called
again), it should now allow the power off.

> More specifically, what you said above: "if such a domain is going to be
> needed very soon in the future" is just another way of saying it there
> is a wakeup latency constraint.   Wakeup latency constratints are
> handled by per-device PM QoS, which can be queried by a governor
> associated with a genpd.

No. This is not a wakeup latency constraint but rather an energy breakeven
point constraint.

Cheers,

Peter.
