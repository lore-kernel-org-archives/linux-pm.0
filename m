From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 11 Feb 2009 15:42:17 -0800
Message-ID: <d6200be20902111542r3592f64dt41a282221aed1268@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902090115.10896.rjw@sisk.pl>
	<d6200be20902081803m4976c14eic88aba06548f7838@mail.gmail.com>
	<200902112323.53421.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902112323.53421.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 11, 2009 at 2:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> >> It allows wakelocks with timeouts
>> >> >
>> >> > OK
>> >> >
>> >> > What for?
>> >>
>> >> So we do not have to change everything at once, and so we can allow
>> >> code that we do not really trust a chance to run.
>> >
>> > Well, are you sure this is the best way of achieving this goal?
>>
>> No, but I have not seen any better suggestions, that solve the problem.
>
> Wakelocks with timeout are not a solution IMO.

It is an improvement over the current situation where you have to use
timeouts for everything.

>> >> > However, it might be better to use a refcount along with some mecha=
nism
>> >> > allowing user space processes to increase it only once before decre=
asing.
>> >> > That would require a per-task flag, but I think you can reuse one o=
f the
>> >> > freezer flags for that (the freezer is not going to run as long as =
a wakelock
>> >> > is held, right?).
>> >>
>> >> How would this be better?
>> >
>> > Simpler code, less overhead.  But I'm not insisting, just showing you =
another
>> > possible approach.
>>
>> I agree that a global reference count is less overhead, but we need
>> timeout support the make the system work for now.
>
> I don't really think we need it in the mainline kernel.

We do if we want anyone to be able to ship an android device capable
of suspending with the mainline kernel.

>
>> I don't see what a per-task flag would be helpful with. Not all wakelock=
s are
>> associated with tasks.
>
> What are they associated with, then?

Data (usually queues). If by per task you mean per process and not per
thread, you could use use your flag to clean up when a process dies
though.

>> We report the name and how long each wakelock is active in
>> /proc/wakelocks. Without a name, those stats are not very useful. You
>> can also enable debug options to print a message the kernel log every
>> time a wakelock is locked, unlocked or used to trigger a wakeup.
>
> Well, you put quite a lot of effort into making this nicely debuggable an=
d so
> on, but I think you should have submitted the minimal core functionality =
first
> to see if people were comfortable with it.

The code I submitted is usable and tested. Without wakelocks we cannot
use suspend, and without wakelock timeouts we cannot pass events to
components that do not use wakelocks.

-- =

Arve Hj=F8nnev=E5g
