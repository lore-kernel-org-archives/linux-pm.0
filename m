From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH] PM / Hibernate: Restore old swap signature
 to avoid user space breakage
Date: Sun, 12 Dec 2010 07:47:20 +1100
Message-ID: <1292100440.1630.11.camel__12725.9474633776$1292100494$gmane$org@shrek.rexursive.com>
References: <201012052324.30231.rjw@sisk.pl> <201012112058.09689.rjw@sisk.pl>
	<1292099420.1630.3.camel@shrek.rexursive.com>
	<201012112136.23543.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012112136.23543.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Karel Zak <kzak@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <linux@treblig.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-12-11 at 21:36 +0100, Rafael J. Wysocki wrote:

> Because that wouldn't fix the user space that _already_ is out there.

Of course. I'm sure there are other things in various new kernel that
older user space isn't aware of. It just depends on how far back you
wish to go.

> That doesn't matter.  The rule is we don't break user space, even if it does
> unreasonable things.

But it won't really be broken. I actually tested compression patches on
F-14. All you need to do is pass resume argument to grub for 2.6.37
kernel you installed by hand (and at present, you can only do this by
hand). If Fedora folks decide to upgrade the kernel to 2.6.37 for F-14
(they already have for F-15, so they must be aware of the issue), I'm
sure they'll fix util-linux-ng, dracut and whatever else is required for
this to work.

PS. Koji build of the kernel for F-15, based in 2.6.37-rc5:

http://koji.fedoraproject.org/koji/buildinfo?buildID=208625

-- 
Bojan
