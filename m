From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
 before hibernation/suspend
Date: Mon, 28 May 2007 11:55:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705281151250.22682-100000@netrider.rowland.org>
References: <200705272231.54535.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705272231.54535.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 27 May 2007, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Use a hibernation and suspend notifier to disable the firmware requesting
> mechanism before a hibernation/suspend and enable it after the operation.

You're using the PM_PRE_FREEZE and PM_POST_THAW notifiers for both this 
and the userspace helper change.  Is it your intention that drivers 
should continue to request these services but encounter an error if the 
request occurs at the wrong time?  Or do you expect drivers to use the 
notifier chains to know when they shouldn't make any requests?

In the second case you may have a problem, because there's no 
specification about the order in which the notifiers are sent.  The 
service may get disabled before the driver learns it isn't available, 
or the driver may think the service is once again available before it 
gets enabled.

Alan Stern
