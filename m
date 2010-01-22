From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
 suspend/resume (was: Re: Memory allocations in .suspend became very
 unreliable)
Date: Fri, 22 Jan 2010 12:11:07 +0200
Message-ID: <1264155067.15930.4.camel__7676.58999325267$1264155264$gmane$org@maxim-laptop>
References: <201001212121.50272.rjw@sisk.pl>
	<20100122100155.6C03.A69D9226@jp.fujitsu.com>
	<20100122103830.6C09.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100122103830.6C09.A69D9226@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-01-22 at 10:42 +0900, KOSAKI Motohiro wrote: 
> > > > Probably we have multiple option. but I don't think GFP_NOIO is good
> > > > option. It assume the system have lots non-dirty cache memory and it isn't
> > > > guranteed.
> > > 
> > > Basically nothing is guaranteed in this case.  However, does it actually make
> > > things _worse_?  
> > 
> > Hmm..
> > Do you mean we don't need to prevent accidental suspend failure?
> > Perhaps, I did misunderstand your intention. If you think your patch solve
> > this this issue, I still disagree. but If you think your patch mitigate
> > the pain of this issue, I agree it. I don't have any reason to oppose your
> > first patch.
> 
> One question. Have anyone tested Rafael's $subject patch? 
> Please post test result. if the issue disapper by the patch, we can
> suppose the slowness is caused by i/o layer.

I did.

As far as I could see, patch does solve the problem I described.

Does it affect speed of suspend? I can't say for sure. It seems to be
the same.

Best regards,
Maxim Levitsky
