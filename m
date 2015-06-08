From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/6] power: hibernate: Use separate messages for
 "Syncing filesystems"
Date: Mon, 08 Jun 2015 16:23:24 -0700
Message-ID: <1433805804.2730.22.camel@perches.com>
References: <cover.1433442778.git.joe@perches.com>
	 <1664a8ea72b34db4bef860004166875ab70898ee.1433442778.git.joe@perches.com>
	 <5609150.OAJVFt04xE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:48393 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751888AbbFHXX1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 19:23:27 -0400
In-Reply-To: <5609150.OAJVFt04xE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org

On Tue, 2015-06-09 at 01:35 +0200, Rafael J. Wysocki wrote:
> On Thursday, June 04, 2015 11:36:44 AM Joe Perches wrote:
> > Add the ability to see how long it takes to sync the filesystems
> > via the printk time mechanism.
> > 
> > Start to standardize the printk "PM: doing something...done"
> > messages on two separate lines.
> 
> Well, it would be good to say what problem this is attempting to fix.
> 
> And while I understand the underlying concern, there is a merit in keeping
> each of these messages in one line (if everything goes well), so I'm wondering
> what about printing each of them in one go after the operation with a tail
> depending on the result?  Like
> 
> printk(KERN_INFO "PM: Syncing filesystems ... done\n");
> 
> on success or
> 
> printk(KERN_INFO "PM: Syncing filesystems ... failed\n");
> 
> on failure?

Maybe.

I believe there are multi-second delays possible when
syncing the filesystems on things like usb memory sticks.

I think the dmesg line count here isn't particularly important
and there's some small value in consistently presenting timing
information via dmesg timestamps when using 2 lines.

There's also some small value in patch 6/6 and the consistent
prefixing of "PM: " on all these messages.


