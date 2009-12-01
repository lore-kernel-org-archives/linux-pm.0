From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Bisected: s2disk (uswsusp only) hangs just before
	poweroff
Date: Tue, 01 Dec 2009 19:59:40 +0000
Message-ID: <4B1575AC.6080904__17890.6662310057$1259697674$gmane$org@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Mel Gorman <mel@csn.ul.ie>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi

Suspend to disk is (sometimes) hanging for me in 2.6.32-rc.  I finally 
got around to bisecting it, which blamed the following commit by Mel:

5f8dcc2 "page-allocator: split per-cpu list into one-list-per-migrate-type"

I was able to confirm this by reverting the commit, which fixed the 
hang.  I had to revert one other commit first to avoid a conflict:

a6f9edd "page-allocator: maintain rolling count of pages to free from 
the PCP"

-- detail --

When I suspend my EeePc 701 to disk, it sometimes hangs after writing 
out the hibernation image.  The system is still able to resume from this 
image (after working around the hang by pressing the power button). 

This is specific to s2disk from the uswsusp package (which is now 
installed by default on debian unstable).  It doesn't happen if I 
uninstall uswsusp and use the in-kernel suspend instead.

The hang doesn't happen if I boot with "init=/bin/bash" and run s2disk.  
Nor does it happen if I boot normally, then switch to single user mode 
("telinit 12").

It only happens if I've logged in to KDE.  In the past, this has 
indicated a problem in a network driver, since NetworkManager only made 
a connection once I logged in.  But it still hangs if I remove both 
ath5k and atl2 before I log into KDE.  (I actually tried removing as 
many modules as possible: atl2, ath5k, usbcore, snd-hda-intel, psmouse, 
pcspkr, battery, ac, themal, fan, and eeepc-laptop).  Perhaps it's 
something to do with the size of the hibernation image.

-- confidence in the bisection result --

The randomness was a bit annoying, but it's not too bad.  The hang would 
normally show up in the first 3 hibernation cycles; I don't remember 
having to wait more than 6.

I wrote a script to do s2disk + rtcwake so I could leave it testing 
without constantly hitting the power button.  This let me test 
2.6.32-rc8 with the reverts for at least 20 hibernation cycles.

Regards
Alan
