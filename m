From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation	patchset against -rc6)
Date: Wed, 19 Mar 2008 00:43:43 +0100
Message-ID: <20080318234343.GA1733@elf.ucw.cz>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue 2008-03-18 10:31:28, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Mar 2008, Pavel Machek wrote:
> >
> > On Tue 2008-03-18 14:06:42, Pavel Machek wrote:
> > > 
> > > Confirmed, suspend slowness is in 2.6.25-rc6, too. It takes 15 seconds
> > > to suspend/resume, while 2.6.24 takes 9. Thinkpad x60.
> > 
> > IIRC 2.6.25-rc5 was "fast".
> 
> Can you bisect it? There's only 343 commits between -rc5 and -rc6, so it 
> should not take too long to check which commit it is. Even if it should 
> take 9 reboots to bisect it entirely, going just five or six will likely 
> narrow it down sufficiently that we can probably guess fairly well what 
> it's about.

Minimal fix for slowness problem is:

Fix suspend slowness problem, introduced by:

| commit 2c81ce4c9c37b910210f2640c28e98a0c398dc26
| tree e46ccf30836014d115e72791263697585f7943f6
| parent 2f44bbb495dd3e6d0209eff2257438ab9c570e5b
| author Alexey Starikovskiy <astarikovskiy@suse.de> Tue, 11 Mar 2008
| 13:30:00 -0400
| committer Len Brown <len.brown@intel.com> Tue, 11 Mar 2008 13:30:00
| -0400
|
|    ACPI: EC: Handle IRQ storm on Acer laptops

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 2fc3b3069659f4d914cd6863f606c5d01d7d1644
tree 39e9fded0e00ba04947c24073873b5c7ff55af52
parent e094d39e372df9d3e360f2c2672f2860c0995f6a
author Pavel <pavel@amd.ucw.cz> Wed, 19 Mar 2008 00:43:14 +0100
committer Pavel <pavel@amd.ucw.cz> Wed, 19 Mar 2008 00:43:14 +0100

 drivers/acpi/ec.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e7e197e..360adc0 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -230,7 +230,6 @@ static int acpi_ec_wait(struct acpi_ec *
 		while (time_before(jiffies, delay)) {
 			if (acpi_ec_check_status(ec, event))
 				goto end;
-			msleep(5);
 		}
 	}
 	pr_err(PREFIX "acpi_ec_wait timeout,"


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
