From: PINTU KUMAR <pintu.k@samsung.com>
Subject: RE: [PATCH v3 1/1] kernel/sysctl.c: Add /proc/sys/vm/shrink_memory
 feature
Date: Wed, 29 Jul 2015 10:41:10 +0530
Message-ID: <030e01d0c9bd$20e1df60$62a59e20$@samsung.com>
References: <1437114578-2502-1-git-send-email-pintu.k@samsung.com>
 <1437366544-32673-1-git-send-email-pintu.k@samsung.com>
 <20150720082810.GG2561@suse.de> <02c601d0c306$f86d30f0$e94792d0$@samsung.com>
 <20150720175538.GJ2561@suse.de> <05af01d0c47f$3337ccd0$99a76670$@samsung.com>
 <20150722140530.GK2561@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <20150722140530.GK2561@suse.de>
Content-language: en-us
Sender: owner-linux-mm@kvack.org
To: 'Mel Gorman' <mgorman@suse.de>
Cc: akpm@linux-foundation.org, corbet@lwn.net, vbabka@suse.cz, gorcunov@openvz.org, mhocko@suse.cz, emunson@akamai.com, kirill.shutemov@linux.intel.com, standby24x7@gmail.com, hannes@cmpxchg.org, vdavydov@parallels.com, hughd@google.com, minchan@kernel.org, tj@kernel.org, rientjes@google.com, xypron.glpk@gmx.de, dzickus@redhat.com, prarit@redhat.com, ebiederm@xmission.com, rostedt@goodmis.org, uobergfe@redhat.com, paulmck@linux.vnet.ibm.com, iamjoonsoo.kim@lge.com, ddstreet@ieee.org, sasha.levin@oracle.com, koct9i@gmail.com, cj@linux.com, opensource.ganesh@gmail.com, vinmenon@codeaurora.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, qiuxishi@huawei.com, Valdis.Kletnieks@vt.edu, cpgs@samsung.com, pintu_agarwal@yahoo.com, vishnu.ps@samsung.com, rohit.kr@samsung.com, iqbal.ams@samsung.com, pintu.ping@gmail.compintu.
List-Id: linux-pm@vger.kernel.org

Sorry, for late reply.

> -----Original Message-----
> From: Mel Gorman [mailto:mgorman@suse.de]
> Sent: Wednesday, July 22, 2015 7:36 PM
> To: PINTU KUMAR
> Cc: akpm@linux-foundation.org; corbet@lwn.net; vbabka@suse.cz;
> gorcunov@openvz.org; mhocko@suse.cz; emunson@akamai.com;
> kirill.shutemov@linux.intel.com; standby24x7@gmail.com;
> hannes@cmpxchg.org; vdavydov@parallels.com; hughd@google.com;
> minchan@kernel.org; tj@kernel.org; rientjes@google.com;
> xypron.glpk@gmx.de; dzickus@redhat.com; prarit@redhat.com;
> ebiederm@xmission.com; rostedt@goodmis.org; uobergfe@redhat.com;
> paulmck@linux.vnet.ibm.com; iamjoonsoo.kim@lge.com; ddstreet@ieee.org;
> sasha.levin@oracle.com; koct9i@gmail.com; cj@linux.com;
> opensource.ganesh@gmail.com; vinmenon@codeaurora.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org; linux-
> pm@vger.kernel.org; qiuxishi@huawei.com; Valdis.Kletnieks@vt.edu;
> cpgs@samsung.com; pintu_agarwal@yahoo.com; vishnu.ps@samsung.com;
> rohit.kr@samsung.com; iqbal.ams@samsung.com; pintu.ping@gmail.com;
> pintu.k@outlook.com
> Subject: Re: [PATCH v3 1/1] kernel/sysctl.c: Add /proc/sys/vm/shrink_memory
> feature
> 
> On Wed, Jul 22, 2015 at 06:33:26PM +0530, PINTU KUMAR wrote:
> > Dear Mel, thank you very much for your comments and suggestions.
> > I will drop this one and look on further improving direct_reclaim and
> > compaction.
> > Just few more comments below before I close.
> >
> > Also, during this patch, I feel that the hibernation_mode part in
> > shrink_all_memory can be corrected.
> > So, can I separately submit the below patch?
> > That is instead of hard-coding the hibernation_mode, we can get
> > hibernation status using:
> > system_entering_hibernation()
> >
> > Please let me know your suggestion about this changes.
> >
> > -#ifdef CONFIG_HIBERNATION
> > +#if defined CONFIG_HIBERNATION || CONFIG_SHRINK_MEMORY
> 
I was talking about only the following case.
Instead of hard coding the hibernation_mode in shrink_all_memory, 
We can set it at runtime.

-               .hibernation_mode = 1,

+       if (system_entering_hibernation())
+               sc.hibernation_mode = 1;
+       else
+               sc.hibernation_mode = 0;

The PM owners should confirm if this is ok.
Once confirmed, I will submit the full patch set.

+> This appears to be a patch on top of "Add /proc/sys/vm/shrink_memory feature"
> so I do not see what would be separately submitted that would make sense.
> 
And we don't need to have /proc/sys/vm/shrink_memory patch for this.

However, if required, we can also expose shrink_all_memory() outside the
hibernation using the CONFIG_SHRINK_MEMORY.
Otherwise, we can neglect other changes.

> --
> Mel Gorman
> SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
