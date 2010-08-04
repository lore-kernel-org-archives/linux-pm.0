From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 11:30:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008041124580.6545__42756.6549777568$1280947155$gmane$org@asgard.lang.hm>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100804163509.GA31523@srcf.ucam.org>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Aug 2010, Matthew Garrett wrote:

> On Wed, Aug 04, 2010 at 09:32:16AM -0700, Paul E. McKenney wrote:
>
>> If this doesn't work for the Android folks for whatever reason, another
>> approach would be to do the freeze in user code, which could track
>> whether any user-level resources (pthread mutexes, SysV semas, whatever)
>> where held, and do the freeze on a thread-by-thread basis within each
>> "victim" application as the threads reach safe points.
>
> The main problem I see with the cgroups solution is that it doesn't seem
> to do anything to handle avoiding loss of wakeup events.

there are two cgroup solutions in discussion at this point.

weeks ago there was the suggestion to put non-privilaged tasks in a cgroup 
so that they could be frozen as a group. I thought the problem there was 
that there can be user-space dpendancies that would prevent privilaged 
tasks from working.

a couple days ago I made the suggestion to put non-privilaged tasks in a 
cgroup so that the idle/suspend decision code could ignore acitivity 
caused by this cgroup.

in the second version wakeup events would be 'activity' that would be 
counted and therefor the system would not be idle. As for the race with 
suspending and new things happening, wouldn't that be handled the same way 
that it is in a normal linux box?

David Lang
