From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 19:15:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707151914450.28934-100000__1545.79596496678$1184541428$gmane$org@netrider.rowland.org>
References: <Pine.LNX.4.64.0707151538130.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707151538130.25614@asgard.lang.hm>
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

On Sun, 15 Jul 2007 david@lang.hm wrote:

> >> for a pure hibernate mode, you will be powering off the box after saving
> >> the suspend image. why are there any special ACPI modes involved?
> >
> > Because, for example, on my machine the status of power supply (present
> > vs not present) is not updated correctly after the restore if ACPI callbacks
> > aren't used during the hibernation.  That's just experience and it's in line
> > with the ACPI spec.
> 
> so if a machine is actually powered off the /dev/suspend process won't 
> work?
> 
> remember that the system may run a different OS between the hibernate and 
> the resume, makeing any assumptions about what state the hardware is in 
> when you start the resume is a problem.

As I understand it, running a different OS between the hibernate and 
the resume would violate the ACPI spec.

Alan Stern
