From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / OPP: fix build warning
Date: Sat, 17 Oct 2015 22:12:51 -0700
Message-ID: <20151018051251.GA29770@kroah.com>
References: <1444216765-9189-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45841 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbJRFMw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2015 01:12:52 -0400
Content-Disposition: inline
In-Reply-To: <1444216765-9189-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Oct 07, 2015 at 04:49:25PM +0530, Sudip Mukherjee wrote:
> We were getting build warning that:
> expected 'bool *' but argument is of type 'u32 *'
> 
> debugfs_create_bool() used to take the argument as (u32 *), but commit
> 621a5f7ad9cd ("debugfs: Pass bool pointer to debugfs_create_bool()")
> has modified it and now it accepts bool, so no need to typecast a bool
> to (u32 *).
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
