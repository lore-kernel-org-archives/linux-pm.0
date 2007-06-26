From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target
	method in pm_ops
Date: Tue, 26 Jun 2007 10:19:58 -0700
Message-ID: <200706261019.59712.david-b__13033.5618080155$1182878686$gmane$org@pacbell.net>
References: <200706242239.05678.rjw@sisk.pl>
	<1182806886.6644.4.camel@johannes.berg>
	<200706261141.35071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706261141.35071.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 26 June 2007, Rafael J. Wysocki wrote:

> Alternatively, I could write that the argument passed to .enter() etc. is
> guaranteed to be the same as the one passed to .set_target(), but I didn't want
> to say that. :-)

Why not?  So long as enter() takes an argument, that seems
to me exactly what it should guarantee.  Although that 
argument should vanish; any platform that differentiates
what it does based on that parameter can just be required
to provide a set_target() method.

- Dave
