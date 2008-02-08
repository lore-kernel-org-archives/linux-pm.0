From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: [rft] s2ram wakeup moves to .c, could fix few
 machines
Date: Fri, 8 Feb 2008 16:20:05 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802081617280.5958-100000@iolanthe.rowland.org>
References: <20080208210004.GA12923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758663AbYBHVUf@vger.kernel.org>
In-Reply-To: <20080208210004.GA12923@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 8 Feb 2008, Pavel Machek wrote:

> > > segments:offsets rear its ugly head here. I need %ds to point to my
> > > data, and the way to do it is copy it from %cs; that needs start to be
> > > at 0.
> > 
> > Hm, why exactly is that necessay?
> 
> It is not _neccessary_. Try to come up with another method that gets
> relocations right. I could not :-(.
> 
> (Actually, putting table at the offset 0 and short jump at beggining
> of the table would probably do the trick. But that still keeps code at
> offset 0 :-).

Pavel, can you explain in greater detail exactly what you need?

It sounds like you are running in real mode with code stored at some 
(unknown?) location in memory.  The BIOS calls this code with IP=0 and 
CS=<something>, which apparently doesn't fit your requirements.

So just what are your requirements?  The only possibilities I can think 
of are:

	Code stored at a particular location in memory;

	CS, IP, etc. initialized to some particular values.

What am I missing?

Alan Stern
