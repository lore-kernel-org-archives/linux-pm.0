From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 15:36:06 -0800
Message-ID: <d6200be20902131536x5c0ec741hdbfb63c0b2ae79c0@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213140654.GC26549@srcf.ucam.org>
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
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 6:06 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrot=
e:
> On Fri, Feb 13, 2009 at 11:55:06AM +0100, Uli Luckas wrote:
>> On Friday, 13. February 2009, Matthew Garrett wrote:
>> > I dislike the kernel-side use of wakelocks. They're basically equivale=
nt
>> > to a device returning -EBUSY during the suspend phase, which is
>> > something that can be done without any kernel modifications.
>> That's absouletely wrong. With wake locks, you are in a pre suspend stat=
e and
>> stay there until all wakelocks are released. Then you go to sleep.
>>
>> With -EBUSY the kernel gives up on suspend until some source triggers it
>> again. When exactly should suspend then be retried?
>
> Ok, so let's think about this differently. What we want is simply for
> drivers to be able to block an automatic suspend. For performance
> reasons we want to keep track of this state without calling into the
> entire driver tree. Now that the userspace API can automatically clean
> up after itself, why is this not just a simple counter? Kernel API would
> be something like:
>
> (input arrives)
> inhibit_suspend();
> (input queue is emptied)
> uninhibit_suspend();

My objections to a global reference count are the same as before.
There is no accountability and no timeout support. I also prefer the
api to each driver to be a switch and not a reference count. I
understand the objections to using timeouts, but in practice we need
them today. If we move the timeout support to each driver that needs
it, it does not only make the drivers more complex, but we also loose
the ability to skip the timers that will not trigger suspend.

I even use a wakelock with a timeout internally to deal with the case
where a legacy driver return -EBUSY from its suspend hook. If I don't
use a timeout here, we either have to retry suspend immediately which
may never succeed if the thread that needs to run to clear the
condition is frozen again before it gets a chance to run, or we stop
trying to suspend indefinitely.

> perhaps using the device struct or something as a token for debug

I don't think adding the debug state to the device struct is much of
an improvement over using a wake_lock struct. You either have to
iterate over every device when extracting the debug information, or
you have to maintain similar lists to what the wakelock code uses now.
For the drivers point of view, it saves an init and destroy call but
it prevent using more than one lock per device or using it without a
device.

> purposes. Userland ABI would then be a single /dev/inhibit_suspend,
> with the counter being bumped each time an application opens it. It'll
> automatically be dropped if the application exits without cleaning up.

Whether the kernel api uses a single ref count or a list of wakelocks
does not dictate the user space api. The last patch sent I sent out
uses ioctls to lock and unlock a single wakelock per file descriptor.
Do anyone have a problem with that api?

> This seems simpler and also avoids any arguments about the naming
> scheme. What am I missing?

How does changing the name to inhibit_suspend() and
uninhibit_suspend() prevent arguments about the naming scheme? Calling
uninhibit_suspend once does not ensure that suspend is uninhibited.

-- =

Arve Hj=F8nnev=E5g
