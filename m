From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Wed, 30 May 2007 19:50:16 +0000
Message-ID: <20070530195016.GA5198__9833.73934072933$1180554698$gmane$org@ucw.cz>
References: <200705272229.21263.rjw@sisk.pl> <200705280943.54312.rjw@sisk.pl>
	<9D3FC259-8391-4C2F-9F0F-AEF6CB3030E8@cam.ac.uk>
	<200705291851.41027.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705291851.41027.rob@landley.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rob Landley <rob@landley.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kay Sievers <kay.sievers@vrfy.org>, LKML <linux-kernel@vger.kernel.org>, Michael-Luke Jones <mlj28@cam.ac.uk>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > >> Userspace should handle the async request just fine when it comes  
> > >> back
> > >> running, regardless of the time it was submitted.
> > >
> > > Okay, so the solution is to convert the drivers to use
> > > request_firmware_nowait() instead of request_firmware() in  
> > > their .resume()
> > > routines.
> > 
> > [added Rob Landley to CC]
> > 
> > I think asynchronous loading should be made the default behaviour.  
> > However, we need to think and document how to do firmware loading.
> 
> I'd love to write up documentation on this if anybody can tell me what it 
> should say. :)

Well, chapter on firmware & suspend/hibernation should say something
about either loading the firmware during early suspend, or just
keeping firmware in ram from boot...
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
