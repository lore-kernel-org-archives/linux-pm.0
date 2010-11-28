From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Prevent dpm_prepare() from returning
 errors unnecessarily
Date: Sun, 28 Nov 2010 10:35:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011281031240.27303-100000__32712.1416609318$1290958626$gmane$org@netrider.rowland.org>
References: <201011281312.49949.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011281312.49949.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 28 Nov 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Currently dpm_prepare() returns error code if it finds that a device
> being suspended has a pending runtime resume request.  However, it
> should not do that if the checking for wakeup events is not enabled.

It doesn't.  The line you changed _does_ check device_may_wakeup().

> On the other hand, if the checking for wakeup events is enabled, it
> can return error when a wakeup event is detected, regardless of its
> source.

Will adding this call to pm_wakeup_event() end up double-counting some 
events?

Alan Stern
