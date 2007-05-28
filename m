From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 19:43:24 +0200
Message-ID: <200705281943.25129.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705281151250.22682-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705281151250.22682-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 28 May 2007 17:55, Alan Stern wrote:
> On Sun, 27 May 2007, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Use a hibernation and suspend notifier to disable the firmware requesting
> > mechanism before a hibernation/suspend and enable it after the operation.
> 
> You're using the PM_PRE_FREEZE and PM_POST_THAW notifiers for both this 
> and the userspace helper change.  Is it your intention that drivers 
> should continue to request these services but encounter an error if the 
> request occurs at the wrong time?  Or do you expect drivers to use the 
> notifier chains to know when they shouldn't make any requests?

In fact, I'd like drivers to use notifiers to actually load the firmware into
memory before hibernation/suspend.  Namely, if there's PM_PRE_FREEZE, the
driver calls request_firmware() from within the notifier and saves the firmware
in memory for future use, if need be.  Later, when PM_POST_THAW comes, the
memory holding the firmware is released.

Unfortunately there are drivers that call request_firmware() directly from
.resume() which blocks until timeout expires and fails anyway.  I just wanted
this to fail immediately, without waiting.

> In the second case you may have a problem, because there's no 
> specification about the order in which the notifiers are sent.  The 
> service may get disabled before the driver learns it isn't available, 
> or the driver may think the service is once again available before it 
> gets enabled.

Yes.

Greetings,
Rafael
