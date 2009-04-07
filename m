From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.29-git13: Reported regressions from 2.6.28
Date: Tue, 07 Apr 2009 18:16:55 +0200
Message-ID: <49DB7C77.1000702__26609.6888612539$1239121480$gmane$org@s5r6.in-berlin.de>
References: <n4io5wq70ZO.A.gzG.rFn2JB@chimera>
	<alpine.LFD.2.00.0904061443000.7443@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904061443000.7443@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Trenton Adams <trenton.d.adams@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 6 Apr 2009, Rafael J. Wysocki wrote:
>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13018
>> Subject		: 2.6.29 on MacBook 2,1 fails to reboot
>> Submitter	: Trenton Adams <trenton.d.adams@gmail.com>
>> Date		: 2009-03-30 2:04 (8 days old)
>> References	: http://marc.info/?l=linux-kernel&m=123837870307249&w=4
>> Handled-By	: "Morten P.D. Stevens" <mstevens@win-professional.com>
> 
> This went through bisection, but looking at the email log, I tend to 
> suspect that maybe Trenton marked some versions good even though they 
> weren't (because they got versions numbers from v2.6.27), and didn't 
> realize that that messes up bisection in a big way.
> 
> The bug _sounds_ like some deadlock due to lock problems - the shutdown 
> path often triggers locks that no other path really cares about. And we 
> had some lock problems in the sound subsystem that got fixed post-2.6.28, 
> for example. 
> 
> And it looks like the problem is somewhere in sound shutdown:
> 
> 12181 delete_module("snd_hda_codec", O_RDONLY|O_EXCL) = -1 EAGAIN (Resource temporarily unavailable) <0.000011>
> 
> So commits like 91054598f794fb5d8a0b1e747ff8e2e8fc2115b3 ("ALSA: pcm_oss, 
> fix locking typo") might explain it.

Trenton,
could it be the same as this one?
http://bugzilla.kernel.org/show_bug.cgi?id=12321
"System hangs when unloading alsa modules"
http://bugs.gentoo.org/show_bug.cgi?id=253535
"System hangs when unloading alsa modules on Kernel >2.6.28"
-- 
Stefan Richter
-=====-==--= -=-- --===
http://arcgraph.de/sr/
