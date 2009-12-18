From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Fri, 18 Dec 2009 02:51:22 +0100
Message-ID: <200912180251.22655.rjw__34121.6679350056$1261101138$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912162257.00771.rjw@sisk.pl> <200912170249.00676.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912170249.00676.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 17 December 2009, Rafael J. Wysocki wrote:
...
> Tomorrow I'll try to mark as many devices as reasonably possible as async
> and see how the total suspend-resume times change.

I didn't manage to do that, but I was able to mark sd and i8042 as async and
see the impact of this.

The raw data are in the usual place:

http://www.sisk.pl/kernel/data/async-suspend-resume.pdf

and the individual device timings and logs are in:

http://www.sisk.pl/kernel/data/nx6325/
http://www.sisk.pl/kernel/data/wind/

This is the summary (previous results are inculded for easier reference):

			HP nx6325	MSI Wind U100

sync suspend		1482 (+/- 40)	1180 (+/- 24)
sync resume		2955 (+/- 2)	3597 (+/- 25)

async suspend		1553 (+/- 49)	1177 (+/- 32)
async resume		2692 (+/- 326)	3556 (+/- 33)

async+one-liner suspend	1600 (+/- 39)	1212 (+/- 41)
async+one-liner resume	2692 (+/- 324)	3579 (+/- 24)

async+extra suspend	1496 (+/- 37)	1217 (+/- 38)
async+extra resume	1859 (+/- 114)	1923 (+/- 35)

with "async" i8042 and sd:

async suspend		1319 (+/- 51)	1045 (+/- 41)
async resume		2929 (+/- 3)	3546 (+/- 27)

async+extra suspend	1327 (+/- 36)	(didn't work)
async+extra resume	1742 (+/- 164)	1896 (+/- 28)

(the summary is also available at: http://www.sisk.pl/kernel/data/results.txt).

So, it actually makes the case for async suspend!  Although it's not very
strong, with these two additional devices marked as "async" we get noticeable
suspend time improvement.

Still, the "extra" patch doesn't help on suspend at all and on the Wind the
suspend part of it didn't even work (I'm yet to figure out which of the two
devices crashed the suspend).  Nevertheless the resume part of the "extra"
patch worked in both cases and worked better than without the two additional
"async" devices.

To me, this means that the suspend part of the "extra" patch is not really
useful.  However, the resume part of it is _very_ useful, so I'd like to add
that part only to the async patchset.  The explanation why it helps so much
is also straightforward to me.  Namely, if slow async devices are last to
resume, then without the "extra" patch they need to wait for all of the
preceding sync devices and the speedup from executing their resume routines
asynchronously is very limited.  Now, with the "extra" patch their resume
routines start as soon as their parents complete resuming and that may be
early enough for the speedup to be significant.

Rafael
