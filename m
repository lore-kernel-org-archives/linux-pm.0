From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / OPP: fix build warning
Date: Thu, 8 Oct 2015 13:21:22 +0200
Message-ID: <20151008112122.GA13411@xo-6d-61-c0.localdomain>
References: <1444216765-9189-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55018 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbbJHLV1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 07:21:27 -0400
Content-Disposition: inline
In-Reply-To: <1444216765-9189-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed 2015-10-07 16:49:25, Sudip Mukherjee wrote:
> We were getting build warning that:
> expected 'bool *' but argument is of type 'u32 *'
> 
> debugfs_create_bool() used to take the argument as (u32 *), but commit
> 621a5f7ad9cd ("debugfs: Pass bool pointer to debugfs_create_bool()")
> has modified it and now it accepts bool, so no need to typecast a bool
> to (u32 *).
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
