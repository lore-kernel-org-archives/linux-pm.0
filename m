From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] PM: Introduce core framework for
	run-time PM of I/O devices
Date: Sat, 27 Jun 2009 23:52:40 +0200
Message-ID: <200906272352.42022.rjw__41470.5593059354$1246139583$gmane$org@sisk.pl>
References: <200906140023.36147.rjw@sisk.pl> <200906150057.32424.rjw@sisk.pl>
	<20090624150400.GG1784@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090624150400.GG1784@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday 24 June 2009, Pavel Machek wrote:
> Hi!
> 
> 
> > +2. Run-time PM Helper Functions and Device Fields
> > +
> > +The following helper functions are defined in drivers/base/power/runtime.c
> > +and include/linux/pm_runtime.h:
> > +
> > +* void pm_runtime_init(struct device *dev);
> > +* void pm_runtime_enable(struct device *dev);
> > +* void pm_runtime_disable(struct device *dev);
> > +* int pm_runtime_suspend(struct device *dev);
> > +* void pm_request_suspend(struct device *dev, unsigned long delay);
> > +* int pm_runtime_resume(struct device *dev);
> > +* void pm_request_resume(struct device *dev);
> > +* void pm_cancel_runtime_suspend(struct device *dev);
> > +* void pm_cancel_runtime_resume(struct device *dev);
> > +* void pm_suspend_check_children(struct device *dev, bool enable);
> 
> Those *s look confusingly like pointers. Remove them?

>From the doc?  OK, I can use another character. :-)

Best,
Rafael
