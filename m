From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Trying to understand new wakeup events architecture
Date: Wed, 12 Jan 2011 21:02:44 +0100
Message-ID: <201101122102.44482.rjw@sisk.pl>
References: <AANLkTik0y2O4GTvoFkm-94iSWdWUG8juZ0cBNWXDas8Q@mail.gmail.com>
	<AANLkTinw9MXSXV3FNp-b1S0bpBVBoLJi7CUhC0=2Pgg0@mail.gmail.com>
	<AANLkTi=PL_tzxEnfKGjP4Qjv_jNyR-c95W8-caXfG2vo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=PL_tzxEnfKGjP4Qjv_jNyR-c95W8-caXfG2vo@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 12, 2011, Daniel Drake wrote:
> Hi Rafael,
> 
> On 16 December 2010 14:39, Daniel Drake <dsd@laptop.org> wrote:
> > On 15 December 2010 22:33, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> I guess it's sufficient to read the article at http://lwn.net/Articles/416690/
> >> (or the PDF linked from there is that's not enough :-)).
> >
> > Thanks, that helps a lot.
> >
> >> I don't really think it solves your problem right now, because it's only a
> >> high-level framework and it's missing some mechanics for this purpose.
> >
> > OK, so we'll push for a sysfs node that can be used by userspace to
> > determine the wakeup source.
> 
> How do you feel about us using power_kobj to create
> /sys/power/wakeup_source from inside our OLPC code?
> This would include a textual representation of the last wakeup source.
> 
> Alternatively we could put it as a sysfs attribute of our own platform device.

I'm basically fine with /sys/power/source as long as its contents are generally
suitable.  What exactly do you want to show up in that file?

Rafael
