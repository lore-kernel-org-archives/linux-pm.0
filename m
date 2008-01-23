From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: invoke suspend notifications after console
	switch
Date: Wed, 23 Jan 2008 19:03:29 +0100
Message-ID: <200801231903.30293.rjw@sisk.pl>
References: <1197853799.4885.7.camel@johannes.berg>
	<20080111182042.GC4016@ucw.cz> <200801231607.46112.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801231607.46112.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 23 of January 2008, Rafael J. Wysocki wrote:
> On Friday, 11 of January 2008, Pavel Machek wrote:
> > On Thu 2008-01-10 14:14:36, Johannes Berg wrote:
> > > 
> > > On Mon, 2007-12-17 at 02:09 +0100, Johannes Berg wrote:
> > > > A subsequent patch will enable apm-emulation notification for suspends
> > > > triggered in any way by using the suspend notifications. This causes
> > > > the system to lock up between X being needed to switch away from the
> > > > VT and X already waiting for resume in the apm ioctl.
> > > > 
> > > > This patch moves the console switch (if enabled) before the suspend
> > > > notification (and after the resume notification) to avoid this issue.
> > > 
> > > I don't see this in the suspend git tree yet, anything wrong with it?
> > 
> > Its pretty intrusive I'd say.

How so?  There's only one user of the suspend notifiers right now, AFAICS.

> > And it is wrong; we'd prefer userspace 
> > to know what we are doing; if they are told we are suspending,
> > userspace may be able to do something more clever than long console
> > switch.

Well, we're not telling the userspace that we're suspending right now.

Also, the patch only reorders the console switch vs the suspend notifiers.
The console switch still happens before the freezer is run.

Thanks,
Rafael
