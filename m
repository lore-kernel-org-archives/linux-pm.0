From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 8 May 2015 20:52:33 +0100
Message-ID: <20150508205233.72b9fae3@lxorguk.ukuu.org.uk>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<Pine.LNX.4.44L0.1505081026250.1219-100000@iolanthe.rowland.org>
	<CAJvTdK=ok=xWR16R-3_+kpxujBSFOLqQ3DNNyFgE-Kc8en=PTg@mail.gmail.com>
	<20150508201310.5c4ccfaa@lxorguk.ukuu.org.uk>
	<CAJvTdKnoZhworj21Bsdt5ttGK+vQQ0tB_0-2Aok-rdsU8VvNkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:46354 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbbEHTww (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 15:52:52 -0400
In-Reply-To: <CAJvTdKnoZhworj21Bsdt5ttGK+vQQ0tB_0-2Aok-rdsU8VvNkg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

> > Some of this however is crappy suspend/resume handling. If the suspend
> > subsystem was doing its job then for the cases of timeout triggered
> > suspend it would have triggered most of the disk writes ten seconds
> > before it tried to suspend properly ;-)
> 
> No problem, continue to use s2ram on your system -- and to the extent
> that sync works, your data will be on disk.  (sync reliability is a
> different topic...)

Ok let me ask the other obvious question. For all the mainstream
distributions do their default tools and setup sync such that removing it
from the kernel won't actually be noticable by users ?

If the answer is yes, then I shall shut up and stop worrying 8)
 
> Understand, however, there are systems which suspend/resume reliably
> many times per second, making policy choice of having the kernel hard-code
> a sys_sync() into the suspend path a bad idea.

I'm aware of that - I have a very nice ASUS T100TA.

Alan
