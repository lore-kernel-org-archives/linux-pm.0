From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] Block on access to temporarily unavailable
 pci device
Date: Wed, 18 Oct 2006 11:52:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org>
References: <20061018145141.GO22289@parisc-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161178AbWJRPxB@vger.kernel.org>
In-Reply-To: <20061018145141.GO22289@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Oct 2006, Matthew Wilcox wrote:

> On Wed, Oct 18, 2006 at 10:38:20AM -0400, Alan Stern wrote:
> > You have to do _something_, because a user task could be about to read the
> > configuration space at the exact moment you want to start the BIST.  That
> > means ipr would have to wait until the user access is finished, which
> > means it has to be prepared to sleep one way or another.
> 
> Actually, it only has to spin until the user has finished accessing
> config space.  See the patch I just posted.

I stand corrected.

Don't you want the user process to wait in TASK_INTERRUPTIBLE?  It would 
require only a very simple change.

Alan Stern
