From: David Brownell <david-b@pacbell.net>
Subject: Re: /sys/devices/.../power/state broken?
Date: Tue, 12 Dec 2006 10:15:39 -0800
Message-ID: <200612121015.41365.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0612121038210.2834-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0612121038210.2834-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, linux-pm@lists.osdl.org, Brice Goglin <brice@myri.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 12 December 2006 7:42 am, Alan Stern wrote:
> On Tue, 12 Dec 2006, Brice Goglin wrote:
> =

> > Hi,
> > =

> > I know that .../power/state files are deprecated, but I like using them
> > for basic testing of a driver's suspend/resume routines. Anyway, echoing
> > something in the .../power/state in current -git does not seem to work
> > anymore.
> =

> It does work, but the results depend on the device you want to suspend.  =

> For instance, USB devices have no problem at all.  PCI devices will ignore
> your writes because .../power/state can't handle the new multi-stage
> suspend and resume mechanism.
> =

> I've been using the patch below to force my tests to work. =


... relying on the fact that few drivers currently use the late_suspend()
or early_resume() methods.  I know one such driver is in a 2.6.20 merge
queue, but drivers using those methods are still a bit uncommon.


Speaking of those new PM methods ... Greg, I tried refreshing my
patch that uses class suspend() and resume() methods with RTCs to
adjust the system clock properly on resume.  But neither method
is getting called any more.  Did that break with the class device
changes?

- Dave
