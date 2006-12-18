From: David Brownell <david-b@pacbell.net>
Subject: Re: class suspend()/resume() broken
Date: Sun, 17 Dec 2006 19:27:24 -0800
Message-ID: <200612171927.25107.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0612121038210.2834-100000@iolanthe.rowland.org>
	<200612121015.41365.david-b@pacbell.net>
	<20061215190150.GA18185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061215190150.GA18185@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org, Greg KH <gregkh@suse.de>, Brice Goglin <brice@myri.com>
List-Id: linux-pm@vger.kernel.org

On Friday 15 December 2006 11:01 am, Greg KH wrote:
> On Tue, Dec 12, 2006 at 10:15:39AM -0800, David Brownell wrote:
> > =

> > Speaking of those new PM methods ... Greg, I tried refreshing my
> > patch that uses class suspend() and resume() methods with RTCs to
> > adjust the system clock properly on resume.  But neither method
> > is getting called any more.  Did that break with the class device
> > changes?
> =

> It shouldn't have, but to be honest, I haven't paid attention to it.

Well, it seems broken and, pending "git bisect", those patches are
the obvious candidate.

Maybe it's related to "dev->class" now being "optional"?  And, it
seems, null ... I'm not clear on how devices associated with two
or more classes would work, either.

In general, _using_ those class suspend()/resume() calls was kind
of painful since what's needed is the class_device, and there's no
obvious way to get from a device back to that.  That RTC patch
originally worked via some really ugly and not-generalizable code
that relied on there being only one class_device used to restore
the clock after resume, so it could just look at every device given
to those calls, and ignore it if it wasn't the one associated with
that class_device.

I have a sneaking suspicion that we're missing back-links from
devices to their associated classes, but to justify that I'd
have to dive deep into the driver model again.  :(

- Dave
