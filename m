From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sat, 15 Aug 2009 22:54:23 +0200
Message-ID: <200908152254.23227.rjw__16521.2986329154$1250369696$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908151143560.18415-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908151143560.18415-100000@netrider.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 15 August 2009, Alan Stern wrote:
> On Sat, 15 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > > Why don't we add a flag indicating whether or not the device is allowed to
> > > > be power managed at run time, something like runtime_forbidden, that the
> > > > user space will be able to set through sysfs?
> > > 
> > > I think even having a runtime_wakeup flag (which defaults to on) would 
> > > be sufficient.
> > 
> > Perhaps it would, but then unsetting runtime_wakeup would effectively disable
> > runtime PM for devices that need it to be power managed at run time (probably
> > all input devices).  Also there may be situations in which user space may
> > really want to disable runtime PM for some devices (think of broken hardware
> > for one example).
> 
> It sounds like there are really three choices here, and the decision 
> should largely be left up to the user:
> 
> 	1. don't use runtime PM,
> 
> 	2. allow runtime PM but disable remote wakeup,
> 
> 	3. allow runtime PM with remote wakeup enabled.
> 
> Now, a driver may say "I can't do my job without remote wakeup".  Such
> a driver would refuse to do runtime_suspend in case 2.  But otherwise
> we should follow the preference of the user.
> 
> The only remaining question is how to expose this in sysfs in a way 
> that won't be confusing and that won't be confused with the "wakeup" 
> attribute.  One possibility is to use the "level" attribute introduced 
> in USB; possible levels are "on" (no runtime PM) and "auto" (runtime 
> PM allowed).  Then a new "runtime_wakeup" attribute could contain 
> nothing (if wakeup is not available), "enabled", or "disabled".

That seems to require two flags.

runtime_forbidden - if unset, the driver decides whether or not to use runtime
  PM; that could be exposed through sysfs as 'runtime' under the 'power'
  subdirectory with the following values:
  * 'disabled' - runtime_forbidden is set by the user space
  * 'on' - runtime_forbidden is unset, runtime PM is used (disable_depth == 0)
  * 'off' - runtime_forbidden is unset, runtime PM is not used
  To set/unset the user space writes 'enabled'/'disabled' to it, respectively.
  The default is unset.

runtime_wakeup - if set, the device is allowed to do remote wakeup at run time
  That could be represented as 'runtime_wakeup' under 'power' with the
  following values:
  * no value (empty file) is 'runtime' is 'disabled'
  * 'enabled'
  * 'disabled'
  To set/unset the user space writes 'enabled'/'disabled' to it, respectively.
  The default is set.

Thanks,
Rafael
