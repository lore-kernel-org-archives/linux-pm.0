From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [Regression] firewire_ohci causes system resume to
	fail
Date: Sun, 5 Dec 2010 16:17:58 +0100
Message-ID: <20101205161758.2d75c65d@stein>
References: <201012051542.31826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012051542.31826.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Dec 05 Rafael J. Wysocki wrote:
> There is a regression I can reproduce 100% of the time on a AMD-based desktop
> box that resume from hibernation (or suspend) fails because of the firewire_ohci
> module.  The box just hangs when firewire_ohci resume runs, apparently, and it
> is sufficient to do:
> 
> # echo devices > /sys/power/pm_test
> # echo disk > /sys/power/state
> 
> to reproduce the issue.

Do you have anything attached to the FireWire bus?  What controller do
you have?

> It definitely works with 2.6.34, but it fails with 2.6.37-rc4+ (latest mainline).
> I haven't tested the kernels in between, but I'm going to do that later today
> or some time next week.
> 
> If you have any idea about what may be the reason, please let me know.

As first quick thought:  While we of course need to have a look at
firewire-ohci changes, it could also be a higher-level issue in
firewire-core.  E.g. something with the 2.6.36 workqueue related core
kernel changes.  (I am only saying so because I noticed some module
unloading issues with the firewire stack lately that seem workqueue
related.)

I admit that PM suspend/resume or hibernate/restore are not part of my
personal firewire driver testing regime.  I need to address that.

I Cc'd Maxim Levitsky who has working firewire suspend/resume on
2.6.37-rc, although with some minor firewire-net related and
isochronous I/O related nits for which he sent fixes lately:
http://marc.info/?l=linux1394-devel&m=129099665721794
http://marc.info/?l=linux1394-devel&m=129099666021798
But I do not think that these could matter to your hang-at-resume issue.
-- 
Stefan Richter
-=====-==-=- ==-- --=-=
http://arcgraph.de/sr/
