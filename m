From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/19] PM: Rename device_power_down/up()
Date: Fri, 12 Jun 2009 12:51:26 +0200
Message-ID: <20090612105126.GJ18682__31524.2170858712$1244804123$gmane$org@elf.ucw.cz>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
	<S4AoGnG.A.cG.6eYMKB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <S4AoGnG.A.cG.6eYMKB@chimera>
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
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Magnus Damm <damm@igel.co.jp>, Linux PM List <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-06-11 22:37:28, Rafael J. Wysocki wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Rename the functions performing "_noirq" dev_pm_ops
> operations from device_power_down() and device_power_up()
> to device_suspend_noirq() and device_resume_noirq().
> 
> The new function names are chosen to show that the functions
> are responsible for calling the _noirq() versions to finalize
> the suspend/resume operation. The current function names do
> not perform power down/up anymore so the names may be misleading.
> 
> Global function renames:
> - device_power_down() -> device_suspend_noirq()
> - device_power_up() -> device_resume_noirq()
> 
> Static function renames:
> - suspend_device_noirq() -> __device_suspend_noirq()
> - resume_device_noirq() -> __device_resume_noirq()
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> Acked-by: Len Brown <lenb@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
