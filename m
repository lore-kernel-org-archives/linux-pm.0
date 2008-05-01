From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc0
Date: Thu, 1 May 2008 02:39:47 -0400
Message-ID: <200805010239.48789.lenb__23106.468426022$1209624116$gmane$org@kernel.org>
References: <200804301420.11696.lenb@kernel.org>
	<alpine.LFD.1.10.0804301153100.2980@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0804301153100.2980@woody.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 30 April 2008, Linus Torvalds wrote:
> 
> On Wed, 30 Apr 2008, Len Brown wrote:
> > 
> > please pull from: 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> Ok, this clashed in some nasty ways in drivers/acpi/video.c due to the 
> non-racy /proc file creation changes that came through Andrew. I fixed up 
> the result, and it *looks* sane (and compiles), but I didn't actually test 
> it, and I don't know the code well. Can you double-check.

Thanks for merging video.c
When I did my builds, andrew had not yet scribbled on video.c.
I usually do a "last minute" pull to make sure you are not faced
with any merges, but this time when I did I got some version of your
tree that wouldn't build so I figured it was still moving and didn't
bother merging with it.

Anyway, I looked over this file and the things I looked for seemed okay,
but to be sure I'll repeat your merge tomorrow and see if I come
up with the same thing.

> There were some (smaller) rejects in drivers/misc/intel_menlow.c due to 
> two different versions of the same patch from Julia Lawall (again, the 
> other came through Andrew), and I picked the one from Andrew because it 
> had the later date. But again, you should double-check.

You picked the right one.
Indeed, it looks like the other files touched in Julia's earlier
patch (9030062f3d61f87c1e787b3aa134fa3a8e4b2d25)
don't handle the failure case quite right --
Rui and I will follow-up.

thanks,
-Len
