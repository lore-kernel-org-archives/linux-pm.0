From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB storage powersaving patches
Date: Tue, 18 Dec 2007 11:50:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712181149090.6404-100000@iolanthe.rowland.org>
References: <20071218161040.GA14399@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071218161040.GA14399@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Dec 2007, Pavel Machek wrote:

> Hi!
> 
> > On Mon, 17 Dec 2007, Pavel Machek wrote:
> > 
> > > ...are they available somewhere? I'd like to do something similar for
> > > AHCI, but so far SCSI seems to be winning...
> > 
> > The usb-storage dynamic power management patches have been removed for 
> > the time being, because they don't respect the SCSI stack.
> > 
> > I intend to spend some time over the holidays on adding dynamic power 
> > management to the SCSI core.  That should allow us to put the 
> > usb-storage PM stuff back (in modified form), and it should allow you 
> > to do the same sort of thing with AHCI.  Does that sound okay?
> 
> Do you think I could get a copy of some version of those patches? I'm
> currently struggling with getting AHCI to powersave in _any_ way,
> "clean" is not on radar, yet.

The usb-storage patch is here:

	http://marc.info/?l=linux-usb-devel&m=118374628105232&w=2

I'm afraid it won't do you much good, however, because of the way it 
relies on the USB power-management infrastructure.

Alan Stern
