From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH -mm] PM: Introduce set_target method in
	pm_ops
Date: Sat, 23 Jun 2007 19:46:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706231937010.9663-100000__39658.2502210096$1182642429$gmane$org@netrider.rowland.org>
References: <200706240001.00608.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706240001.00608.rjw@sisk.pl>
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

> Hi,
> 
> The appended patch adds the new pm_ops callback to be used to pass the target
> system sleep state to the platform core (ACPI core in particular) and reworks
> the ACPI PM operations to take this callback into account.
> 
> When I was working on this patch I thought it might be a good idea to do the
> following additional changes:
> * rename pm_ops to something more descriptive, like for example
>   'platform_suspend_operations'
> * move the definition of pm_ops (or whatever it will be called) to
>   <linux/suspend.h>
> * make the prepare(), enter() and finish() callbacks not take any arguments
> * clean up the PM-related code in the ARM tree (that, and the previous one,
>   would require someone to test the changes on these platforms, though)
> 
> Comments welcome.

Is this design okay with system states in which the CPU is able to run?

Right now the states we have are On, Standby, and Suspend, and the CPU
runs only in the On state.  But on some platforms there could be
multiple states in which the CPU is able to run, albeit with degraded 
performance.

So for something like Suspend the PM core tells the platform to enter 
the new state, and when the call returns the system has already left 
that state.  But with a low-performance On state, when the call returns 
the system will still be in the new state.

Is the PM core prepared to handle this difference?

Alan Stern
