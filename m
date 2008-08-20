From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/6] Container Freezer: Fix freezer Kconfig
Date: Wed, 20 Aug 2008 18:42:12 +0200
Message-ID: <20080820164212.GA7686__35827.6751045652$1219252222$gmane$org@ucw.cz>
References: <20080819232232.432973784@us.ibm.com>
	<20080819232233.028111599@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080819232233.028111599@us.ibm.com>
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

On Tue 2008-08-19 16:22:33, Matt Helsley wrote:
> kernel/power/Kconfig is not sourced from all architectures but the freezer code
> should be available to all architectures for the cgroup freezer subsystem.
> Sourcing a new kernel/Kconfig.freezer has the added advantage of keeping the
> config definition close to its use in the kernel/Makefile.
> 
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
