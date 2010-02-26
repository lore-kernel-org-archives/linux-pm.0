From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add dpm_use_runtime_{suspend,
	resume} helper functions
Date: Fri, 26 Feb 2010 17:06:59 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002261702070.2029-100000@iolanthe.rowland.org>
References: <201002262224.02694.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002262224.02694.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Feb 2010, Rafael J. Wysocki wrote:

> I have one problem with the design.  Namely, dpm_invoke_runtime_*() can
> run a callback from another subsystem.  Say you are a device class and you
> decide to use dpm_invoke_runtime_*(), but the device's bus type implements
> the runtime PM callbacks, so they will be run as device class suspend and
> resume callbacks.  That doesn't look particularly clean to me.

That is a valid point.  I suppose there could be separate bus-type, 
device-type, and device-class versions of these functions, but that 
seems like excessive complication with little real benefit.

Mark and Kevin, do you have any thoughts on this?

Alan Stern
