From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 6/8] Schedule sysrq poweroff on boot cpu
Date: Thu, 10 Jul 2008 13:36:44 +0200
Message-ID: <20080710113643.GF15412__47081.9424991079$1215702948$gmane$org@elf.ucw.cz>
References: <200807100152.17755.rjw@sisk.pl> <200807100204.25010.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807100204.25010.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Rus <harbour@sfinx.od.ua>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-07-10 02:04:24, Rafael J. Wysocki wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> Subject: Schedule sysrq poweroff on boot cpu
> 
> schedule sysrq poweroff on boot cpu.
> 
> sysrq poweroff needs to disable nonboot cpus, and we need to run this
> on boot cpu to avoid any recursion.
> http://bugzilla.kernel.org/show_bug.cgi?id=10897
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> tested-by: Rus <harbour@sfinx.od.ua>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
