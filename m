From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH 3/3 -mm] kexec based hibernation -v6:
	kexec hibernate/resume
Date: Tue, 20 Nov 2007 09:58:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711200949590.3931-100000__4724.11011946878$1195570788$gmane$org@iolanthe.rowland.org>
References: <1195527033.11955.50.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1195527033.11955.50.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Nov 2007, Huang, Ying wrote:

> - What is the difference between PMSG_SUSPEND and PMSG_FREEZE?

SUSPEND means that the system is about to go into a low-power state, so 
the driver should take the appropriate action to reduce the device's 
power consumption.  It should also stop all I/O and DMA to the device.  
Interrupts can remain enabled if the device is supposed to be a wakeup 
source; otherwise they should be disabled.

FREEZE means that the system is going to hibernate, and devices need to
be quiescent (no I/O, no DMA, and no interrupts) so that an atomic
memory snapshot can be captured.  The driver should take the
appropriate action to quiesce the device but the power level doesn't
need to change.

PRETHAW means that the system is going to resume from hibernation by
loading a previously-saved memory snapshot.  The driver should take the
appropriate action to quiesce the device (no I/O, no DMA, and no
interrupts) so that the snapshot can be safely restored, but the power
level doesn't need to change.  The driver may also want to put the
device into a special state so that the saved kernel's resume method
will recognize the device has undergone a hibernation cycle and needs
to be reinitialized.

Alan Stern
