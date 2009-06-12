From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/19] PM core: rename suspend and resume
	functions
Date: Fri, 12 Jun 2009 12:55:35 +0200
Message-ID: <20090612105535.GK18682__32499.005032196$1244804437$gmane$org@elf.ucw.cz>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
	<S4AoGnG.A.mG.jfYMKB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <S4AoGnG.A.mG.jfYMKB@chimera>
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

On Thu 2009-06-11 22:38:06, Rafael J. Wysocki wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> This patch (as1241) renames a bunch of functions in the PM core.
> Rather than go through a boring list of name changes, suffice it to
> say that in the end we have a bunch of pairs of functions:
> 
> 	device_resume_noirq	dpm_resume_noirq
> 	device_resume		dpm_resume
> 	device_complete		dpm_complete
> 	device_suspend_noirq	dpm_suspend_noirq
> 	device_suspend		dpm_suspend
> 	device_prepare		dpm_prepare
> 
> in which device_X does the X operation on a single device and dpm_X
> invokes device_X for all devices in the dpm_list.
> 
> In addition, the old dpm_power_up and device_resume_noirq have been
> combined into a single function (dpm_resume_noirq).
> 
> Lastly, dpm_suspend_start and dpm_resume_end are the renamed versions
> of the former top-level device_suspend and device_resume routines.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Magnus Damm <damm@igel.co.jp>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
