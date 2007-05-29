From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [3/3] 2.6.22-rc3: known regressions with patches
Date: Tue, 29 May 2007 14:53:48 +0200
Message-ID: <465C225C.7090507@googlemail.com>
References: <465C203A.1020200@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <465C203A.1020200@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: zach@vmware.com, discuss@x86-64.org, Jeff Garzik <jeff@garzik.org>, Ben Collins <ben.collins@ubuntu.com>, Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>, Maximilian Engelhardt <maxi@daemonizer.de>, Alexey Dobriyan <adobriyan@gmail.com>, Pavel Machek <pavel@ucw.cz>, =?ISO-8859-2?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc3
with patches available.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Suspend

Subject    : software suspend doesn't work with 2.6.22-rc3
References : http://lkml.org/lkml/2007/5/26/24
Submitter  : Maximilian Engelhardt <maxi@daemonizer.de>
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
Patch      : http://lkml.org/lkml/2007/5/26/169
Status     : patch available



TTY

Subject    : signal: multithread program returns with wrong errno on rece=
iving SIGSTOP
References : http://lkml.org/lkml/2007/5/27/189
Submitter  : Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Handled-By : Oleg Nesterov <oleg@tv-sign.ru>
Patch      : http://lkml.org/lkml/2007/5/28/27
Status     : patch available



Virtualization

Subject    : build failed in arch/i386/kernel/vmi.c
References : http://lkml.org/lkml/2007/5/24/119
Submitter  : Toralf F=F6rster <toralf.foerster@gmx.de>
Handled-By : Alexey Dobriyan <adobriyan@gmail.com>
Patch      : http://lkml.org/lkml/2007/5/24/143
Status     : patch available



x86-64

Subject    : BUG: at mm/slab.c:777 __find_general_cachep()
References : http://lkml.org/lkml/2007/5/18/17
Submitter  : Jeff Garzik <jeff@garzik.org>
Handled-By : Ben Collins <ben.collins@ubuntu.com>
Patch      : http://lkml.org/lkml/2007/5/18/19
Status     : patch available



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
