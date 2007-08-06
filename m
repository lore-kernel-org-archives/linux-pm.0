From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 2/2] AT91 implements
	clk_must_disable()
Date: Mon, 6 Aug 2007 11:23:30 -0700
Message-ID: <200708061123.30727.david-b@pacbell.net>
References: <200708061112.23177.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708061112.23177.david-b@pacbell.net>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Monday 06 August 2007, David Brownell wrote:
> This supports the clk_must_disable() interface for AT91 systems:
> ...

Note that these two patches have now become a build fix, courtesy of
a 2.6.22-early patch:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=94bed2a9c4ae980838003f5d32681eef794ecc28

When these patches were posted before, nobody objected; so I'm
assuming nobody's had a change-of-mind.  They're obviously
correct, and I've been running with them for over a year now
(which explains why my at91 builds still work).

So these should probably be fast-tracked into kernel.org ...

- Dave
