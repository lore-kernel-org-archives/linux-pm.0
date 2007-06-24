From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH -mm] PM: Introduce set_target method in
	pm_ops
Date: Sat, 23 Jun 2007 20:28:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706232026460.9663-100000__7220.49473920396$1182645268$gmane$org@netrider.rowland.org>
References: <200706240203.12970.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706240203.12970.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Jun 2007, Rafael J. Wysocki wrote:

> > Is this design okay with system states in which the CPU is able to run?
> 
> Do you mean the patch or the suggestions above?

The suggestions.

> > Right now the states we have are On, Standby, and Suspend, and the CPU
> > runs only in the On state.  But on some platforms there could be
> > multiple states in which the CPU is able to run, albeit with degraded 
> > performance.
> 
> I wouldn't call those system sleep states.  For example, ACPI defines system
> sleep states as the states in which no instructions are executed by any CPUs
> and I think that's reasonable.
> 
> Moreover, the ACPI spec insists that transitions between different sleep
> states should be made through the On state.

Okay.  But on non-ACPI systems, do we want to restrict the 
/sys/power/state interface to sleep states?  How then should the user 
tell the system to go to a low-performance run state?  Or should that 
be handled automatically within the kernel?

Alan Stern
