From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Thu, 14 Mar 2013 10:59:16 +0200
Message-ID: <20130314085916.GC18519@tbergstrom-lnx.Nvidia.com>
References: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com>
 <20130312134913.GD3514@kroah.com>
 <513F4208.4040207@nvidia.com>
 <87zjy7m77d.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:17565 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab3CNI7W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Mar 2013 04:59:22 -0400
Content-Disposition: inline
In-Reply-To: <87zjy7m77d.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Mayuresh Kulkarni <mkulkarni@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>

On Wed, Mar 13, 2013 at 08:27:02PM +0100, Kevin Hilman wrote:
> Mayuresh Kulkarni <mkulkarni@nvidia.com> writes:
> 
> > On Tuesday 12 March 2013 07:19 PM, Greg KH wrote:
> >> On Tue, Mar 12, 2013 at 02:19:19PM +0530, Mayuresh Kulkarni wrote:
> >>> - this commit adds a capability to delay the powering off
> >>> of the domain
> >>
> >> Why?
> >>
> >
> > - As I mentioned below (sorry for mentioning below rather than at
> > start), powering off a domain means the context save needs to be done
> > && it needs to be restored during power on.
> > - It often observed that saving and restoring of context is expensive
> > in terms of power consumed as well as overall system response.
> 
> Are you talking about per-device context save/restore?
> 
> Your drivers should be using runtime PM, which has an autosuspend
> timeout feature.  Using autosuspend on any device in the power domain
> will have the same effect as this proposed patch.  
> 
> Using runtime PM to target specific devices that have expensive
> save/restore paths is also more understandable and maintainable IMO,
> because the "fix" is targetted.
> 

No. The goal of this patch is to introduce something similar to autosuspend
for turning off domains. Even if all peripherals in a domain are idle, you
might not want to turn off the domain immediately, but wait a little in case
a new request comes in. We are using this scheme today in our GPU driver and
it works quite well, but that's done entirely without PM domains.

Cheers,

Peter.
