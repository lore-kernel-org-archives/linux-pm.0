From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Mon, 27 Sep 2010 16:39:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009271636170.1751-100000__27918.7554879629$1285620021$gmane$org@iolanthe.rowland.org>
References: <201009272200.49330.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009272200.49330.rjw@sisk.pl>
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
Cc: Partha Basak <p-basak2@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:

> > How about adding another flag to the dev_pm_info structure, to indicate 
> > that the runtime callbacks may be called in interrupt context?
> > 
> > Maybe that will lead to problems I haven't thought of.  But if it seems 
> > okay to you, I can code it up easily enough.
> 
> Hmm.  I was thinking about adding a new RPM_ flag for that, like RPM_FASTPATH,
> telling the PM core to assume the callbacks will not sleep and that the call
> might be from interrupt handler.

That might appear more flexible, but is there any advantage to it?  
That is, would there be a situation where the driver knows that the 
next callback won't sleep but in general the callback might sleep 
sometimes?  It doesn't seem very likely.

Kevin, do you have any feelings about this?

Alan Stern
