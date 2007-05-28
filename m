From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 15:01:25 +0200
Message-ID: <20070528130125.GK18807@elf.ucw.cz>
References: <200705272229.21263.rjw@sisk.pl> <200705272231.54535.rjw@sisk.pl>
	<6BD5252F-96CD-49D9-86C7-18115294D913@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6BD5252F-96CD-49D9-86C7-18115294D913@cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael-Luke Jones <mlj28@cam.ac.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> >Use a hibernation and suspend notifier to disable the firmware  
> >requesting
> >mechanism before a hibernation/suspend and enable it after the  
> >operation.
> >
> >Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > drivers/base/firmware_class.c |   36 ++++++++++++++++++++++++++++++ 
> >++++++
> > 1 file changed, 36 insertions(+)
> 
> I don't like this approach, as I feel that the firmware loading  
> interface should be able to detect if a firmware load request is not  
> being handled, due to absence of userspace / hotplug handler presence.

I don't think that's possible. If hotplug handler needs /dev/foo, but
/dev/foo is not available, it will just block waiting there.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
