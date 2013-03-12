From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Tue, 12 Mar 2013 08:19:01 -0700
Message-ID: <20130312151901.GA18438@kroah.com>
References: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com>
 <20130312134913.GD3514@kroah.com>
 <513F4208.4040207@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41335 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab3CLPSQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 11:18:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so5066502pbc.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Mar 2013 08:18:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <513F4208.4040207@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mayuresh Kulkarni <mkulkarni@nvidia.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, Peter De Schrijver <pdeschrijver@nvidia.com>

On Tue, Mar 12, 2013 at 08:26:08PM +0530, Mayuresh Kulkarni wrote:
> On Tuesday 12 March 2013 07:19 PM, Greg KH wrote:
> >On Tue, Mar 12, 2013 at 02:19:19PM +0530, Mayuresh Kulkarni wrote:
> >>- this commit adds a capability to delay the powering off
> >>of the domain
> >
> >Why?
> >
> 
> - As I mentioned below (sorry for mentioning below rather than at
> start), powering off a domain means the context save needs to be
> done && it needs to be restored during power on.

<good stuff snipped>

All of this should be in the changelog section of the patch, please,
when you resend this, add it there.

> - The downstream kernel has a graphics-host (host1x) driver which
> has a home grown power management framework called ACM
> (auto-clock-management). We implement both delayed clock and power
> partition off functionality in it.

We should wait for this driver to be submitted and accepted before
we can add these new api hooks.  When is that going to happen?

thanks,

greg k-h
