From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/6] Container Freezer: uninline
	thaw_process()
Date: Wed, 20 Aug 2008 18:44:36 +0200
Message-ID: <20080820164435.GB7686__39924.5752756999$1219252259$gmane$org@ucw.cz>
References: <20080819232232.432973784@us.ibm.com>
	<20080819232233.732140572@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080819232233.732140572@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Paul Menage <menage@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue 2008-08-19 16:22:34, Matt Helsley wrote:
> Now that the cgroup freezer system also calls thaw_process() inlining these
> functions uses more space. Uninlining returns some space:
> 
> Before:
> 	text	data	bss	dec	hex	filename
> 	4260872	275532	290816	4827220 49a854	vmlinux
> After:
> 	text	data	bss	dec	hex	filename
> 	4260852	275532	290816	4827200	49a840	vmlinux


20 bytes...

Does it still compile out if freezer is disabled?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
