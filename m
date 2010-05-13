From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 23:57:33 +0200
Message-ID: <201005132357.33385.rjw__14618.9493280419$1273789475$gmane$org@sisk.pl>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<201005132314.22497.rjw@sisk.pl>
	<20100513213121.GJ3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513213121.GJ3428@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arve@smtp1.linux-foundation.org, Kernel development list <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@ericsson.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 13 May 2010, Tony Lindgren wrote:
> * Rafael J. Wysocki <rjw@sisk.pl> [100513 14:08]:
> > On Thursday 13 May 2010, Tony Lindgren wrote:
> > > 
> > > The difference between echo mem > /sys/power/state and suspend blocks
> > > is that with suspend blocks the system keeps running.
> > 
> > Care to elaborate?
> 
> The suspend blocks affects the runtime behaviour of the system by
> categorizing apps into good and bad apps in a weird way.

I don't see this, can you please explain?

Rafael
