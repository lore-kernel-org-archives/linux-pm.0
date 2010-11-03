From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] One more power management fix for 2.6.37
Date: Wed, 3 Nov 2010 13:40:14 -0400
Message-ID: <AANLkTikHRGkTGjBHQPt7-__XEWLYKLcSZgeXgicwOv8H__36529.4920084581$1288806225$gmane$org@mail.gmail.com>
References: <201010292358.27975.rjw@sisk.pl>
	<AANLkTikF+8VsxyjmXUc_6Epd923g5DCxneNArFNTGrZ_@mail.gmail.com>
	<201011030356.13878.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011030356.13878.rjw@sisk.pl>
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

On Tue, Nov 2, 2010 at 10:56 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Can you boot with initcall_debug and try to suspend, please? =A0That shou=
ld tell
> us what device this actually happens to.

It's so far only happened that once. I'm running now with
DEBUG_PAGEALLOC, DEBUG_SLUB_ON, and with initcall_debug in case it
triggers again..

> I don't even think it's necessary to suspend, it should be sufficient to =
do
>
> # echo devices > /sys/power/pm_test
> # echo mem > /sys/power/state
>
> Let's see if that reproduces the problem.

I'll try that a few times too.

           Linus
