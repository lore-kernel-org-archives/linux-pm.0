From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: allow for usage_count > 0 in
	pm_runtime_get()
Date: Tue, 1 Dec 2009 11:15:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912011110210.2983-100000@iolanthe.rowland.org>
References: <200911302206.27960.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911302206.27960.rjw@sisk.pl>
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

Rafael:

One other thing I just noticed.  The power.timer_expires field is 
supposed to be nonzero when the timer is scheduled.  But the code at 
the end of pm_schedule_suspend() doesn't check for the possibility that 
the expiration time might just happen to be 0.  If it is, the 
timer_expires value should be bumped up to 1 before the mod_timer() 
call.

Alan Stern
