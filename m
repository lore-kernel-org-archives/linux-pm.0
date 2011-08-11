From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for Aug 11 (suspend_stats build
	error)
Date: Thu, 11 Aug 2011 11:59:31 -0700
Message-ID: <20110811115931.8007900d.rdunlap@xenotime.net>
References: <20110811162058.42b462bc80e67d7a80ecff93@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110811162058.42b462bc80e67d7a80ecff93@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Aug 2011 16:20:58 +1000 Stephen Rothwell wrote:

> Hi all,

When CONFIG_PM_SLEEP is not enabled:

kernel/built-in.o: In function `suspend_stats_show':
main.c:(.text+0x40a25): undefined reference to `suspend_stats'
main.c:(.text+0x40a2c): undefined reference to `suspend_stats'
main.c:(.text+0x40a32): undefined reference to `suspend_stats'
main.c:(.text+0x40a73): undefined reference to `suspend_stats'
main.c:(.text+0x40a82): undefined reference to `suspend_stats'
kernel/built-in.o:main.c:(.text+0x40a91): more undefined references to `suspend_stats' follow


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
