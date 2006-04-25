From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 00:34:45 +0200
Message-ID: <200604260034.46149.rjw@sisk.pl>
References: <200604241429.52022.david-b@pacbell.net>
	<200604260006.33856.rjw@sisk.pl>
	<200604260818.20484.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17031564140928435=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604260818.20484.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============17031564140928435==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday 26 April 2006 00:18, Nigel Cunningham wrote:
> On Wednesday 26 April 2006 08:06, Rafael J. Wysocki wrote:
> > On Tuesday 25 April 2006 23:03, Nigel Cunningham wrote:
> > > On Wednesday 26 April 2006 06:53, Rafael J. Wysocki wrote:
> > > > On Tuesday 25 April 2006 22:28, Nigel Cunningham wrote:
> > > > > On Wednesday 26 April 2006 04:56, Rafael J. Wysocki wrote:
> > > > > > You're saying that (9) is wrong, so could you please suggest what
> > > > > > to do instead of it?
> > > > >
> > > > > 'scuse me for butting in, but here's my suggested modified version:
> > > > > > Well, suppose we have a modular driver that's not loaded before
> > > > > > resume. Then it goes like that (approximately):
> > > > > > (1) We activate swsusp which calls .suspend() for all devices
> > > > > > including our driver (this is a real suspend).
> > > > > > (2) swsusp snapshots the system and creates the image.
> > > > > > (3) swsusp calls .resume() for all devices in order to be able to
> > > > > > save the image (.resume() for our driver is also called which is
> > > > > > OK). (4) swsusp turns off the system.
> > > > > > (5) (some time later) We start a new kernel and tell it to resume.
> > > > > > (6) It activates swsusp which reads the image.
> > > > > > (7) (without your change) swsusp calls .suspend() for all device
> > > > > > drivers that are present at that time, but our driver is not there,
> > > > > > so its .suspend() _won't_ be called.  [Of course with your change
> > > > > > .suspend() won't be called for any driver.]
> > > > >
> > > > > We also make a list that is safely available after the atomic restore
> > > > > of drivers that have had .suspend methods called.
> > > >
> > > > Do you mean we place the list in a __nosave area?
> > >
> > > Well, I wasn't wanting to get bogged down in the details yet, but let's
> > > see what we can come up with. How about this:
> > >
> > > At the point where we do the drivers resume at resume time, we're still
> > > atomic, right? Since that's the case, we can just use get_safe_page()
> > > prior to the restore to store the list and a __nosave pointer to retain
> > > the location across the atomic restore. If we are concerned about
> > > resuming drivers allocating memory and overwriting our list (and I think
> > > that's a valid concern), space could be allocated and the list copied
> > > between doing the atomic restore and the device pwoerup/resume.
> >
> > This one seems to look better.
> >
> > Still the problem is we need to know what to do with the devices that have
> > had .suspend() routines called.  Some of them would have to be reset, some
> > of them might be left in the current state, and for some of them we'd have
> > to do something special.  Frankly, only the driver writer will know what's
> > appropriate.
> 
> I saw the 2 suspends, 1 resume comment in another part of the thread, but 
> don't believe a driver would be able to detect that 2 suspends and 1 resume 
> call had been made - at least not without some non volatile ram.

In fact we know when the second .suspend() is going to be called from the
driver, so we can tell it to take care, for example by passing a special
value to .suspend().  If that value is passed to .suspend(), the driver should
prepare the device for .resume() being called after the snapshot image is
restored (eg. reset it).

Greetings,
Rafael

--===============17031564140928435==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17031564140928435==--
