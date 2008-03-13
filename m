From: Andres Salomon <dilinger@queued.net>
Subject: Re: +
 pm-gxfb-add-hook-to-pm-console-layer-that-allows-disabling-of-suspen
 d-vt-switch.patch added to -mm tree
Date: Thu, 13 Mar 2008 10:57:50 -0400
Message-ID: <20080313105750.3e50107a@ephemeral>
References: <200803120527.m2C5RmWl011967@imap1.linux-foundation.org>
	<20080312085149.GA3993@ucw.cz>
	<20080312144506.GE1018@cosmic.amd.com>
	<20080313074332.GA19117@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756465AbYCMOyH@vger.kernel.org>
In-Reply-To: <20080313074332.GA19117@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jordan Crouse <jordan.crouse@amd.com>, akpm@linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, mm-commits@vger.kernel.org, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Mar 2008 08:43:32 +0100
Pavel Machek <pavel@ucw.cz> wrote:

[...]
> > 
> > > Also, it would be nice to make the logic the other way around. Move vt
> > > switching to the drivers that need it because X can be expected to own
> > > the hardware.
> > 
> > Conservation of energy.  Its easier to make 3 or 4 drivers opt out of 
> 
> Nice euphemism. You did quick hack instead of proper solution, and
> someone will have to clean it up sooner or later...
> 								Pavel
> 

And I wouldn't be willing to do anything further without approval
from the fbdevel folks.  No one's stopping you from writing a patch
if you feel so strongly about it, though.
