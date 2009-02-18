From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 12:30:46 -0500
Message-ID: <m3zlgjlkjd.fsf__14417.914968408$1235060320$gmane$org@pullcord.laptop.org>
References: <200902160010.16955.rjw@sisk.pl> <20090216225831.GH1370@ucw.cz>
	<20090216231324.GA15435@srcf.ucam.org>
	<20090217215717.GA25605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090217215717.GA25605@linux.intel.com> (mark gross's message of
	"Tue, 17 Feb 2009 13:57:17 -0800")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

   > Putting the wake on key event issue aside, is it possible to have
   > wake up's on the ms time scale?  I ask because I thought the XO did
   > exactly this (but left the screen live).

We're currently at 890ms for suspend+resume with USB on, and 180ms for
suspend+resume when booted "nousb".  Anything done upstream to make the
first number closer to the second one will be very valuable to us.

   > Why does it take 20 sec to get into or out of S3 on my laptop?

We found that the SMM version of S3 in our original development BIOS
also took that long.  We switched to using Open Firmware, turned off
ACPI, worked out exactly which registers to use to enter S3, and
scheduled device reinitialization such that hardware-required delays
(such as clock stabilization for our GPU) start in the right order to
keep the critical path short.

The main difference was the switch away from the vendor BIOS, though --
we were seeing something like a five-second delay between Linux entering
S3 and the hardware noticing and putting the system into suspend, for
example.  There's not much market pressure to write efficient EC code
for suspend/resume.  (Or, we discovered, to write EC code that's able
to handle suspend/resume more than a hundred times per boot without
crashing.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
