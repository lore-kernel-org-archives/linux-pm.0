From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Mon, 14 Dec 2009 09:06:08 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298D7D7E71E@bgsmsx502.gar.corp.intel.com>
References: <Pine.LNX.4.44L0.0912131348300.2857-100000@netrider.rowland.org>
	<200912140103.23415.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912140103.23415.rjw@sisk.pl>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> There you go (untested for now).
> 
> ->runtime_idle() is still only called for the device's bus type, because
> otherwise it will be hard to determine the right ordering of the bus type,
> device type and device class callbacks.
> 
> Comments welcome. :-)

Looks good Rafael and exactly what I was looking for.


I had one more question -

+The ->runtime_suspend() callback is executed by the PM core for the bus type,
+device type and device class of the device being suspended.  The bus type,
+device type and device class callbacks are then _entirely_ _responsible_ for
+handling the device as appropriate, which may, but need not include executing
+the device driver's own ->runtime_suspend() callback (from the PM core's point
+of view it is not necessary to implement a ->runtime_suspend() callback in a
+device driver as long as the bus type, device type and device class
+->runtime_suspend() know what to do to handle the device).

Any specific reason why from PM core we should not call the device driver's 
->runtime_suspend() or ->runtime_resume()? I know one of either the bus/
class/type should implement device suspend but what if (worst case) none of 
them are doing it? Is it OK in that case (alone) to call device driver's 
runtime PM directly (if it is implemented) from the runtime PM core?


Regards,
Nithish Mahalingam
