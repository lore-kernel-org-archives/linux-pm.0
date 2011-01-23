From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
 iomaps management
Date: Sun, 23 Jan 2011 21:15:12 -0200
Message-ID: <20110123231512.GB11203__15178.4290130765$1295824610$gmane$org@khazad-dum.debian.net>
References: <201101201226.41021.rjw@sisk.pl> <201101221013.10239.rjw@sisk.pl>
	<20110123182037.GH24071@khazad-dum.debian.net>
	<201101232135.32510.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201101232135.32510.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 23 Jan 2011, Rafael J. Wysocki wrote:
> On Sunday, January 23, 2011, Henrique de Moraes Holschuh wrote:
> > On Sat, 22 Jan 2011, Rafael J. Wysocki wrote:
> > > > I discovered CONFIG_THINKPAD_ACPI caused suspend-to-disk to hang. I
> > > > need the Thinkpad ACPI to control the fan and bluetooth. It looks like
> > > > the thinkpad acpi is trying acquire locks while suspending.  Disabling
> > > > cmos, light, led and hotkeys makes suspend-to-disk works again.
> > > 
> > > Well, we should tell the thinkpad_acpi maintainer about that, then (CCed).
> > 
> > What are the requirements re. mutexes for sleep-to-disk versus sleep-to-ram?
> 
> No difference.  Basically, there are two differences between suspend and
> hibernation, as far as drivers are concerned:
> (1) It's better to use the ->freeze()/->thaw() and ->poweroff()/->restore()
>     callbacks for hibernation.
> (2) It may be _much_ more difficult to get free memory during hibernation
>     (so theoretically attempts to get memory during hibernation are more likely
>     to block).

So, if there is nothing wrong with mutex use by itself...

Thinkpad-acpi calls the thinkpad firmware (using normal ACPI method calls),
which does SMI traps into the SMBIOS to do whatever it wants done.  And that
includes writing to the NVS (both the peecee RTC CMOS, and ACPI-backed
"NVS").

> Besides, the problem reported by Jeff seems to be caused by CPU hotplug.

Something weird going on with CPU hotplug could throw Lenovo's
way-too-complex-for-comfort SMM firmware out of wack alright.

That can be checked.  Lobotomize the driver so that it does not do the acpi
calls in the suspend path (but keep everything else).  If it still locks, it
is not the firmware.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
