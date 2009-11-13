From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: intermittent suspend problem again
Date: Fri, 13 Nov 2009 17:35:55 +0100
Message-ID: <87my2qwff8.fsf__12670.7477997572$1258130323$gmane$org@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200911111238.22696.rjw@sisk.pl>
	<87pr7pi40p.fsf@tac.ki.iif.hu> <200911111547.21149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911111547.21149.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 11 Nov 2009 15:47:21 +0100")
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

> Yes, echo "core" to /sys/power/pm_test before executing s2disk.

It snapshots the system and returns, producing the same console output
as s2ram (is this the expected behaviour?)  I ran this several times in
a loop, and experienced no problems at all.  Maybe it depends on the
amount of memory used...  I saw a freeze saying "99% done" (ie. not
100%), btw.  Are other pm_test values meaningful with s2disk?  Is this
handled explicitly in s2disk, or does simply the kernel act as if it was
resumed instead of providing the system image after SNAPSHOT_CREATE_IMAGE?

> On Wednesday 11 November 2009, Ferenc Wagner wrote:
>
>> I already did the test for STR (see
>> http://bugs.freedesktop.org/show_bug.cgi?id=22126#c3), but will redo
>> with the current kernel tonight.
>
> OK, thanks.

No change on this front, FWIW.  But rc7 is out now, I'll test again.
-- 
Thanks,
Feri.
