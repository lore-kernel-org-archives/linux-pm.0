From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [3/3] 2.6.23-rc2: known regressions v2
Date: Fri, 10 Aug 2007 22:06:57 +0200
Message-ID: <200708102206.58438.rjw__14915.7615182505$1186775896$gmane$org@sisk.pl>
References: <46B9F664.9060600@googlemail.com> <200708102124.01218.rjw@sisk.pl>
	<Pine.SOC.4.64.0708102220290.14225@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.SOC.4.64.0708102220290.14225@math.ut.ee>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Meelis Roos <mroos@linux.ee>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 10 August 2007 21:29, Meelis Roos wrote:
> > 1. Is that with the same .config you sent me previously?
> 
> Yes, just ran it through make oldconfig again, included below.
> 
> > 2. What exactly is the consequence of this warning?
> 
> I hope no big trouble (i.e. only a warning during make *config) but I 
> haven't boot-tested rc2 and newer kernels yet because it's a remote 
> machine. Will try some day now.
> 
> > 3. Can you please check if this patch changes anything:
> > http://marc.info/?l=linux-mm-commits&m=118669680811669&w=2
> 
> Tried it on current git, kernel/power/Kconfig gave 2 rejects.
> Tried on 2.6.23-rc2, still 2 rejects from the same file, .rej below:

Sorry, but:

rafael@albercik:~/src/linux-2.6> git-pull git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Already up-to-date.
rafael@albercik:~/src/linux-2.6> cat ~/pm-fix-dependencies-of-config_suspend-and-config_hibernation-updated-3x.patch | patch -p1
patching file arch/x86_64/defconfig
patching file include/linux/cpu.h
patching file kernel/cpu.c
patching file kernel/power/Kconfig

How come?

Greetings,
Rafael
