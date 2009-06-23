From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Introduce core framework for run-time PM
	of I/O devices (rev. 3)
Date: Tue, 23 Jun 2009 19:00:03 +0200
Message-ID: <200906231900.04660.rjw__11341.2737533965$1245776541$gmane$org@sisk.pl>
References: <200906230121.18932.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906230121.18932.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 June 2009, Rafael J. Wysocki wrote:
> Hi,
> 
> Below is a new revision of the patch introducing the run-time PM framework.
> 
> The most visible changes from the last version:
> 
> * I realized that if child_count is atomic, we can drop the parent locking from
>   all of the functions, so I did that.
> 
> * Introduced pm_runtime_put() that decrements the resume counter and queues
>   up an idle notification if the counter went down to 0 (and wasn't 0 previously).
>   Using asynchronous notification makes it possible to call pm_runtime_put()
>   from interrupt context, if necessary.
> 
> * Changed the meaning of the RPM_WAKE bit slightly (it is now also used for
>   disabling run-time PM for a device along with the resume counter).
> 
> Please let me know if I've overlooked anything. :-)

Well, I found quite a few problems myself, mostly related to disabling-enabling
of the run-time PM and to RPM_WAKE.

Updated patch will be sent out later today.

Best,
Rafael
