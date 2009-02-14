From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 16:50:11 -0800
Message-ID: <d6200be20902131650n33f46958j4d8630694c49a400@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
	<d6200be20902131536x5c0ec741hdbfb63c0b2ae79c0@mail.gmail.com>
	<20090214000520.GA5764@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090214000520.GA5764@srcf.ucam.org>
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

On Fri, Feb 13, 2009 at 4:05 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrot=
e:
> On Fri, Feb 13, 2009 at 03:36:06PM -0800, Arve Hj=F8nnev=E5g wrote:
>
>> My objections to a global reference count are the same as before.
>> There is no accountability and no timeout support. I also prefer the
>> api to each driver to be a switch and not a reference count. I
>> understand the objections to using timeouts, but in practice we need
>> them today. If we move the timeout support to each driver that needs
>> it, it does not only make the drivers more complex, but we also loose
>> the ability to skip the timers that will not trigger suspend.
>
> The only reason you've given for needing a timeout is that there are
> sections of the kernel that don't support wakelocks.

Or when not trusting userspace. In the last user space api, I also use
a timeout when a process dies with a wakelock locked.

> The only reason
> there are sections of the kernel that don't support wakelocks is that
> people don't like the API.

That is a pretty big leap. There is no wakelock api in the current
kernel. I think the absence of an api is a more plausible explanation
for it not being used than that people do not like the api.

> This argument is pretty circular.
> I think
> people would be much happier to have a deterministic kernel than a
> probabalistic one.

The current kernel only supports probabilistic mode. Wakelocks are a
step towards your deterministic kernel, not away form it. It is
possible to add a wakelock api that supports timeouts today, and
remove timeout support later if it is no longer needed.

>
>> I even use a wakelock with a timeout internally to deal with the case
>> where a legacy driver return -EBUSY from its suspend hook. If I don't
>> use a timeout here, we either have to retry suspend immediately which
>> may never succeed if the thread that needs to run to clear the
>> condition is frozen again before it gets a chance to run, or we stop
>> trying to suspend indefinitely.
>
> Well, yeah, that's another pretty solid argument in favor of killing the
> freezer...

Not freezing threads does not solve the problem. The thread could be
waiting for a driver that is suspended before the driver that is
preventing suspend.

>
>> I don't think adding the debug state to the device struct is much of
>> an improvement over using a wake_lock struct. You either have to
>> iterate over every device when extracting the debug information, or
>> you have to maintain similar lists to what the wakelock code uses now.
>> For the drivers point of view, it saves an init and destroy call but
>> it prevent using more than one lock per device or using it without a
>> device.
>
> Mm? I was thinking that in the debug case you'd replace the counter with
> a list containing the device structs, then simply dump the device name
> to your debug output.

We always use the debug case. I don't think a list of device struct is
better than a list of wakelocks.

>
>> > purposes. Userland ABI would then be a single /dev/inhibit_suspend,
>> > with the counter being bumped each time an application opens it. It'll
>> > automatically be dropped if the application exits without cleaning up.
>>
>> Whether the kernel api uses a single ref count or a list of wakelocks
>> does not dictate the user space api. The last patch sent I sent out
>> uses ioctls to lock and unlock a single wakelock per file descriptor.
>> Do anyone have a problem with that api?
>
> Requiring an ioctl makes it trickier to use from scripting languages,
> but beyond that I'm not too concerned.
>
>> > This seems simpler and also avoids any arguments about the naming
>> > scheme. What am I missing?
>>
>> How does changing the name to inhibit_suspend() and
>> uninhibit_suspend() prevent arguments about the naming scheme? Calling
>> uninhibit_suspend once does not ensure that suspend is uninhibited.
>
> If you're passing a device struct then I think it implies that that
> device is no linger inhibiting suspend.

How is passing the device struct to the api better than passing a
wake_lock struct?

-- =

Arve Hj=F8nnev=E5g
