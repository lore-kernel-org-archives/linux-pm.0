From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/6] PM/Hibernate: Rework shrinking of memory
Date: Thu, 14 May 2009 19:49:52 +0200
Message-ID: <200905141949.53108.rjw__24996.0065623329$1242323745$gmane$org@sisk.pl>
References: <200905070040.08561.rjw@sisk.pl> <200905132356.39481.rjw@sisk.pl>
	<20090514094046.GF6417@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090514094046.GF6417@elf.ucw.cz>
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>, fengguang.wu@intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 14 May 2009, Pavel Machek wrote:
> 
> > > > > The main point (I thought) was to remove shrink_all_memory().  Instead,
> > > > > we're retaining it and adding even more stuff?
> > > > 
> > > > The idea is that afterwards we can drop shrink_all_memory() once the
> > > > performance problem has been resolved.  Also, we now allocate memory for the
> > > > image using GFP_KERNEL instead of doing it with GFP_ATOMIC after freezing
> > > > devices.  I'd think that's an improvement?
> > > 
> > > Dunno.  GFP_KERNEL might attempt to do writeback/swapout/etc, which
> > > could be embarrassing if the devices are frozen.
> > 
> > They aren't, because the preallocation is done upfront, so once the OOM killer
> > has been taken care of, it's totally safe. :-)
> 
> As is GFP_ATOMIC. Except that GFP_KERNEL will cause catastrophic
> consequences when accounting goes wrong. (New kernel's idea of what is
> on disk will differ from what is _really_ on disk.)
> 
> If accounting is right, GFP_ATOMIC and GFP_KERNEL is equivalent.
> 
> If accounting is wrong, GFP_ATOMIC will fail with NULL, while
> GFP_KERNEL will do something bad.
> 
> I'd keep GFP_ATOMIC (or GFP_NOIO or similar). 

Repeating myself: with this and the next patch applied, we preallocate memory
for the image _before_ freezing devices and therefore it is safe to use
GFP_KERNEL, because the OOM killer has been taken care of by [3/6].

Thanks,
Rafael
