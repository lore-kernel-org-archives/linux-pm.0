From: Daniel Drake <dsd@laptop.org>
Subject: Re: Trying to understand new wakeup events architecture
Date: Thu, 16 Dec 2010 14:39:09 +0000
Message-ID: <AANLkTinw9MXSXV3FNp-b1S0bpBVBoLJi7CUhC0=2Pgg0@mail.gmail.com>
References: <AANLkTik0y2O4GTvoFkm-94iSWdWUG8juZ0cBNWXDas8Q@mail.gmail.com>
	<201012152333.43644.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012152333.43644.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 15 December 2010 22:33, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> I guess it's sufficient to read the article at http://lwn.net/Articles/416690/
> (or the PDF linked from there is that's not enough :-)).

Thanks, that helps a lot.

> I don't really think it solves your problem right now, because it's only a
> high-level framework and it's missing some mechanics for this purpose.

OK, so we'll push for a sysfs node that can be used by userspace to
determine the wakeup source.

The article is very interesting, there's certainly a great crossover
with OLPC's "idle-suspend" which is essentially the same thing.
However we have various problems with the current implementation,
meaning that most deployments turn it off. Looks like you are taking
steps to address some of those, I'll try and put some time in this
direction in future.

Daniel
