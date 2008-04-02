From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 6)
Date: Wed, 2 Apr 2008 12:42:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804021238190.5042-100000__23861.9789634415$1207154798$gmane$org@iolanthe.rowland.org>
References: <200804021728.45823.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804021728.45823.oliver@neukum.org>
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

> Am Mittwoch, 2. April 2008 17:13:11 schrieb Alan Stern:
> > Basically yes. =A0Subsystems and drivers are allowed to keep devices
> > suspended if they were suspended before the system went to sleep. =A0
> > Remember, the purpose of the resume method is to let drivers know that
> > the system is now awake, not to force them to put their devices into a
> > high-power state.
> =

> Well, sometimes it is exactly that what we desire, eg. as a side effect
> of lsusb. Should the callbacks have different semantics depending on
> the reason you call them? And how should that information be transferred?

Which callbacks are you referring to?  When lsusb opens a device and
does an autoresume, it does not call the same routine as the PM core
does when resuming from a system sleep.  lsusb ends up calling
usb_autoresume_device() whereas the PM core ends up calling
usb_resume(), which is the function you quoted earlier.

Alan Stern
