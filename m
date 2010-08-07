From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 6 Aug 2010 20:14:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100804195704.GA23681@linux.vnet.ibm.com>
	<20100806225453.GA3947@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061651530.30564@asgard.lang.hm>
	<AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: tytso@mit.edu, peterz@infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 6 Aug 2010, Brian Swetland wrote:

> On Fri, Aug 6, 2010 at 4:59 PM,  <david@lang.hm> wrote:
>>
>> now, android is betting that the apps are all developed specifically for the
>> android from scratch, so having a different API is acceptable, even if it
>> cuts them off from the rest of the *nix applications. For a phone this is
>> not neccessarily an unreasonable stance, but as Android moves into the
>> spaces where normal applications are in use (netbooks and tablets), this
>> becomes a much shakier stance to take.
>
> "Normal" apps work reasonably well -- they get halted when the screen
> turns off, just like they do when my laptop suspends.
>
> Wakelocks are useful for mobile-centric apps that you want to keep
> running in the background, wake up and do work when the device is
> "asleep", etc.

that description sounds far more like normal sleep power management that 
suspending. especially since they want to set timers to wake the system up 
and the defining characteristic of suspend (according to this thread) is 
that timers don't fire while suspended.

as I am seeing it, there are two reasons why this don't "just work"

1. sleeping can't currently save as much power as suspending

2. the current logic for deciding to sleep can't ignore the other apps on 
the system.

David Lang
