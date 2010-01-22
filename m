From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
	disabling device run-time PM (rev. 2)
Date: Fri, 22 Jan 2010 23:55:55 +0100
Message-ID: <201001222355.55676.rjw__7302.42793583802$1264200988$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1001221740270.20253-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1001221740270.20253-100000@netrider.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Friday 22 January 2010, Alan Stern wrote:
> On Fri, 22 Jan 2010, Rafael J. Wysocki wrote:
> 
> > > For example, we disable runtime PM for most USB devices by default.  
> > > But a few drivers may know that their devices are able to handle it, so 
> > > they want to change the default setting when they are bound.
> > 
> > Runtime PM is disabled for all devices by default unless the driver enables
> > it.  The setting in power/control is to override the driver's choice, so that
> > it can be disabled even if the driver tries to enable it.
> > 
> > IOW, the user space is the owner of the power.runtime_auto flag and I don't
> > think we should allow drivers to modify it.
> 
> Okay, I understand your point of view.  It means I'll have to make some 
> changes to the USB code.  No problem.

Great, thanks a lot.

Rafael
