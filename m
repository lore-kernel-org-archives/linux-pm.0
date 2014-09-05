From: Oliver Neukum <oneukum@suse.de>
Subject: error returns of pm_runtime_get()
Date: Fri, 05 Sep 2014 14:43:36 +0200
Message-ID: <1409921016.9532.15.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48563 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083AbaIEMni (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Sep 2014 08:43:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>


Hi,

looking through multiple drivers it seems to me that a great majority
is returning the error returns of pm_runtime_get() to user space.
They come quite directly from rpm_resume(). So we are led to return
things like -EACCESS or -EINVAL from system calls like open()
where they have no place.

So it seems to me like we should filter more or less like this:

-EBUSY		-> -EBUSY
-ENOMEM 	-> -ENOMEM
-EINPROGRES	-> -EAGAIN
any other error	-> -EIO

And it would be best to retain the current name of pm_runtime_get()
and introduce a version with unfiltered error codes.
What do you think?

	Regards
		Oliver



