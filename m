From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH] PM / Hibernate: Restore old swap signature
 to avoid user space breakage
Date: Sun, 12 Dec 2010 07:30:20 +1100
Message-ID: <1292099420.1630.3.camel__44131.0004135177$1292099475$gmane$org@shrek.rexursive.com>
References: <201012052324.30231.rjw@sisk.pl>
	<1291592215.2866.3.camel@shrek.rexursive.com>
	<201012112058.09689.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012112058.09689.rjw@sisk.pl>
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

On Sat, 2010-12-11 at 20:58 +0100, Rafael J. Wysocki wrote:
> I'm afraid I'll have to push this patch to Linus.  Turns out that
> Fedora 14 doesn't pass the resume= argument to the kernel and tries to
> trigger the resume from initramfs.  Since the signature changed, it
> can't find the image and the resume fails, even if both the resume and
> image kernels are the same. 

Why don't you just file a Fedora bug asking for the library to be
upgraded or patched?

PS. Karel, who also replied to this thread, has a Red Hat address and he
seems to be the maintainer of util-linux-ng package. He should be able
to fix this.

-- 
Bojan
