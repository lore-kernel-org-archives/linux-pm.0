From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Tue, 7 Aug 2007 13:18:37 -0700
Message-ID: <200708071318.37585.david-b@pacbell.net>
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

On Tuesday 07 August 2007, Russell King wrote:
> 2. it's unclear how this function obtains information about the "upcoming
>    system state" and therefore decides whether the particular clock may
>    be available.

Why should any such *implementation detail* matter to an interface spec?

Especially to the clock framework, which has already gone to great
lengths to avoid constraining implementations, and allow them to do
whatever the platform needs.  (Admittedly, some people don't think
of that as a feature.)

- Dave
