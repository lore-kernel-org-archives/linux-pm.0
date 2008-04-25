From: Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [RFC][PATCH 2/5] Container Freezer: Make
 refrigerator always available
Date: Fri, 25 Apr 2008 14:07:20 +0200
Message-ID: <4811C978.6010508__4990.15287864513$1209125356$gmane$org@fr.ibm.com>
References: <20080424064756.643890130@us.ibm.com>
	<20080424064757.227289200@us.ibm.com>
	<20080425110456.GF14903@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080425110456.GF14903@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Oren Laadan <orenl@cs.columbia.edu>, Linux Containers <containers@lists.linux-foundation.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Paul Menage <menage@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> Now that the TIF_FREEZE flag is available in all architectures,
>> extract the refrigerator() and freeze_task() from kernel/power/process.c
>> and make it available to all.
>>
>> The refrigerator() can now be used in a control group subsystem 
>> implementing a control group freezer.
>>
>> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
>> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
>> Tested-by: Matt Helsley <matthltc@us.ibm.com>
> 
> There's no problem with doing this... but you should get some debate
> (with Linus?) whether using freezer for cgroups is sane. 

Yes that's what we are trying to know, is the fake signal mechanism 
used by the freezer something we can build upon ? 

> When that is done, there's no problem with this going in, probably 
> through rafael's patch queue.

OK

> (The first patch -- add freezer for all archs -- is probably
> reasonably to go in ASAP, through akpm or something...)

Thanks,

C.
