From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 08 May 2015 22:39:21 +0200
Message-ID: <1766178.k5mi2k4gBr@vostro.rjw.lan>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com> <CAJvTdKnoZhworj21Bsdt5ttGK+vQQ0tB_0-2Aok-rdsU8VvNkg@mail.gmail.com> <20150508205233.72b9fae3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58784 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932072AbbEHUOQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 16:14:16 -0400
In-Reply-To: <20150508205233.72b9fae3@lxorguk.ukuu.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Friday, May 08, 2015 08:52:33 PM One Thousand Gnomes wrote:
> > > Some of this however is crappy suspend/resume handling. If the suspend
> > > subsystem was doing its job then for the cases of timeout triggered
> > > suspend it would have triggered most of the disk writes ten seconds
> > > before it tried to suspend properly ;-)
> > 
> > No problem, continue to use s2ram on your system -- and to the extent
> > that sync works, your data will be on disk.  (sync reliability is a
> > different topic...)
> 
> Ok let me ask the other obvious question. For all the mainstream
> distributions do their default tools and setup sync such that removing it
> from the kernel won't actually be noticable by users ?
> 
> If the answer is yes, then I shall shut up and stop worrying 8)

The distros I'm familiar with do that.  It has always been done traditionally
and I don't think anyone had enough guts to remove it from the scripts. :-)

We need to be more careful about Android as I said, but that can be addressed
by adding sync() to the autosleep thread.

Rafael

