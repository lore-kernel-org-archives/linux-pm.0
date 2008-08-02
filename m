From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 2/6] Container Freezer: Make refrigerator
	always	available
Date: Fri, 01 Aug 2008 19:30:26 -0700
Message-ID: <1217644226.25300.296.camel__48486.3740428866$1217888057$gmane$org@localhost.localdomain>
References: <20080801050659.924495279@us.ibm.com>
	<20080801162712.63721e8c@surf>
	<1217617689.25300.213.camel@localhost.localdomain>
	<200808020053.18638.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4865641831580519610=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808020053.18638.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-embedded@vger.kernel.org, Michael Opdenacker <michael@free-electrons.com>, Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, linux-pm@lists.linux-foundation.org, "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Menage <menage@google.com>
List-Id: linux-pm@vger.kernel.org

--===============4865641831580519610==
Content-Type: text/plain; charset=UTF-7
Content-Transfer-Encoding: 7bit


On Sat, 2008-08-02 at 00:53 +-0200, Rafael J. Wysocki wrote:
+AD4 On Friday, 1 of August 2008, Matt Helsley wrote:
+AD4 +AD4 
+AD4 +AD4 On Fri, 2008-08-01 at 16:27 +-0200, Thomas Petazzoni wrote:
+AD4 +AD4 +AD4 Hi,
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Le Thu, 31 Jul 2008 22:07:01 -0700,
+AD4 +AD4 +AD4 Matt Helsley +ADw-matthltc+AEA-us.ibm.com+AD4 a +AOk-crit :
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 --- a/kernel/Makefile
+AD4 +AD4 +AD4 +AD4 +-+-+- b/kernel/Makefile
+AD4 +AD4 +AD4 +AD4 +AEAAQA -5,7 +-5,7 +AEAAQA
+AD4 +AD4 +AD4 +AD4  obj-y     +AD0 sched.o fork.o exec+AF8-domain.o panic.o printk.o +AFw
+AD4 +AD4 +AD4 +AD4  	    cpu.o exit.o itimer.o time.o softirq.o resource.o +AFw
+AD4 +AD4 +AD4 +AD4  	    sysctl.o capability.o ptrace.o timer.o user.o +AFw
+AD4 +AD4 +AD4 +AD4 -	    signal.o sys.o kmod.o workqueue.o pid.o +AFw
+AD4 +AD4 +AD4 +AD4 +-	    signal.o sys.o kmod.o workqueue.o pid.o freezer.o +AFw
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 I have the impression that the code in kernel/power/process.c was
+AD4 +AD4 +AD4 compiled only if CONFIG+AF8-PM+AF8-SLEEP was set. Now that the code has been
+AD4 +AD4 +AD4 moved to kernel/freezer.c, it is unconditionnaly compiled in every
+AD4 +AD4 +AD4 kernel. Is that correct ?
+AD4 +AD4 +AD4
+AD4 +AD4 +AD4 If so, is it possible to put this new feature under some
+AD4 +AD4 +AD4 CONFIG+AF8-SOMETHING option, for people who care about the kernel size ?
+AD4 +AD4 
+AD4 +AD4 	How about making it depend on a combination of CONFIG variables?
+AD4 +AD4 Here's an RFC PATCH. Completely untested.
+AD4 +AD4 
+AD4 +AD4 Signed-off-by: Matt Helsley +ADw-matthltc+AEA-us.ibm.com+AD4
+AD4 
+AD4 Can you please also make the contents of include/linux/freezer.h depend on
+AD4 CONFIG+AF8-FREEZER instead of CONFIG+AF8-PM+AF8-SLEEP?

Done.

+AD4 Also, I'm not really sure if kernel/power/Kconfig is the right place to define
+AD4 CONFIG+AF8-FREEZER.
+AD4 
+AD4 Perhaps we should even move freezer.c from kernel/power to kernel
+AD4 and define CONFIG+AF8-FREEZER in Kconfig in there.  Andrew, what do you think?

	I'll check this weekend for replies and repost the RFC PATCH on Monday
if I don't hear anything. In the meantime I'll be doing some config
build testing with the above changes to make sure it's correct.

Cheers,
	-Matt


--===============4865641831580519610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4865641831580519610==--
