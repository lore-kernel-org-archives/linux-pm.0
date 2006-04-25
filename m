From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 20:56:55 +0200
Message-ID: <200604252056.56534.rjw@sisk.pl>
References: <200604241429.52022.david-b@pacbell.net>
	<200604251032.57204.rjw@sisk.pl>
	<200604250911.54951.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604250911.54951.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday 25 April 2006 18:11, David Brownell wrote:
> On Tuesday 25 April 2006 1:32 am, Rafael J. Wysocki wrote:
> 
> > > just want things quiesced, mainly because we don't want to spin down drives.
> > 
> > That's right.  And kernel_restart_prepare(NULL) will make them spin down?
> > If so, they have to be treated in a special way.
> 
> Seems every time that someone turns up one of the problems with this "freeze"
> thing, the same responses come back:  "we can't fix that because we don't want
> to spin down drives".

I didn't say we couldn't fix that, did I?

> I've begun thinking that calls like pm_should_I_spin_down_drives() would be a
> better structural approach than continually redefining this "freeze" thing so
> it makes less and less sense to all other drivers ... who nonethless need to
> clutter themselves up with a growing list of special cases, to accomodate
> rotating media that may not even exist in the target system.

I think we should do something different to device_power_down(PMSG_FREEZE)
there, but I'm not sure it should be kernel_restart_prepare(NULL).

Actually spinning down disks during resume is a problem for some users (yes,
we've had such bug reports recently), so it's better to avoid this.

> > OTOH I think at least some device driver writers assume that .resume() will
> > always be called after .suspend() which only is true for non-modular drivers
> > (or for modular drivers loaded from an initrd before resume). 
> 
> Say what?  Of _course_ resume() should only be called after suspend().  If
> that's not true in any case, the code wrongly issuing the resume() is buggy.

Well, suppose we have a modular driver that's not loaded before resume.
Then it goes like that (approximately):
(1) We activate swsusp which calls .suspend() for all devices including our
driver (this is a real suspend).
(2) swsusp snapshots the system and creates the image.
(3) swsusp calls .resume() for all devices in order to be able to save the
image (.resume() for our driver is also called which is OK).
(4) swsusp turns off the system.
(5) (some time later) We start a new kernel and tell it to resume.
(6) It activates swsusp which reads the image.
(7) (without your change) swsusp calls .suspend() for all device drivers that
are present at that time, but our driver is not there, so its .suspend()
_won't_ be called.  [Of course with your change .suspend() won't be called
for any driver.]
(8) swsusp restores the image.
(9) swsusp calls .resume() for all devices _including_ our driver, because it
was in memory before suspend.  For our driver this .resume() is not
called after .suspend(), is it?

You're saying that (9) is wrong, so could you please suggest what to do
instead of it?
 
> I don't see where you're collecting that list of special cases.

I have no such list ...

> It doesn't match what I've observed ... and even if it were correct, I'd say
> that's yet another case where special casing reflects bugs.

... and I'm against special casing as far as it's avoidable.

Greetings,
Rafael
