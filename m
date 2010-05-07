From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 15:00:26 -0700
Message-ID: <20100507220026.GS387__48384.0402951047$1273269697$gmane$org@atomide.com>
References: <20100507192837.GM387@atomide.com>
	<20100507193353.GA27175@srcf.ucam.org>
	<20100507195548.GN387@atomide.com>
	<20100507202859.GA27328@srcf.ucam.org>
	<20100507205329.GP387@atomide.com>
	<20100507210304.GA28701@srcf.ucam.org>
	<20100507212556.GQ387@atomide.com>
	<20100507213917.GE28906@srcf.ucam.org>
	<20100507214211.GR387@atomide.com>
	<20100507214855.GA30190@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507214855.GA30190@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100507 14:44]:
> On Fri, May 07, 2010 at 02:42:11PM -0700, Tony Lindgren wrote:
> > * Matthew Garrett <mjg@redhat.com> [100507 14:34]:
> > > How do you know to wake the process up in response to the keypress?
> > 
> > Does it matter for processes that are not "certified"? Maybe you
> > could assume that you can keep it stopped until the screen is on
> > again, or some other policy.
> 
> Yes, it matters. You don't necessarily know whether to turn the screen 
> on until the app has had an opportunity to process the event. This is 
> exactly the kind of use case that suspend blocks are intended to allow, 
> so alternatives that don't permit that kind of use case aren't really 
> adequate alternatives.

Hmm, I'm thinking there would not be any need to turn the screen on
for the broken apps until some other event such as a tap on the screen
triggers the need to turn the screen on.

If it's a critical app, then it should be fixed so it's safe to keep
running.

And yeah, I guess you could cgroups to categorize "timer certified"
and "broken" apps.

Regards,

Tony
