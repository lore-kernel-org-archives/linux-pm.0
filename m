From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 20:18:01 -0800
Message-ID: <d6200be20902022018k7fda9120yb7321f5341050ce8@mail.gmail.com>
References: <d6200be20902021510k104f2da9ha89fa00baff3910a@mail.gmail.com>
	<Pine.LNX.4.44L0.0902022207440.27307-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902022207440.27307-100000@netrider.rowland.org>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 2, 2009 at 7:27 PM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> If you'd like a way for the kernel to communicate to userspace that the
> last wakelock has been unlocked, you could use a signal or a select.
> But the simplest way would be to make a process block on reading a
> sysfs file until the last wakelock is released.

I do not want the kernel to communicate to userspace that the last
wakelock has been unlocked, I want it to suspend right away. I was
answering your question about why the kernel needs to be involved. Yes
I could add a notification that tells user-space to suspend again, but
it would not offer any additional functionality over my current
solution.

>> Also, what do you mean by a runtime PM interface?
>
> I'm making a distinction between system PM and runtime (also known as
> dynamic) PM.  With system PM the entire system goes into a low-power
> state -- that's what we mean when we talk about suspend or hibernation.
> With runtime PM the system as a whole remains running while selected
> devices are individually put into a low-power state.
>
> For example, right now Linux will put a USB host controller into a
> low-power state if no USB devices are plugged into it.  This runtime PM
> interface is described in Documentation/usb/power-management.txt.  You
> might want to use some of those mechanisms for controlling your
> devices.

OK, but I don't think this affects our use of wakelocks.

> For example, if one process tries to start an auto-suspend, and at the
> same time another process writes "mem" to /sys/power/state?  Then the
> second process should take precedence and the system should go into
> suspend.  When it wakes up again, the first process would still be
> waiting for an auto-suspend to occur.  I suppose the details don't
> matter much because it's not likely to crop up often.

I'll make a change to make any write to /sys/power/state disable
wakelocks. I'll probably also add a config option to remove
/sys/power/state.

Before I post another patch series I have a few questions:
- Should I merge the wakelock and early-suspend api patches with their
implementations? (I initially implemented the api on top of the old
android_power driver, but we not longer use this)
- Once wakelocks are disabled by writing to /sys/power/state, is there
any demand for re-enabling wakelock support?
- Are there any objections to using /sys/power/request_state to
specify the state to enter when all wakelocks unlocked.

-- =

Arve Hj=F8nnev=E5g
