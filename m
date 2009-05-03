From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] PM/Hibernate: Use memory allocations to
	free memory (rev. 2)
Date: Sun, 3 May 2009 18:15:32 +0200
Message-ID: <200905031815.33455.rjw__20788.243719335$1241367539$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905030224.21471.rjw@sisk.pl>
	<alpine.LFD.2.01.0905021958480.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.01.0905021958480.4983@localhost.localdomain>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, kernel-testers@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 03 May 2009, Linus Torvalds wrote:
> 
> On Sun, 3 May 2009, Rafael J. Wysocki wrote:
> >
> > Remove the shrinking of memory from the suspend-to-RAM code, where it is 
> > not really necessary.
> 
> Hmm. Shouldn't we do this _regardless_?
> 
> IOW, shouldn't this be a totally separate patch? It seems to be left-over 
> from when we shared the same code-paths, and before the split of the STR 
> and hibernate code?
> 
> IOW, shouldn't the very _first_ patch just be this part? That code doesn't 
> make any sense anyway (that FREE_PAGE_NUMBER really _is_ totally 
> arbitrary).
> 
> This part seems to be totally independent of all the other parts in your 
> patch-series. No?

I'm removing this along with shrink_all_memory() which it depends on, but I can
put that into a separate patch if you prefer.

Thanks,
Rafael
