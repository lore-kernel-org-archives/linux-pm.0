From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wakeup events?
Date: Sat, 8 Nov 2008 12:20:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811081201200.27891-100000@netrider.rowland.org>
References: <345163910811080650k2e7e706bi22aa13d0dc46d0d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <345163910811080650k2e7e706bi22aa13d0dc46d0d5@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Reid <ppeter.reid@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 8 Nov 2008, Peter Reid wrote:

> Hi,
>     Here are a couple of questions regarding idle loop and wakeup events.
>     Appreciate your time.
> 
>    What is an idle loop?

It is a loop that runs when the system is idle, that is, not doing 
anything useful.

> and  Is it some kind of a while loop?.

It is a kind of loop.  That's why it's called an "idle loop".  :-)
Whether it is written with a C "while" statement is a different matter; 
some idle loops use "while" and others don't.

>    how can i find out where this   loop exists in my code?

You can find out where it exists in the Linux kernel by looking for it
or by asking on a mailing list.  For example, on x86 systems the main 
idle loop can be found in arch/x86/kernel/process.c:cpu_idle().

But if you want to know where there's an idle loop in your own code -- 
that's a strange question to ask.  After all, it is your _own_ code.  
If you don't know where it contains an idle loop, how do you expect 
anybody else to know?

>    what is done in this loop? usually for power management?

Nothing important is done in it.  That's why it's called "idle".  There 
are a few minor housekeeping activities.

>   What are wakeup events that make kernel to come out of an idle loop
>   and how do they occur.

Any event at all will cause the kernel to leave its idle loop.  They
occur as interrupts.

> Are these application specific?

Some yes, but mostly no.

>   Or these wake ups are triggered by Interrupts only?

What else could trigger them?

>   How does one test if kernel is in idle loop or not and and whats it is
> doing in there?

You can't test if the kernel is in an idle loop, because in order to 
run your test it will have to leave the idle loop.  It's like asking 
"How can I tell if the refrigerator light is on when the door is 
closed?".

However you can look at the system activities statistics.  For example,
the "top" program will display the percentage of time the system spends
in various states.  If most of the time is spent in the Idle state, you
can be pretty sure the kernel was running its idle loop.

>   Wondering how-to test idle loop power management?

The same way you test any other power management.

>   how does one test PM in general? Like to know know to test the Sleep
> States.
>   what sleep state a processor has gone into and how much power saving takes
>   place for each state.

Read the files in Documentation/power for more information.

Alan Stern
