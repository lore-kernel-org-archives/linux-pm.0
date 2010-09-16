From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Fix potential issue with failing
	asynchronous suspend (was: Re: [PATCH] PM: Prevent waiting ...)
Date: Thu, 16 Sep 2010 23:24:18 +0200
Message-ID: <201009162324.19109.rjw__7593.9790848226$1284672434$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1009161655470.1695-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009161655470.1695-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Colin Cross <ccross@android.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 16, 2010, Alan Stern wrote:
> On Thu, 16 Sep 2010, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM: Fix potential issue with failing asynchronous suspend
> > 
> > There is a potential issue with the asynchronous suspend code that
> > a device driver suspending asynchronously may not notice that it
> > should back off.  There are two failing scenarions, (1) when the
> > driver is waiting for a driver suspending synchronously to complete
> > and that second driver returns error code, in which case async_error
> > won't be set and the waiting driver will continue suspending and (2)
> > after the driver has called device_pm_wait_for_dev() and the waited
> > for driver returns error code, in which case the caller of
> > device_pm_wait_for_dev() will not know that there was an error and
> > will continue suspending.
> > 
> > To fix this issue make __device_suspend() set async_error, so
> > async_suspend() doesn't need to set it any more, and make
> > device_pm_wait_for_dev() return async_error, so that its callers
> > can check whether or not they should continue suspending.
> > 
> > No more changes are necessary, since device_pm_wait_for_dev() is
> > not used by any drivers' suspend routines at the moment.
> 
> You just squeaked by, since it is _is_ being used by a USB _resume_
> routine.  :-)

I know that, but resume actually doesn't need to care about async_error.

Thanks,
Rafael
