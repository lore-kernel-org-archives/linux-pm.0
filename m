From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Re: Runtime PM: Calling Device runtime PM callbacks?
Date: Tue, 15 Dec 2009 08:41:52 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298D7D7EB96@bgsmsx502.gar.corp.intel.com>
References: <Pine.LNX.4.44L0.0912141805170.2690-100000@iolanthe.rowland.org>
	<200912150026.43688.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912150026.43688.rjw@sisk.pl>
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

> Hmm.  Actually, are we ever going to call two or more suspend callbacks (ie.
> bus type one and device type one or device type one and device class one)
> for the same device?  If not, we'll be able to simplify things significantly
> by making them mutually exclusive (ie. if there's bus type, call bus type,
> or else if there's device type, call device type, or else if there's device
> class, call device class).

Was about to ask this question. What is the advantage of calling all of the 
device's bus type, device type and device class runtime suspend callbacks?

Regards,
Nithish Mahalingam
