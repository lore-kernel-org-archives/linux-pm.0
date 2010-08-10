From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Tue, 10 Aug 2010 11:18:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008101115130.23481__5983.14255844361$1281464518$gmane$org@asgard.lang.hm>
References: <20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
	<20100810044541.GA2817@linux.vnet.ibm.com>
	<20100810093849.138e2318@lxorguk.ukuu.org.uk>
	<20100810141107.GA12873@srcf.ucam.org>
	<alpine.DEB.2.00.1008101057090.23481@asgard.lang.hm>
	<20100810181320.GA17472@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100810181320.GA17472@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: menage@google.com, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 10 Aug 2010, Matthew Garrett wrote:

> On Tue, Aug 10, 2010 at 11:07:20AM -0700, david@lang.hm wrote:
>
>> If the primary difference between sleep and suspend is not scheduling
>> processes, instead of messing with oppurtinistic suspend/suspend
>> blockers/wakelocks/etc, why not just 'temporarily' change the timer fuzz
>> value to a very large value (say an hour). That would still let things
>> like openoffice saves ahve a fair chance to trigger before the battery
>> died completely, but would wake the system so infrequently that it will
>> be effectivly the same as a full suspend.
>
> Because it only affects processes that sleep. It's a question of how
> much pathology you want to be able to tolerate.

Standard system stats will show you hogs like this. The Android people 
claim that wakelock stats will let the user identify processes that 
prevent the system from suspending properly and then remove them. If this 
is the case, a process that never sleeps will be even easier to identify 
and even more obvious an offender.

If that isn't enough, then you can go back to the other idea I advanced, 
having some way to tell the system not to consider some processes when 
trying to decide if the system should sleep or not.

David Lang
