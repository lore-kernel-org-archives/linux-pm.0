From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Add some basic resume trace facilities
Date: Tue, 13 Jun 2006 15:50:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606131539050.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131430380.5498@g5.osdl.org>
	<200606140810.19701.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606140810.19701.ncunningham@linuxmail.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Wed, 14 Jun 2006, Nigel Cunningham wrote:
> >
> > Use "#include <linux/resume-trace.h>", and then sprinkle TRACE_RESUME(0)
> > commands liberally over the driver that you're trying to figure out why
> > and where it hangs. Expect to waste a _lot_ of time, but at least this
> > gives you _some_ chance to actually debug it, instead of just staring a=
t a
> > dead machine.
> >
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> =

> s/On laptop per child/One bdi2000 per computer/? I'll give it a try.

Yeah, well it ain't no JTAG scanner, exactly ;)

The minimal patch to actually _use_ this would be something like the =

appended.  It's worth noting that the TRACE_DEVICE() macro does _not_ =

actually generate a trace event in itself, it just prepares the device =

hash so that the TRACE_RESUME() code then save the device, filename and =

linenumber information in the "trace buffer".

When you reboot, if everything went well, you'll see something like

	Magic number: 1:660:259
	hash matches drivers/usb/host/ehci-pci.c:258
	hash matches device 0000:00:1d.7

in the bootup dmesg logs. The "magic number" is just the hashes, where the =

first number is between 0-15 and can be a dynamic value, ie if you are =

inside a loop you can do

	TRACE_RESUME(loopcounter);

and it will save off the low four bits of the loopcounter in the RTC and =

it will show it as the first "magic number". Otherwise you'll just have to =

live with totally static information (filename and line number of the last =

trace event that triggered).

(The above trace event was obviously not generated with this minimal =

patch: it's from a much bigger "sprinkle TRACE_RESUME() stuff all over" =

thing of mine, from a real debug session).

And the real problem, of course, is that the trace buffer is just a single =

entry deep. It was "interesting" to just fit even _that_, much less a real =

trace buffer into the RTC.

Of course, with helper hardware we could do much better, but the whole =

point of this was literally to _not_ need any special debug hardware. This =

should work on anything.

		Linus

---
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 317edbf..bf6ee38 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -9,6 +9,7 @@
  */
 =

 #include <linux/device.h>
+#include <linux/resume-trace.h>
 #include "../base.h"
 #include "power.h"
 =

@@ -23,6 +24,8 @@ int resume_device(struct device * dev)
 {
 	int error =3D 0;
 =

+	TRACE_DEVICE(dev);
+	TRACE_RESUME(0);
 	down(&dev->sem);
 	if (dev->power.pm_parent
 			&& dev->power.pm_parent->power.power_state.event) {
@@ -36,6 +39,7 @@ int resume_device(struct device * dev)
 		error =3D dev->bus->resume(dev);
 	}
 	up(&dev->sem);
+	TRACE_RESUME(1);
 	return error;
 }
 =
