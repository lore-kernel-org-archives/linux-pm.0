From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/6] PM/Hibernate: Do not release
	preallocated memory unnecessarily (rev. 2)
Date: Thu, 14 May 2009 19:52:20 +0200
Message-ID: <200905141952.21267.rjw__8886.83816087923$1242323831$gmane$org@sisk.pl>
References: <200905070040.08561.rjw@sisk.pl> <200905131040.37831.rjw@sisk.pl>
	<20090514110958.GA8871@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090514110958.GA8871@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 14 May 2009, Pavel Machek wrote:
> Hi!
> 
> > Since the hibernation code is now going to use allocations of memory
> > to make enough room for the image, it can also use the page frames
> > allocated at this stage as image page frames.  The low-level
> > hibernation code needs to be rearranged for this purpose, but it
> > allows us to avoid freeing a great number of pages and allocating
> > these same pages once again later, so it generally is worth doing.
> > 
> > [rev. 2: Take highmem into account correctly.]
> 
> I don't get it. What is advantage of this patch? It makes the code
> more complex... Is it supposed to be faster?

Yes, in some test cases it is reported to be faster (along with [4/6],
actually).

Besides, we'd like to get rid of shrink_all_memory() eventually and it is a
step in this direction.

Thanks,
Rafael
