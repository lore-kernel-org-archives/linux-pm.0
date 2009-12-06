From: Victor Lowther <victor.lowther@gmail.com>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 06 Dec 2009 13:04:36 -0600
Message-ID: <1260126276.13057.13.camel__9578.01699773899$1260126446$gmane$org@studio>
References: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2009-12-06 at 10:23 -0500, Alan Stern wrote:
> On Sat, 5 Dec 2009, Linus Torvalds wrote:
> That's ridiculous.  Having gone to all the trouble of building a device
> tree, one which is presumably still almost entirely correct, why go to
> all the trouble of tearing it down only to rebuild it again?  (Note:
> I'm talking about resume-from-RAM here, not resume-from-hibernation.)

There should be nothing special or privileged at all about the device
tree that gets built at boot time.

Consider the scenario of the laptop user with a docking station.
Adding, removing, and rewriting vast swaths of the device tree across
suspend/resume and hibernate/thaw is very easy to do when you are
plugging a laptop into one or more docking stations.

> Instead what we do is verify that the devices we remember from before
> the suspend are still there, and then asynchronously handle new devices
> which have been plugged in during the meantime.  Doing this involves
> relatively little extra or new code; most of the routines are shared
> with the runtime PM and device reset paths.

Devices can vanish across suspend to RAM just as easily as they can be
added.

> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
