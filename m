From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Tue, 12 Mar 2013 06:49:13 -0700
Message-ID: <20130312134913.GD3514@kroah.com>
References: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:50695 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab3CLNsX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 09:48:23 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so4857256iak.18
        for <linux-pm@vger.kernel.org>; Tue, 12 Mar 2013 06:48:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mayuresh Kulkarni <mkulkarni@nvidia.com>
Cc: linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, pdeschrijver@nvidia.com

On Tue, Mar 12, 2013 at 02:19:19PM +0530, Mayuresh Kulkarni wrote:
> - this commit adds a capability to delay the powering off
> of the domain

Why?

> - callers can use pm_genpd_set_poweroff_delay to set the
> power off delay for a domain

Why?

> - it expects the delay in milli-seconds

Why?

> - it also adds a pm_notifier per pm domain which cancels
> the delayed power off work when system suspend is invoked

Why?

Come on, please tell us why something is needed and not what it does in
a changelog comment.

> Signed-off-by: Mayuresh Kulkarni <mkulkarni@nvidia.com>
> ---
> 
> - The idea here is to avoid the powering off of a domain if use cases causes
> it to turn on within specific time in coming future

What use case?

> - This seems to save power and better response by avoiding context save/restore
> which are heavy operations in most of the cases

Now these four lines are bit better, why are you hiding it down here?

Who is going to use this code?  Where is those callers?  We don't add
new infrastructure without in-kernel users, unless there is a very good
reason.

greg k-h
