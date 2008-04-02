From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 6)
Date: Wed, 2 Apr 2008 16:22:03 +0200
Message-ID: <200804021622.04461.oliver__16965.4674049982$1207146272$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0804021007060.14858-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0804021007060.14858-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 2. April 2008 16:11:14 schrieb Alan Stern:
> > However, I'd like to add a recommendation that the _new_ "resume" callb=
acks
> > should only return errors in critical situations as the indication to t=
he PM
> > core that something went _really_ wrong and the device in question is q=
uite
> > surely unusable.
> =

> Agreed. =A0The most important aspect is that drivers should _not_ return
> an error if the device is working correctly. =A0We should fix the drivers =

> which make this mistake.

We need to do something about devices that don't want to be resumed.
There's code like this:


static int usb_resume(struct device *dev)
{
	struct usb_device	*udev;

	if (!is_usb_device(dev))	/* Ignore PM for interfaces */
		return 0;
	udev =3D to_usb_device(dev);

	/* If udev->skip_sys_resume is set then udev was already suspended
	 * when the system suspend started, so we don't want to resume
	 * udev during this system wakeup.  However a reset-resume counts
	 * as a wakeup event, so allow a reset-resume to occur if remote
	 * wakeup is enabled. */
	if (udev->skip_sys_resume) {
		if (!(udev->reset_resume && udev->do_remote_wakeup))
			return -EHOSTUNREACH;
	}
	return usb_external_resume_device(udev);
}

Do we want to keep this in the subsystems?

	Regards
		Oliver
