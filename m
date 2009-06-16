From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] PM: Introduce core framework for
 run-time PM of I/O devices
Date: Tue, 16 Jun 2009 10:30:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906161028480.3740-100000__36538.0939482295$1245162830$gmane$org@iolanthe.rowland.org>
References: <200906160121.40843.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906160121.40843.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Jun 2009, Rafael J. Wysocki wrote:

> > Since pm_runtime_resume() takes care of powering up the parent, there's 
> > no need for pm_request_resume() to worry about it also.
> 
> But still it won't hurt to do it IMO, because the parents are then going to be
> resumed before our pm_runtime_resume() is called.

It's extra code that isn't needed.  In essence, you are trading code
space for a shorter runtime stack.

> > The documentation should mention that the runtime_suspend method is 
> > supposed to enable remote wakeup if it as available and if 
> > device_may_wakeup(dev) is true.
> 
> Well, I thought that was obvious. :-)

Sometimes it doesn't hurt to state the obvious!  :-)

Alan Stern
