From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] pm: rework includes, remove arch ifdefs V2
Date: Tue, 10 Mar 2009 12:24:18 +0100
Message-ID: <20090310112418.GG1337__25261.6511578255$1236684622$gmane$org@ucw.cz>
References: <20090225035929.18506.46282.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090225035929.18506.46282.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 2009-02-25 12:59:29, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch contains the following header file changes:
>  - remove arch ifdefs and asm/suspend.h from linux/suspend.h
>  - add asm/suspend.h to disk.c (for arch_prepare_suspend())
>  - add linux/io.h to swsusp.c (for ioremap())
>  - x86 32/64 bit compile fixes

Looks ok to me, but I did not test it. ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
