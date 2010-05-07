From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 13:53:29 -0700
Message-ID: <20100507205329.GP387__29452.5968529799$1273265682$gmane$org@atomide.com>
References: <20100507175025.GA23952@srcf.ucam.org>
	<20100507180152.GH387@atomide.com>
	<20100507182824.GA25198@srcf.ucam.org>
	<20100507184333.GL387@atomide.com>
	<20100507184621.GA25978@srcf.ucam.org>
	<1273259186.3542.93.camel@c-dwalke-linux.qualcomm.com>
	<20100507192837.GM387@atomide.com>
	<20100507193353.GA27175@srcf.ucam.org>
	<20100507195548.GN387@atomide.com>
	<20100507202859.GA27328@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507202859.GA27328@srcf.ucam.org>
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

* Matthew Garrett <mjg@redhat.com> [100507 13:24]:
> On Fri, May 07, 2010 at 12:55:48PM -0700, Tony Lindgren wrote:
> 
> > - Deal with broken apps whichever way you want in the userspace.
> 
> If we could do this then there would be no real need for suspend 
> blockers.

OK, I guess I don't understand all the details, need some kind
of common example I guess.

So for example, if I leave ping running in a a terminal, do you
have some way of preventing that from eating the battery?

In my scenario that program would keep on running until the
battery runs out, or something stops the program. But the system
keeps hitting retention mode in the idle loop.

How do you deal with programs like that?

Do you just suspend the whole system anyways at some point,
or do you have some other trick?

Regards,

Tony
