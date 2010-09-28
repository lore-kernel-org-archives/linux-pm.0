From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Tue, 28 Sep 2010 20:19:07 +0200
Message-ID: <201009282019.07598.rjw__34620.8613868386$1285698064$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1009281033230.17050-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009281033230.17050-100000@iolanthe.rowland.org>
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
Cc: Partha Basak <p-basak2@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 28, 2010, Alan Stern wrote:
> On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:
> 
> > On Monday, September 27, 2010, Alan Stern wrote:
> > > On Mon, 27 Sep 2010, Rafael J. Wysocki wrote:
...
> Given this, I see no point in adding a special per-call flag.
> 
> There's another advantage to using a per-device flag.  Not all resume
> calls are initiated by the driver; the PM core has to start a resume on
> its own when rpm_resume sees that the device's parent is suspended.  
> When this happens, the nested resume can be carried out with interrupts
> disabled if the parent's driver supports it -- and the PM core won't
> know that unless there's a flag for it in dev_pm_info.

OK, go for it, then.

Thanks,
Rafael
