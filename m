From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Mon, 18 Jan 2010 00:00:23 +0100
Message-ID: <201001180000.23376.rjw__11038.2145191126$1263769288$gmane$org@sisk.pl>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001171427.27954.rjw@sisk.pl> <1263754684.724.444.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1263754684.724.444.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 17 January 2010, Benjamin Herrenschmidt wrote:
> On Sun, 2010-01-17 at 14:27 +0100, Rafael J. Wysocki wrote:
...
> However, it's hard to deal with the case of allocations that have
> already started waiting for IOs. It might be possible to have some VM
> hook to make them wakeup, re-evaluate the situation and get out of that
> code path but in any case it would be tricky.

In the second version of the patch I used an rwsem that made us wait for these
allocations to complete before we changed gfp_allowed_mask.

[This is kinda buggy in the version I sent, but I'm going to send an update
in a minute.]

Rafael
