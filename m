From: Yuasa Yoichi <tripeaks@gmail.com>
Subject: Re: [GIT PULL] MIPS build fix related to power
	management for 3.0
Date: Tue, 19 Jul 2011 14:35:00 +0900
Message-ID: <CACBHAewP5twv0X=SOJw+Yb0HVvr7binRQ+VknSzh6=dVBPw_ww__17415.0897576057$1311053767$gmane$org@mail.gmail.com>
References: <201107162350.51025.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107162350.51025.rjw@sisk.pl>
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
Cc: linux-mips@linux-mips.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org

Hi,

2011/7/17 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi Linus,
>
> Please pull a MIPS build fix related to PM for 3.0 from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes
>
> It fixes a build regression resulting from a missing conversion from using
> a sysdev to using syscore_ops for PM/shutdown in the MIPS tree.

It has already been fixed in MIPS tree.

Yoichi
