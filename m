From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] power: Replace printks with pr_* routines
Date: Sat, 16 Nov 2013 06:19:22 +0900
Message-ID: <20131115211922.GB14410@kroah.com>
References: <1384531806-11500-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36092 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3KOVTQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2013 16:19:16 -0500
Content-Disposition: inline
In-Reply-To: <1384531806-11500-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Fri, Nov 15, 2013 at 09:10:06AM -0700, Shuah Khan wrote:
> Replaced printks with pr_* routines. dev_* routines could have been used,
> but chose to use pr_* to avoid breaking scripts that might be relying on
> a specific text.

I'd really like to switch to dev_* instead, even changing to pr_* should
change the output prefix (if it's set for this file, odds are it isn't
though...)

thanks,

greg k-h
