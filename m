From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Hibernate: Restore old swap signature
	to avoid user space breakage
Date: Sat, 11 Dec 2010 21:36:23 +0100
Message-ID: <201012112136.23543.rjw__40356.8628397354$1292099888$gmane$org@sisk.pl>
References: <201012052324.30231.rjw@sisk.pl> <201012112058.09689.rjw@sisk.pl>
	<1292099420.1630.3.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1292099420.1630.3.camel@shrek.rexursive.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bojan Smojver <bojan@rexursive.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Karel Zak <kzak@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <linux@treblig.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 11, 2010, Bojan Smojver wrote:
> On Sat, 2010-12-11 at 20:58 +0100, Rafael J. Wysocki wrote:
> > I'm afraid I'll have to push this patch to Linus.  Turns out that
> > Fedora 14 doesn't pass the resume= argument to the kernel and tries to
> > trigger the resume from initramfs.  Since the signature changed, it
> > can't find the image and the resume fails, even if both the resume and
> > image kernels are the same. 
> 
> Why don't you just file a Fedora bug asking for the library to be
> upgraded or patched?

Because that wouldn't fix the user space that _already_ is out there.

> PS. Karel, who also replied to this thread, has a Red Hat address and he
> seems to be the maintainer of util-linux-ng package. He should be able
> to fix this.

That doesn't matter.  The rule is we don't break user space, even if it does
unreasonable things.

Thanks,
Rafael
