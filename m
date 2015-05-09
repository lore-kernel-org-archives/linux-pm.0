From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Sat, 9 May 2015 17:25:18 -0300
Message-ID: <20150509202518.GB20282@khazad-dum.debian.net>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
 <Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33035 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750951AbbEIUZW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2015 16:25:22 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id A11F920AAD
	for <linux-pm@vger.kernel.org>; Sat,  9 May 2015 16:25:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Sat, 09 May 2015, Alan Stern wrote:
> On Fri, 8 May 2015, Rafael J. Wysocki wrote:
> > My current view on that is that whether or not to do a sync() before suspending
> > ultimately is a policy decision and should belong to user space as such (modulo
> > the autosleep situation when user space may not know when the suspend is going
> > to happen).
> > 
> > Moreover, user space is free to do as many sync()s before suspending as it
> > wants to and the question here is whether or not the *kernel* should sync()
> > in the suspend code path.
> > 
> > Since we pretty much can demonstrate that having just one sync() in there is
> > not sufficient in general, should we put two of them in there?  Or just
> > remove the existing one and leave it to user space entirely?
> 
> I don't know about the advantages of one sync over two.  But how about
> adding a "syncs_before_suspend" (or just "syncs") sysfs attribute that
> takes a small numeric value?  The default can be 0, and the user could
> set it to 1 or 2 (or higher).

IMO it would be much safer to both have that knob, and to set it to keep the
current behavior as the default.  Userspace will adapt and change that knob
to whatever is sufficient based on what it does before signaling the kernel
to suspend.

A regression in sync-before-suspend is sure to cause data loss episodes,
after all.  And, as far as bikeshedding goes, IMHO syncs_before_suspend is
self-explanatory, which would be a very good reason to use it instead of the
shorter requires-you-to-know-what-it-is-about "syncs".

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
