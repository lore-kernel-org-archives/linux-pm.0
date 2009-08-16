From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sun, 16 Aug 2009 11:50:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908161130590.6522-100000__27828.3674306751$1250437911$gmane$org@netrider.rowland.org>
References: <200908152254.23227.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908152254.23227.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 15 Aug 2009, Rafael J. Wysocki wrote:

> > The only remaining question is how to expose this in sysfs in a way 
> > that won't be confusing and that won't be confused with the "wakeup" 
> > attribute.  One possibility is to use the "level" attribute introduced 
> > in USB; possible levels are "on" (no runtime PM) and "auto" (runtime 
> > PM allowed).  Then a new "runtime_wakeup" attribute could contain 
> > nothing (if wakeup is not available), "enabled", or "disabled".
> 
> That seems to require two flags.
> 
> runtime_forbidden - if unset, the driver decides whether or not to use runtime
>   PM; that could be exposed through sysfs as 'runtime' under the 'power'
>   subdirectory with the following values:
>   * 'disabled' - runtime_forbidden is set by the user space
>   * 'on' - runtime_forbidden is unset, runtime PM is used (disable_depth == 0)
>   * 'off' - runtime_forbidden is unset, runtime PM is not used
>   To set/unset the user space writes 'enabled'/'disabled' to it, respectively.
>   The default is unset.

Too confusing.  The difference between "disabled" and "off" is so
subtle that even I don't understand it!

All we need for this is a simple on/off switch.  Or to be consistent
with the terms that are already exposed to userspace for USB devices:  
"auto"/"on", where "auto" means the system automatically changes power
levels (runtime PM is enabled) and "on" means the device is always on
(runtime PM is disabled).

And I don't like the "runtime_forbidden" name either.  It's long and
it's a negative, making it harder to understand.  ("off" means that the
device is permanently on!)  What's wrong with "level", as in
"power/level"?  That seems very intuitive.

> runtime_wakeup - if set, the device is allowed to do remote wakeup at run time
>   That could be represented as 'runtime_wakeup' under 'power' with the
>   following values:
>   * no value (empty file) is 'runtime' is 'disabled'
>   * 'enabled'
>   * 'disabled'
>   To set/unset the user space writes 'enabled'/'disabled' to it, respectively.
>   The default is set.

This is okay except for your definition of empty file.  This makes it
dependent on the power/level setting.  The two should be independent.  
Thus, empty file should mean that the device doesn't support remote
wakeup, in which case writes are ignored.

This scheme, like yours, requires two new bitflags.  We could call them
something like "may_runtime_suspend" and "may_runtime_wakeup".

Alan Stern
