From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] PM: Introduce set_target method in
	pm_ops
Date: Sun, 24 Jun 2007 02:03:12 +0200
Message-ID: <200706240203.12970.rjw__24869.8640651584$1182642985$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0706231937010.9663-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706231937010.9663-100000@netrider.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 24 June 2007 01:46, Alan Stern wrote:
> On Sun, 24 Jun 2007, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > The appended patch adds the new pm_ops callback to be used to pass the target
> > system sleep state to the platform core (ACPI core in particular) and reworks
> > the ACPI PM operations to take this callback into account.
> > 
> > When I was working on this patch I thought it might be a good idea to do the
> > following additional changes:
> > * rename pm_ops to something more descriptive, like for example
> >   'platform_suspend_operations'
> > * move the definition of pm_ops (or whatever it will be called) to
> >   <linux/suspend.h>
> > * make the prepare(), enter() and finish() callbacks not take any arguments
> > * clean up the PM-related code in the ARM tree (that, and the previous one,
> >   would require someone to test the changes on these platforms, though)
> > 
> > Comments welcome.
> 
> Is this design okay with system states in which the CPU is able to run?

Do you mean the patch or the suggestions above?

> Right now the states we have are On, Standby, and Suspend, and the CPU
> runs only in the On state.  But on some platforms there could be
> multiple states in which the CPU is able to run, albeit with degraded 
> performance.

I wouldn't call those system sleep states.  For example, ACPI defines system
sleep states as the states in which no instructions are executed by any CPUs
and I think that's reasonable.

Moreover, the ACPI spec insists that transitions between different sleep
states should be made through the On state.

> So for something like Suspend the PM core tells the platform to enter 
> the new state, and when the call returns the system has already left 
> that state.  But with a low-performance On state, when the call returns 
> the system will still be in the new state.
> 
> Is the PM core prepared to handle this difference?

No, I don't think so.  IMO, runtime power management is needed for the
low-performance On states.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
