From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Sat, 11 Apr 2009 13:11:56 -0700
Message-ID: <49E0F98C.1090202__8817.44993753291$1239480928$gmane$org@linux.intel.com>
References: <200904100057.43827.rjw@sisk.pl>
	<alpine.LFD.2.00.0904091605080.4583@localhost.localdomain>
	<200904101439.43480.rjw@sisk.pl>
	<alpine.LFD.2.00.0904102233330.8559@localhost.localdomain>
	<alpine.LFD.2.00.0904111109500.4583@localhost.localdomain>
	<49E0EC87.9080808@linux.intel.com>
	<alpine.LFD.2.00.0904111247320.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904111247320.4583@localhost.localdomain>
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
Cc: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Vegard Nossum <vegard.nossum@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Heinz Diehl <htd@fancy-poultry.org>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 11 Apr 2009, Arjan van de Ven wrote:
>> Now that I've been able to scan most of my mail; it looks like the one-liner
>> should just go in.
> 
> Ok, I committed my one-liner, and then also reverted the ACPI battery 
> workaround of removing __init, since the one-liner should fix that too.
> 
> Cc'ing the people involved with that commit, just so that they know to 
> test to make sure the alternate fix really did fix it for them (I'm pretty 
> sure it does, but still a good idea to verify or at least let people know 
> that a previous fix got reverted)

longer term I would like to work on two things
1) Fix the __init thing by just only freeing when appropriate, but not having to wait for it
2) Find a way for userland to trigger a sync
    - for all storage probing
    - for just async work
    - "global sync", which includes all driver init
    We can then have insmod/modprobe use this always, unless a flag is set
    (so say, udev, can load a slew of modules, and then sync only on the last one)

and then after a year or two we can maybe remove the sync from the module loader ;(
