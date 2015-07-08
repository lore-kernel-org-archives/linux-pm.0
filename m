From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Wed, 8 Jul 2015 10:40:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507081032170.2243-100000@iolanthe.rowland.org>
References: <20150708112041.GB29356@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53302 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758437AbbGHOkA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 10:40:00 -0400
In-Reply-To: <20150708112041.GB29356@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Oliver Neukum <oneukum@suse.de>, Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, 8 Jul 2015, Pavel Machek wrote:

> > well, that depends on what the purpose of the sync is supposed to be.
> > 
> > If it is there to prevent users from corrupting their filesystems as a result
> > of a mistake, it is insufficient.  If it's there for other reasons, I'm wondering
> > what those reasons are (on systems that suspend and resume reliably, because the
> > original reason to put it in there was to reduce the damage from suspend/resume
> > crashes).
> 
> I put it there, and there were more reasons than "crashes" to put it
> there.
> 
> 1) crashes.
> 
> 2) battery is quite likely to run out in suspended machine.
> 
> 3) if someone pulls the stick and puts it in other machine, I wanted
> consistent filesystem at least after journal replay.

I was going to make the same points.

>From my point of view, whether to issue a sync is a tradeoff.  I can't
remember any time in the last several years where lack of a sync would
have caused a problem for my computers, but the possibility still
exists.

So on one hand, issuing the sync can help prevent a low-probability 
problem.  On the other hand, issuing the sync takes a small amount of 
time (negligible for my purposes but not negligible for Len and 
others).

I prefer to pay a very small cost to prevent a low-probability problem.  
Others may not want to pay, because to them the cost is larger or the 
probability is lower.

_That_ is the justification for not eliminating the sync completely but 
making it optional.

Alan Stern

