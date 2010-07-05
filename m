From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: mmotm 2010-07-01 pm_get_wakeup_count() declaration
Date: Mon, 5 Jul 2010 22:43:55 +0200
Message-ID: <201007052243.55551.rjw__26942.8424457603$1278362826$gmane$org@sisk.pl>
References: <201007011948.o61JmnT2022795@imap1.linux-foundation.org>
	<74766.1278362136@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <74766.1278362136@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Valdis.Kletnieks@vt.edu
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 05, 2010, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 01 Jul 2010 12:19:51 PDT, akpm@linux-foundation.org said:
> > The mm-of-the-moment snapshot 2010-07-01-12-19 has been uploaded to
> 
> Not sure who to blame for the commit, it was in the linux-next.patch and I'm
> too lazy to pull down the git tree and dig it out.
> 
>   CC      kernel/power/main.o
> kernel/power/main.c: In function 'wakeup_count_show':
> kernel/power/main.c:241: error: implicit declaration of function 'pm_get_wakeup_count'
> kernel/power/main.c: In function 'wakeup_count_store':
> kernel/power/main.c:251: error: implicit declaration of function 'pm_save_wakeup_count'
> make[2]: *** [kernel/power/main.o] Error 1
> 
> Problem is that declaration in include/linux/suspend.h is wrapped in
> a #ifdef CONFIG_PM_SLEEP, but the usage in kernel/power/main.c isn't. So
> it dies a horrid death if your config doesn't include PM_SLEEP.

Yeah, sorry.  I'm in the process of fixing it up.

Thanks,
Rafael
