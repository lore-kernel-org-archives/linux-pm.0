From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Tue, 7 Aug 2007 13:15:25 -0700
Message-ID: <200708071315.26082.david-b@pacbell.net>
References: <200708061111.03407.david-b@pacbell.net>
	<20070806222351.090dc035.akpm@linux-foundation.org>
	<20070807125054.GC2833@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070807125054.GC2833@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Replying to points individually, to avoid excessively long emails.

On Tuesday 07 August 2007, Russell King wrote:
> 
> 1. the name sucks - it tells you nothing about it's purpose,

What -- that when it returns true, you "must disable" the clock?

I have a hard time with this claim.  The purpose could hardly become
more clear.  It seems to me that there is some other issue that's not
yet been surfaced here.  (I'll refrain from guessing.)

That said, it seems like this item reflects your core issue.


> 		which as 
>    the name currently stands can be interpreted in as many ways as there
>    are species of animals on this planet.
> 
>    While the comments around the prototype help interpret its semantics,
>    it is no subsitute for having a good name for the function.

Again, the semantics are exactly what the name says.  Hyperbole aside,
I'm in the dark about your real objection here.

- Dave
