From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] PM: Handle unregistering devices
	during	suspend/hibernation
Date: Fri, 22 Feb 2008 19:47:37 -0800
Message-ID: <20080223034737.GA25876__18116.0282729708$1203738488$gmane$org@suse.de>
References: <200802230053.12180.rjw@sisk.pl> <20080223000222.GA26104@suse.de>
	<200802230121.50232.rjw@sisk.pl> <200802230219.28191.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802230219.28191.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 23, 2008 at 02:19:27AM +0100, Rafael J. Wysocki wrote:
> On Saturday, 23 of February 2008, Rafael J. Wysocki wrote:
> > On Saturday, 23 of February 2008, Greg KH wrote:
> > > On Sat, Feb 23, 2008 at 12:53:11AM +0100, Rafael J. Wysocki wrote:
> > > > Hi Greg,
> > > > 
> > > > The appended patch fixes the issue with the new code for suspending/resuming
> > > > devices, related to the fact that some device drivers and CPU hotplug notifiers
> > > > unregister device objects while suspend is in progress, which leads to
> > > > deadlocks.
> > > > 
> > > > Please consider taking it for 2.6.25.
> 
> Ouch, please disregard this patch.
> 
> Alan rightfully noticed that it may confuse subsystems assuming that after
> device_unregister() has returned, the driver's ->release() method has run.
> 
> Unfortunately, he did that in a Bugzilla comment that has never reached
> my mailbox (strangely enough, I haven't been receiving any messages from
> the Bugzilla for the last two days or so).
> 
> Sorry for the trouble.

No problem at all.

thanks,

greg k-h
