From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 23:54:17 +0200
Message-ID: <200707172354.18738.rjw__9323.64788973263$1184708848$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
	<871wf6g1q1.fsf@jbms.ath.cx>
	<Pine.LNX.4.64.0707171423280.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707171423280.2467@asgard.lang.hm>
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
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 July 2007 23:27, david@lang.hm wrote:
> On Tue, 17 Jul 2007, Jeremy Maitin-Shepard wrote:
> 
> > david@lang.hm writes:
> >
> > [snip]
> >
> >>> How do you guarantee that no tasks are scheduled when you get back to the
> >>> hibernated kernel?
> >
> >> just don't schedule any userspace tasks. all you need to do is to execute the
> >> ACPI sleep functions. you normally do that after stopping userspace
> >> anyway.
> >
> > What does "stopping userspace" mean?  You already said it does not mean
> > disabling interrupts.  But using the freezer is also not an option,
> > since the avoidance of that is the main reason for the kexec approach in
> > the first place.
> 
> just don't schedule any non-kernel threads.
> 
> remember that the normal shutdown/suspend procedure is (from another 
> related thread)
> 
> > >>sys_reboot(LINUX_REBOOT_CMD_KEXEC)
> > >>     kernel_kexec
> > >>         kernel_restart_prepare
> > >>             device_shutdown
> > >>         machine_shutdown
> > >>         machine_kexec
> 
> I'm just saying that instead of going back to the normal operation of the 
> kernel you just go directly to the new shutdown routine instead.
> 
> > [snip]
> >
> >>> Well, not exactly.  If your battery runs out of power while you're suspended,
> >>> but you have the image saved, it's still better to restore from the image,
> >> even
> >>> if something may not work correctly after the restore, than to risk a loss of
> >>> data.
> >
> >> if things don't work correctly you are still risking the loss of data, the user
> >> just doesn't know it.
> >
> > It should be possible on any system to do a hibernate followed by a
> > shutdown (and then resume properly, without any problems).  Thus, for
> > handling suspend to both, you resume as if the system had been shutdown,
> > rather than resuming as if the system came from S4.
> 
> I agree with this, but according to Rafael if the "hibernated" image is 
> assuming that the devices were put into low-power mode by ACPI and you 
> boot up instead the system doesn't work right.

That's correct, some devices don't work right, but these are not disks.  They
usually are devices closely related to the platform, like the embedded
controller.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
