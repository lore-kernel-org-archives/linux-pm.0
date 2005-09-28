From: David Brownell <david-b@pacbell.net>
Subject: Update on USB PM state (2.6.15 queue)
Date: Wed, 28 Sep 2005 09:57:06 -0700
Message-ID: <200509280957.06073.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============51162960500994714=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============51162960500994714==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I just thought I'd provide a quick update on the state of USB PM,
at least according to my testing(*)  after the patches that are now
in Greg's 2.6.15 queue(**) ... I just forwarded the patch overviews
to this list, the details are on linux-usb-devel.

  - Suspend/resume of the PCI devices through sysfs behaves again ...
    it seems to have broken badly sometime after 2.6.10 or 2.6.11

  - Likewise it behaves through swsusp "shutdown/reboot", both with
    and without devices attached.

  - I have one system on which S1 suspend/resume works, at
    least if I use PS/2 keyboard to trigger wakeup.

  - On some other systems, both S1 and S3 suspend fail; the
    system dies in ACPI during wakeup processing.

As for remote wakeup, using a USB keyboard, that still looks OK
(no regressions needed fixing) except when ACPI kicks in:

  - For "runtime PM" scenarios where individual devices and
    hubs (including root hubs) are suspended, the relevant
    parts of the device tree wake up just fine.

  - For "system PM" scenarios, and with /proc/acpi/wakeup
    tweaked to enable all wakeup events, mixed results:

        * The system where S1 works seems to run into some
          ACPI bugs; the last messages relate to overflow,
          evidently the wakeup signal is never acknowledged.

        * Those other systems don't have any better luck
          when the S1/S3 resume signal is a USB wakeup than
          any other kind of wakeup.

Compared to the last time I tested this, it's good to at least
see the USB remote wakeup signals waking the system up; those
seem to be ACPI improvements.  But it still looks like the
cases I most want to see working (S1, S3) are failing on PCs.

There are a few small USB PM updates on the way from me (call
it all cleanups), and Alan's planning some updates too.

- Dave

(*)  EHCI and OHCI only; no UHCI boxes.

(**) http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

--===============51162960500994714==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============51162960500994714==--
