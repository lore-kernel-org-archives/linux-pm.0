From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
	output after resume
Date: Fri, 27 Apr 2007 10:03:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704271002060.3430-100000@iolanthe.rowland.org>
References: <20070427125734.GK22250@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427125734.GK22250@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, nigel@nigel.suspend2.net
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Apr 2007, Pavel Machek wrote:

> On Fri 2007-04-27 15:52:12, Pekka J Enberg wrote:
> > On Fri, 27 Apr 2007, Pavel Machek wrote:
> > > 1. This should not be a config option
> > 
> > Ok.
> 
> Unfortunately, we loose dmesg from the state saving this way, so I do
> not think it can be hardcoded, either. Best way would be to somehow
> preserve both dmesg buffers.
> 
> Other way is to just control it by the define in the .c file; person
> using this is by definition kernel hacker, anyway. Or this can simply
> live like debugging patch, interested parties can apply.

Consider this: Add a debugfs file containing a binary value.  If the value 
is on then preserve the boot dmesg buffer.  If the value is off, don't 
preserve it -- overwrite the buffer pointers with values saved in the 
image.

Alan Stern
