From: Arun KS <getarunks@gmail.com>
Subject: Re: Delay in performing "suspend-to-ram" issued via RT
	thread (SCHED_FIFO)
Date: Thu, 27 May 2010 15:03:24 +0900
Message-ID: <AANLkTiljUw1jy4bkBIyQJsaXV7GwFuiBZbjqDoe6A2gf__49404.4453757398$1274940425$gmane$org@mail.gmail.com>
References: <1274875654.12225.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274875654.12225.20.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: uthappa <uthappa@mistralsolutions.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

CCing linux-pm list.

On Wed, May 26, 2010 at 9:07 PM, uthappa <uthappa@mistralsolutions.com> wro=
te:
>
> Hello Everyone,
>
> =A0 =A0 =A0 =A0I am currently working with the linux 2.6.29-omap1 kernel.=
 Right now I
> am porting a legacy application code that puts the OMAP 5912 host to
> sleep. The host wakes up after 4 secs via an RTC interrupt which is
> configured to be the wake-up source. Everything seems to be fine running
> in a loop. The system wakes up and goes back to sleep in 4 seconds every
> time. But I am observing a behavior that I am unable to explain. The
> legacy application thread that puts the system to sleep is originally an
> RT thread with the scheduling policy (SCHED_FIFO) and priority 5. The
> thread runs in a loop. The following bash script mimics the behavior of
> this thread exactly (however you will probably need some wake up source
> like an RTC interrupt to try it on your side):
>
> ## Script start #############################
>
> #!/bin/bash
>
> NAME_OF_THE_SCRIPT=3D`basename $0`
>
> SELF_PID=3D`pidof $NAME_OF_THE_SCRIPT`
> /usr/bin/chrt -f -p 5 $SELF_PID
>
> sleep 1
>
> while (true)
> do
> =A0 =A0 =A0 =A0echo mem > /sys/power/state
> =A0 =A0 =A0 =A0usleep 30000
> done
>
> ## Script end ###############################
>
> =A0 =A0 =A0 =A0With this thread running, I see the following messages loo=
ping
> repeatedly on the target console screen:
>
> ## Console o/p start #############################
>
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.92 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.99 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: OMAP16212316 is trying to enter deep sleep...
> PM: OMAP16212316 is re-starting from deep sleep...
> Restarting tasks ... RTC IRQ cleared
> done.
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.90 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.99 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: OMAP16212316 is trying to enter deep sleep...
> PM: OMAP16212316 is re-starting from deep sleep...
> Restarting tasks ... RTC IRQ cleared
> done.
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.92 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.99 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: OMAP16212316 is trying to enter deep sleep...
> PM: OMAP16212316 is re-starting from deep sleep...
> Restarting tasks ... RTC IRQ cleared
> done.
>
> ## Console o/p end ###############################
>
> =A0 =A0 =A0 =A0You can observe from the above messages that the elapsed t=
ime in
> "Freezing" the user processes is in the order of around 0.9 seconds.
> Also, (although not evident here) when the message "Restarting
> tasks ..." appears it takes around a second for the "done." message to
> follow.
>
> =A0 =A0 =A0 =A0Now comes the fun part. When I do not fiddle around with t=
he scheduling
> policy and priority of the legacy RT thread and just let it be a normal
> user space thread (SCHED_OTHER with priority 20, nice 0) (You can
> achieve this in the script that I shared with you all by simply
> commenting out the command that says "/usr/bin/chrt -f -p 5 $SELF_PID").
> Then there is almost no delay at all during "Freezing" and
> "Restarting" (I should probably call this "Thawing") the user space
> tasks. That is, I now have the following console o/p:
>
> ## Console o/p start #############################
>
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: OMAP16212316 is trying to enter deep sleep...
> PM: OMAP16212316 is re-starting from deep sleep...
> Restarting tasks ... RTC IRQ cleared
> done.
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: OMAP16212316 is trying to enter deep sleep...
> PM: OMAP16212316 is re-starting from deep sleep...
> Restarting tasks ... RTC IRQ cleared
> done.
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: OMAP16212316 is trying to enter deep sleep...
> PM: OMAP16212316 is re-starting from deep sleep...
> Restarting tasks ... RTC IRQ cleared
> done.
>
> ## Console o/p end ###############################
>
> =A0 =A0 =A0 =A0As you can see from the above log that the time elapsed du=
ring freeze
> is now reported as 0.00 seconds. And I observed here that there is no
> time delay between printing "Restarting tasks ..." and "done.".
>
> =A0 =A0 =A0 =A0I am having a tough time searching for an explanation to t=
his behavior.
> And I hoping that some of you might have already experienced this
> behavior or knows what is happening and can explain this to me.
>
> =A0 =A0 =A0 =A0Many thanks in advance.
>
> Best regards,
> Uthappa
>
>
>
> Please do not print this email unless it is absolutely necessary. Spread =
environmental awareness.
>
> -------------------------------------------------------DISCLAIMER--------=
----------------------------------------------
> The information transmitted herewith is confidential and proprietary info=
rmation intended only for use by the individual or entity to which it is ad=
dressed. If the reader of this message is not the intended recipient, you a=
re hereby notified that any review, retransmission, dissemination, distribu=
tion, copying or other use of, or taking of any action in reliance upon thi=
s information is strictly prohibited. If you have received this communicati=
on in error, please contact the sender and delete the material from your co=
mputer.
> -------------------------------------------------------------------------=
--------------------------------------------------
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
