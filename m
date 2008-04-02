From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 6)
Date: Wed, 2 Apr 2008 16:28:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804021623520.2107-100000__41533.9089501233$1207168258$gmane$org@iolanthe.rowland.org>
References: <200804022211.36438.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804022211.36438.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Apr 2008, Oliver Neukum wrote:

> Am Mittwoch, 2. April 2008 18:42:15 schrieb Alan Stern:
> > On Wed, 2 Apr 2008, Oliver Neukum wrote:
> > =

> > > Am Mittwoch, 2. April 2008 17:13:11 schrieb Alan Stern:
> > > > Basically yes. =A0Subsystems and drivers are allowed to keep devices
> > > > suspended if they were suspended before the system went to sleep. =
=A0
> > > > Remember, the purpose of the resume method is to let drivers know t=
hat
> > > > the system is now awake, not to force them to put their devices int=
o a
> > > > high-power state.
> > > =

> > > Well, sometimes it is exactly that what we desire, eg. as a side effe=
ct
> > > of lsusb. Should the callbacks have different semantics depending on
> > > the reason you call them? And how should that information be transfer=
red?
> > =

> > Which callbacks are you referring to?  When lsusb opens a device and
> > does an autoresume, it does not call the same routine as the PM core
> > does when resuming from a system sleep.  lsusb ends up calling
> > usb_autoresume_device() whereas the PM core ends up calling
> > usb_resume(), which is the function you quoted earlier.
> =

> But how is usb_autoresume_device() supposed to take to the driver?
> Furthermore suppose the interface woken up is storage. This will have
> to work across subsystem borders. Why not put it into generic code?

I'm not sure exactly what you're asking.  However it's worth mentioning =

that once the dust from Rafael's changes settles down, I intend to =

submit a patch creating new PM_EVENT_* codes:

	PM_EVENT_USER_SUSPEND
	PM_EVENT_USER_RESUME
	PM_EVENT_REMOTE_WAKEUP
	PM_EVENT_AUTOSUSPEND
	PM_EVENT_AUTORESUME

(and the corresponding PMSG_* definitions).  The PM core will never use
the new codes, but subsystems like USB will be able to use them
internally.  Does that answer your question?

Alan Stern
