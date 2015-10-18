From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3] debugfs: Add debugfs_create_ulong()
Date: Sun, 18 Oct 2015 09:21:40 -0700
Message-ID: <20151018162140.GA30196@kroah.com>
References: <6d786424835b514b92f847e6f9af21b01244de85.1445159433.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50149 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbbJRQVl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2015 12:21:41 -0400
Content-Disposition: inline
In-Reply-To: <6d786424835b514b92f847e6f9af21b01244de85.1445159433.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, sboyd@codeaurora.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu

On Sun, Oct 18, 2015 at 02:45:27PM +0530, Viresh Kumar wrote:
> Add debugfs_create_ulong() for the users of type 'unsigned long'. These
> will be 32 bits long on a 32 bit machine and 64 bits long on a 64 bit
> machine.

Do you really need a debugfs_create_xlong()?  You don't mention it here
in your changelog comment yet the patch contains it.  I'd hold off for
it for now as I doubt anyone needs it...

thanks,

greg k-h
