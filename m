From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] PM/Hibernate: Use memory allocations to
	free memory (rev. 2)
Date: Sun, 3 May 2009 18:35:06 +0200
Message-ID: <200905031835.06928.rjw__40752.1403897137$1241368663$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<alpine.LFD.2.01.0905021958480.4983@localhost.localdomain>
	<20090503093659.GA10278@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090503093659.GA10278@elf.ucw.cz>
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
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, kernel-testers@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 03 May 2009, Pavel Machek wrote:
> Hi!

Hi,

> > > Remove the shrinking of memory from the suspend-to-RAM code, where it is 
> > > not really necessary.
> > 
> > Hmm. Shouldn't we do this _regardless_?
> > 
> > IOW, shouldn't this be a totally separate patch? It seems to be left-over 
> > from when we shared the same code-paths, and before the split of the STR 
> > and hibernate code?
> > 
> > IOW, shouldn't the very _first_ patch just be this part? That code doesn't 
> > make any sense anyway (that FREE_PAGE_NUMBER really _is_ totally 
> > arbitrary).
> > 
> > This part seems to be totally independent of all the other parts in your 
> > patch-series. No?
> 
> I'm not sure this one is a good idea: drivers will need to allocate
> memory during suspend/resume, and when processes are frozen/disk
> driver is suspended, normal memory management will no longer work.
> 
> So, freeing 4M of memory before starting suspend seems like a good
> idea. That way those small alocations will not fail.

I don't think we've ever had problems with the drivers having too little
memory to suspend.

I'm opting for removing this code and seeing if that leads to any regressions.
If it does, we can still get some free memory by allocating and releasing it.

Thanks,
Rafael
