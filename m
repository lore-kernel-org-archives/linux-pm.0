From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] power: disable hibernation if module loading
	is disabled
Date: Sat, 5 Mar 2011 12:24:18 +0100
Message-ID: <201103051224.18621.rjw__39725.9355093867$1299324424$gmane$org@sisk.pl>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<201103042330.25079.rjw@sisk.pl> <20110305103444.GA26773@albatros>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110305103444.GA26773@albatros>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, March 05, 2011, Vasiliy Kulikov wrote:
> On Fri, Mar 04, 2011 at 23:30 +0100, Rafael J. Wysocki wrote:
> > modules_disabled surely is not the right interface to disable hibernation
> > and I don't really think there's a bug because it doesn't work as you'd like
> > it to.  In fact, there would be a bug if it did work that way.
> 
> What do you mean here?  Do you agree that you may read kernel image,
> slightly change it (including e.g. possible checksums, I didn't bother
> to check how much one should change), and write it back?

Yes, you can, but that's not the point.  The point is that calling an interface
that disables all possible functionality modifying kernel memory
"modules_disabled" is completely dumb.  Sorry, but that's how it goes.

As I said before, if you want to have such an interface, call it properly
and introduce it along with documentation instead of changing an existing
one in a backwards-incopmatible fashion that in addition is totally
confusing.

Moreover, how are you going to protect your "protect kernel memory from
modification" interface itself from root access?
