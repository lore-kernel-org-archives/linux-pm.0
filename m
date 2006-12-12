From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: /sys/devices/.../power/state broken?
Date: Tue, 12 Dec 2006 10:42:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0612121038210.2834-100000@iolanthe.rowland.org>
References: <457E81A7.4080601@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <457E81A7.4080601@myri.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Brice Goglin <brice@myri.com>
Cc: Greg KH <gregkh@suse.de>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 12 Dec 2006, Brice Goglin wrote:

> Hi,
> =

> I know that .../power/state files are deprecated, but I like using them
> for basic testing of a driver's suspend/resume routines. Anyway, echoing
> something in the .../power/state in current -git does not seem to work
> anymore.

It does work, but the results depend on the device you want to suspend.  =

For instance, USB devices have no problem at all.  PCI devices will ignore
your writes because .../power/state can't handle the new multi-stage
suspend and resume mechanism.

I've been using the patch below to force my tests to work.  The fact =

remains, this way of doing things won't be valid much longer.

>  For instance, the driver's suspend routine is not called
> anymore  when writing 3 while it was at least in 2.6.17 and 2.6.18. And
> reading the contents of the file afterwards now returns 0 while it
> seemed to return 2 before.
> =

> I didn't have time to git-bisect the problem so far, I will if nobody
> has any idea.
> =

> And if somebody knows what to use instead of .../power/state to test a
> driver's suspend/resume, I'd be happy to hear it too. The explanation in
> feature-removal-schedule.txt did not help a lot, neither did the thread
> I found on linux-pm :)

There is no general-purpose replacement.  Probably each bus will end up =

implementing its own special-purpose sysfs interface for suspend/resume =

(or not, as the case may be).

Alan Stern


Index: usb-2.6/drivers/base/power/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- usb-2.6.orig/drivers/base/power/sysfs.c
+++ usb-2.6/drivers/base/power/sysfs.c
@@ -45,10 +45,6 @@ static ssize_t state_store(struct device
 	pm_message_t state;
 	int error =3D -EINVAL;
 =

-	/* disallow incomplete suspend sequences */
-	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
-		return error;
-
 	state.event =3D PM_EVENT_SUSPEND;
 	/* Older apps expected to write "3" here - confused with PCI D3 */
 	if ((n =3D=3D 1) && !strcmp(buf, "3"))
