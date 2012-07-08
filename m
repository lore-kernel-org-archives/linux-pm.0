From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: use of pm_runtime_disable() from driver probe?
Date: Sat, 7 Jul 2012 22:01:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1207072155400.508-100000@netrider.rowland.org>
References: <201207072125.26189.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201207072125.26189.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 7 Jul 2012, Rafael J. Wysocki wrote:

> > What is the right way to handle the runtime PM enable/disable in a
> > failed probe attempt?
> 
> I would recommend using pm_runtime_disable() and then either
> pm_runtime_set_active() or pm_runtime_set_suspended() depending on what the
> real power state of the device is at this point.
> 
> Anyway, you can't force the device into a low-power state using runtime PM
> after a failing probe, at least in general.

Right.  About the best you could do would be to call the appropriate 
runtime_suspend method directly, instead of going through the runtime 
PM core.  However, if the probe is failing then there's no reason to 
think the runtime_suspend method will work.

Basically, on the platform bus, if you don't have a driver for a device 
(which you don't, if the probe routine fails) then you can't do runtime 
PM on it.

But what if the device belongs to a PM domain?  Putting the entire
domain back into a low-power state might have the desired effect -- but
the probe routine wouldn't be able to do this.  The platform subsystem
would have to take care of it somehow.

Alan Stern
