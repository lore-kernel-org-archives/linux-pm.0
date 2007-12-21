From: Pavel Machek <pavel@ucw.cz>
Subject: Re: USB storage powersaving patches
Date: Fri, 21 Dec 2007 20:17:15 +0100
Message-ID: <20071221191715.GB22297@elf.ucw.cz>
References: <20071218161040.GA14399@elf.ucw.cz>
	<Pine.LNX.4.44L0.0712181149090.6404-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0712181149090.6404-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

HI!

> > Do you think I could get a copy of some version of those patches? I'm
> > currently struggling with getting AHCI to powersave in _any_ way,
> > "clean" is not on radar, yet.
> 
> The usb-storage patch is here:
> 
> 	http://marc.info/?l=linux-usb-devel&m=118374628105232&w=2
> 
> I'm afraid it won't do you much good, however, because of the way it 
> relies on the USB power-management infrastructure.

I see... you already have a process context, so resuming is easy for
you... ok. But thanks for the pointer!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
