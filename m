From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 01:09:56 +0800
Message-ID: <AANLkTi=cEyfE=tmyfCjixn+hxA2fQnj=O=hrij_D1NuZ__7554.52268426797$1295629850$gmane$org@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<AANLkTi=LyufFJ-zqMWdGnSnZ-iW+ONbQ8mLfTn1O5WVi@mail.gmail.com>
	<1295587618.11852.57.camel@minggr.sh.intel.com>
	<AANLkTi=1n2YMa=_gcfuTQtT=k388MppCWCsxRkhjj-qz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=1n2YMa=_gcfuTQtT=k388MppCWCsxRkhjj-qz@mail.gmail.com>
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
Cc: Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 22, 2011 at 12:28 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jan 20, 2011 at 9:26 PM, Lin Ming <ming.m.lin@intel.com> wrote:
>> On Fri, 2011-01-21 at 12:50, Linus Torvalds wrote:
>> Does revert bba63a29(ACPICA: Implicit notify support) help?
>
> It seemed to, but on the third boot (with several suspend cycles per
> boot) I ended up seeing it. This is why I can't bisect it - it really
> isn't reliable enough to bisect sanely.
>
> One thing I've noticed: if the system suspends once, it seems to
> suspend several times. At least I think that every time I've seen this
> problem, it's happened on the first suspend (and if it comes back
> after a keypress, the second suspend will hang hard). But I've been
> booting this machine so much during all the testing, that I haven't
> ever done a really _long_ run of many suspend/resume cyles, so my
> evidence for that is weakish.

This might not be related, but may be it'll lead to something ... With
Rafael's latest patches that you pulled, suspend-to-ram/resume works
for me now. But I was still having problem with "hibernating" to disk.
It turned out that the recent changes (past few weeks) caused the ACPI
to failed when I tried to make the LED blink with  "echo 2 blink
>/proc/acpi/ibm/led". Used to work before. But, now it simply hang and
can't suspend. Removiing the echo blink make suspend-to-disk works
again.

And I've also seen the case you mentioned where sometimes it couldn't
suspend (either by closing the lid or running "echo mem
>/sys/power/state") ... it seems to happen more often when the machine
is under load ... happens a few time when I hurried to get off work
and only realized when my backpack on my back was burning hot!!!

Now I completed disabled CONFIG_THINKPAD_ACPI and
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS and hopefully won't see anymore hangs
before suspend.

Jeff.
