From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mmotm] fbmem: fix fb_info->lock and
	mm->mmap_sem circular locking dependency
Date: Thu, 5 Feb 2009 02:49:25 +0100
Message-ID: <200902050249.27244.rjw__25763.3792971776$1233798978$gmane$org@sisk.pl>
References: <498817E2.3020008@gmail.com>
	<1233783983-28802-1-git-send-email-righi.andrea@gmail.com>
	<200902050058.31680.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902050058.31680.rjw@sisk.pl>
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
To: Andrea Righi <righi.andrea@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 05 February 2009, Rafael J. Wysocki wrote:
> On Wednesday 04 February 2009, Andrea Righi wrote:
> > Fix this circular locking dependencies in the frame buffer console
> > driver pushing down the mutex fb_info->lock.
> > 
> > Circular locking dependecies occur calling the blocking
> > fb_notifier_call_chain() with fb_info->lock held. Notifier callbacks can
> > try to acquire mm->mmap_sem, while fb_mmap() acquires the locks in the
> > reverse order mm->mmap_sem => fb_info->lock.
> 
> Does this fix a Bugzilla bug?  If so, then which one?

Never mind, found it.

Thanks,
Rafael
