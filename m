From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sun, 6 May 2007 00:16:48 +0200
Message-ID: <200705060016.49119.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705051742100.27516-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705051742100.27516-100000@netrider.rowland.org>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, 5 May 2007 23:43, Alan Stern wrote:
> On Sat, 5 May 2007, Rafael J. Wysocki wrote:
> 
> > > I'm also pointing out that the policy choice decided by the contents of 
> > > /sys/power/disk comes into play during steps 6-7 above, but not at all in 
> > > steps 1-5.  Hence any associated software structures should explicitly be 
> > > connected only with steps 6 and 7.
> > 
> > At present, this policy choice does affect the earlier steps too.
> 
> Isn't this then another aspect of hibernation needing to be fixed?  Or is 
> there some genuine reason I'm not aware of that the choice of shutdown 
> method should affect those steps?

Well, I think it should be fixed, but I'm afraid that'll take a *lot* of time.

Greetings,
Rafael
