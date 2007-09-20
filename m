From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Thu, 20 Sep 2007 12:09:41 +0200
Message-ID: <20070920100941.GA12157__24805.2514893518$1190283138$gmane$org@atrey.karlin.mff.cuni.cz>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1190266447.21818.17.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch implements the functionality of jumping between the kexeced
> kernel and the original kernel.
> 
> A new reboot command named LINUX_REBOOT_CMD_KJUMP is defined to
> trigger the jumping to (executing) the new kernel and jumping back to
> the original kernel.
> 
> To support jumping between two kernels, before jumping to (executing)
> the new kernel and jumping back to the original kernel, the devices
> are put into quiescent state (to be fully implemented), and the state
> of devices and CPU is saved. After jumping back from kexeced kernel
> and jumping to the new kernel, the state of devices and CPU are
> restored accordingly. The devices/CPU state save/restore code of
> software suspend is called to implement corresponding function.
> 
> To support jumping without preserving memory. One shadow backup page
> is allocated for each page used by new (kexeced) kernel. When do
> kexec_load, the image of new kernel is loaded into shadow pages, and
> before executing, the original pages and the shadow pages are swapped,
> so the contents of original pages are backuped. Before jumping to the
> new (kexeced) kernel and after jumping back to the original kernel,
> the original pages and the shadow pages are swapped too.
> 
> A jump back protocol is defined and documented.


> Signed-off-by: Huang Ying <ying.huang@intel.com>

Seems like good enough for -mm to me.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
