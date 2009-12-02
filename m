From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: allow for usage_count > 0 in
	pm_runtime_get()
Date: Wed, 2 Dec 2009 10:15:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912021013050.11361-100000@iolanthe.rowland.org>
References: <200912020009.57496.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912020009.57496.rjw@sisk.pl>
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

On Wed, 2 Dec 2009, Rafael J. Wysocki wrote:

> > BTW, I just noticed that the runtime_idle method is documented as 
> > returning void but defined in pm.h as returning int.  Obviously the 
> > definition is wrong, since no return value is ever used.  Would you 
> > like to fix it?
> 
> In fact it's been changed to return int at the Matthew's request, because
> bus type code might use the return value from a driver's callback.  In fact
> the PCI runtime PM framework being worked on at the moment uses
> the return value of a driver's runtime_idle(), if implemented.
> 
> So, the documentation has to be changed rather than the definition.

Understood.  When you change it, mention that the PM core doesn't use
the return value from bus subsystems, but the bus might want to use the 
return value from drivers.

Alan Stern
