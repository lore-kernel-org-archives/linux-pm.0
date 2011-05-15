From: Michael Leun <lkml20100708@newton.leun.net>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Sun, 15 May 2011 14:20:18 +0200
Message-ID: <20110515142018.081d8a47__18943.6221182861$1305564318$gmane$org@xenia.leun.net>
References: <201105120025.34531.rjw@sisk.pl>
	<20110514102804.GB23665@htj.dyndns.org>
	<BANLkTik1nFKX1Eyov_o0Xd0rr01Si5hSqA@mail.gmail.com>
	<201105151125.19614.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105151125.19614.rjw@sisk.pl>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jian Peng <jipeng2005@gmail.com>, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 May 2011 11:25:19 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday, May 15, 2011, Jian Peng wrote:
> > Hi, Michael/Rafael/Gu,
> > 
> > Could you help me understand the testing environme? I like to
> > reproduce it if it is possible and debug it. The host controller
> > this patch dealing with is not used on PC so my testing environment
> > is quite different.

We have seen it on at least 3 different controllers from at least 2
different vendors (I do not know, what hardware Gu has).

So, for now, it looks like to happen on more different controllers than
not.

Testing environment - uhm, what shall I say? On each of the two
notebooks affected runs 64bit openSuSE 11.4 in more or less default
configuration (apart from kernel, of course).

Just do a "ls -lR /" and watch kernel log while plugging/unplugging
power.

Maybe running a 64bit system/kernel is part of picture? As far as I can
see all affected machines run 64bit.

> Well, the system I can reproduce it on is a production one, so I can't
> really test too much on it.  What exactly would you like to do?

I've at least one machine available where I can test. So, if there is
anything (preferably non destructive ;-) ) you want me to test this
should be possible.

Maybe I'll have a look if my netbook (running 32bit) is also affected.

-- 
MfG,

Michael Leun
