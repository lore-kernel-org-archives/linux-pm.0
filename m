From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: intermittent suspend problem again
Date: Sat, 14 Nov 2009 02:50:36 +0100
Message-ID: <874ooxho2b.fsf__35600.6442140371$1258163523$gmane$org@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200911111547.21149.rjw@sisk.pl>
	<87my2qwff8.fsf@tac.ki.iif.hu> <200911132059.46377.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911132059.46377.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 13 Nov 2009 20:59:46 +0100")
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
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, yakui.zhao@intel.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday 13 November 2009, Ferenc Wagner wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>>> Yes, echo "core" to /sys/power/pm_test before executing s2disk.
>> 
>> It snapshots the system and returns, producing the same console output
>> as s2ram (is this the expected behaviour?)  I ran this several times in
>> a loop, and experienced no problems at all.  Maybe it depends on the
>> amount of memory used...  I saw a freeze saying "99% done" (ie. not
>> 100%), btw.
>
> The number is not always accurate because of rounding errors.  I think we can
> safely assume that it always happens after the entire image has been written.

Probably, "done" isn't output otherwise.

>> Are other pm_test values meaningful with s2disk?  Is this
>> handled explicitly in s2disk, or does simply the kernel act as if it was
>> resumed instead of providing the system image after SNAPSHOT_CREATE_IMAGE?
>
> The latter.

Ok, I found the code.  Are other pm_test values meaningful, or possibly
harmful?  I think I tried freezer, which resulted in a seemingly perfect
suspend, but the machine didn't try to resume afterwards, but booted
normally instead...

>>> On Wednesday 11 November 2009, Ferenc Wagner wrote:
>>>
>>>> I already did the test for STR (see
>>>> http://bugs.freedesktop.org/show_bug.cgi?id=22126#c3), but will redo
>>>> with the current kernel tonight.
>>>
>>> OK, thanks.
>> 
>> No change on this front, FWIW.  But rc7 is out now, I'll test again.
>
> Not sure if that's going to work, but yes please test it.

The KMS related STR freeze (evaluating the _PTS method) is still there.
I'm continuing testing s2disk with the platform method under rc7 (with
some instrumentation added).

Btw, s2ram -f works fine otherwise (no KMS), and my machine is not in
the whitelist.  I'm not sure whether the KMS problem disqualifies it
(shall I report it to suspend-devel?), but it can be identified by:
    sys_vendor   = "IBM"
    sys_product  = "1834S5G"
    sys_version  = "ThinkPad R50e"
    bios_version = "1WET90WW (2.10 )"
-- 
Thanks,
Feri.
