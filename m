From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Weird suspend/resume problem on HP nx6325 w/ openSUSE
	11.2 w/ -rc8
Date: Sun, 22 Nov 2009 00:15:30 +0100
Message-ID: <200911220015.30912.rjw__40136.2116136172$1258845357$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, DRI <dri-devel@lists.sourceforge.net>, Dave Airlie <airlied@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I'm not really sure where this should be reported, but here it goes.

After installing openSUSE 11.2 on my testbed nx6325 I noticed that resume
(from suspend to RAM) stopped working on it.  Apparently, it hanged while
switching from the console back to X and the box remained completely
unresponsive after that (it didn't even react to the magic sysrq).  However,
it used to work just fine with -rc7 and openSUSE 11.1, so I figured the problem
was related to the new X driver, which is radeon module version 6.12.4 (xorg
server 1.6.5).

So, I started to investigate and found that after a suspend from a framebuffer
console, the resume had always worked.  However, when I switched from X to the
framebuffer console, suspended, resumed and switched back to X, the box hanged
immediately just like during resume after a suspend from under X.  [There also
were some problems when switching from X to the framebuffer console and back
which seemd to be independent of suspend/resume (in short, the screen stays
black after a switch from the framebuffer console to X and you need to kill X
to fix this).]

Later, however, I discovered that if the box was booted into runlevel 3, then
suspended to RAM and resumed, and then switched to runlevel 5, I could log
into X and suspend/resume without any problems for many times.  OTOH, after
booting directly into X, the first attempt to resume always resulted in a black
screen and a hard hang.

I wonder what's up in there.

[Hibernation/resume works 100% of the time AFAICS.]

Thanks,
Rafael
