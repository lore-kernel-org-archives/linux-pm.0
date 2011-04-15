From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [uclinux-dist-devel] freezer: should barriers be smp
	?
Date: Sat, 16 Apr 2011 01:30:55 +0200
Message-ID: <201104160130.55836.rjw__49872.3117322244$1302910281$gmane$org@sisk.pl>
References: <BANLkTinj3y+-VhzFAPz8Gzb5vAbtUFU6Aw@mail.gmail.com>
	<201104160111.49409.rjw@sisk.pl>
	<BANLkTik9aGTqb0JNr3RsnDjPiSpbSdEUpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTik9aGTqb0JNr3RsnDjPiSpbSdEUpA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, April 16, 2011, Mike Frysinger wrote:
> On Fri, Apr 15, 2011 at 19:11, Rafael J. Wysocki wrote:
> > On Friday, April 15, 2011, Mike Frysinger wrote:
> >> On Fri, Apr 15, 2011 at 12:29, Pavel Machek wrote:
> >> >> > > I believe the code is correct as is.
> >> >> >
> >> >> > that isnt what the code / documentation says.  unless i'm reading them
> >> >> > wrong, both seem to indicate that the proposed patch is what we
> >> >> > actually want.
> >> >>
> >> >> The existing code is correct but it isn't optimal.
> >> >>
> >> >> wmb() and rmb() are heavy-duty operations, and you don't want to call
> >> >> them when they aren't needed.  That's exactly what smp_wmb() and
> >> >> smp_rmb() are for -- they call wmb() and rmb(), but only in SMP
> >> >> kernels.
> >> >>
> >> >> Unless you need to synchronize with another processor (not necessarily
> >> >> a CPU, it could be something embedded within a device), you should
> >> >> always use smp_wmb() and smp_rmb() rather than wmb() and rmb().
> >> >
> >> > Maybe; but this code is not performance critical and I believe being
> >> > obvious here is better...
> >>
> >> isnt it though ?  especially when we talk about suspending/resuming on
> >> embedded systems to get more savings over just cpu idle ?  we want
> >> that latency to be as low as possible.
> >
> > I agree, we can switch the freezer to smp_ barriers, but not for the reason
> > you gave before. :-)
> >
> > Care to repost the patch with a suitable changelog?
> 
> np
> 
> to be clear, what you said wrt the Blackfin smp barriers still holds
> true right ?

I think so.

> so this changset i merged doesnt need any tweaking ...
> http://git.kernel.org/?p=linux/kernel/git/vapier/blackfin.git;a=commitdiff;h=943aee0c685d0563228d5a2ad9c8394ad0300fb5

Rafael
