From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/2] PM: Fix potential issue with failing
 asynchronous suspend
Date: Mon, 20 Sep 2010 11:59:29 -0700
Message-ID: <20100920185929.GB29380__36027.1419318908$1285013001$gmane$org@suse.de>
References: <201009201957.40995.rjw@sisk.pl> <201009202000.45147.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009202000.45147.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Colin Cross <ccross@android.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 20, 2010 at 08:00:44PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Fix potential issue with failing asynchronous suspend
> 
> There is a potential issue with the asynchronous suspend code that
> a device driver suspending asynchronously may not notice that it
> should back off.  There are two failing scenarions, (1) when the
> driver is waiting for a driver suspending synchronously to complete
> and that second driver returns error code, in which case async_error
> won't be set and the waiting driver will continue suspending and (2)
> after the driver has called device_pm_wait_for_dev() and the waited
> for driver returns error code, in which case the caller of
> device_pm_wait_for_dev() will not know that there was an error and
> will continue suspending.
> 
> To fix this issue make __device_suspend() set async_error, so
> async_suspend() doesn't need to set it any more, and make
> device_pm_wait_for_dev() return async_error, so that its callers
> can check whether or not they should continue suspending.
> 
> No more changes are necessary, since device_pm_wait_for_dev() in
> not used by any drivers' suspend routines.
> 
> Reported-by: Colin Cross <ccross@android.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
