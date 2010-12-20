From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 19 Dec 2010 22:37:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012192226270.31110-100000__29144.6020630703$1292816364$gmane$org@netrider.rowland.org>
References: <201012191122.09581.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012191122.09581.rjw@sisk.pl>
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
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sun, 19 Dec 2010, Rafael J. Wysocki wrote:

> That said, I think we may do something different that perhaps will make your
> life somewhat easier.
> 
> Namely, if your driver doesn't implement any system suspend callbacks
> (i.e. ->suspend(), ->resume(), ->freeze(), ->thaw() etc.) and it doesn't
> want the analogous subsystem callbacks to be executed for the device, it will
> make sense to flag the device as "runtime only", or something like this,
> which make the PM core skip the device in dpm_suspend() etc.
> 
> In that case, if a device if flagged as "runtime only", we can avoid
> calling pm_runtime_get_noirq() for it in dpm_prepare() and, analogously,
> calling pm_runtime_put_sync() for it in dpm_complete().  However, we will have
> to fail system suspend (or hibernation) if a "runtime only" device has the
> power.runtime_auto flag unset.

Or more generally, if pm_runtime_suspended() doesn't return 'true' for 
the device.  But if the device gets suspended asynchronously, this may 
very well happen.  For example, an i2c device is originally runtime 
suspended, but its device_suspend() call occurs at the same time as the 
call for the RTC device, so the i2c device actually happens to be 
resumed at that time in order to communicate with the RTC.

> So, I think we can add a "runtime only" flag working as described above.
> I guess it will also help in the case I've been discussing with Kevin for some
> time (i2c device using runtime PM used by an RTC in a semi-transparent
> fashion).
> 
> Alan, what do you think?

I'm not sure.  In this situation, should we worry more that we usually
do about the possibility of a runtime resume occurring after the device
has gone through device_suspend()?  Or just depend on the driver to do
everything correctly?

Alan Stern
