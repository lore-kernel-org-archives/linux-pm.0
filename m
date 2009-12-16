From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Wed, 16 Dec 2009 23:33:57 +0100
Message-ID: <200912162333.57245.rjw__10815.2189794511$1261002947$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912162257.00771.rjw@sisk.pl>
	<alpine.LFD.2.00.0912161410120.3556@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912161410120.3556@localhost.localdomain>
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

On Wednesday 16 December 2009, Linus Torvalds wrote:
> 
> Btw, what are the timings if you just force everything async? I think that 
> worked on yur laptops, no?

No, it didn't.  I could make all PCI async, provided that the ACPI subtree was
resumed before any PCI devices.  [Theoretically I can make that happen by
moving ACPI resume to the _noirq phase (just for testing of course).  So I can
try to make PCI async in addition to serio and USB, plus i8042 perhaps, which
should be sfficient for the nx6325 I think.]

Making all async always hanged the boxes on resume.

Rafael
