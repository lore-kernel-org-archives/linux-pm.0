From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Fri, 8 May 2009 17:38:28 -0700
Message-ID: <d6200be20905081738g7fbc5199sa58b7d842fb96465@mail.gmail.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<20090507103249.GA6132@elf.ucw.cz>
	<d6200be20905071743r72d94e26na4a945be88a2e366@mail.gmail.com>
	<200905081622.44205.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905081622.44205.rjw@sisk.pl>
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

2009/5/8 Rafael J. Wysocki <rjw@sisk.pl>:
> On Friday 08 May 2009, Arve Hj=F8nnev=E5g wrote:
>> On Thu, May 7, 2009 at 3:32 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > On Wed 2009-05-06 18:42:59, Arve Hj?nnev?g wrote:
>> >> On Tue, May 5, 2009 at 1:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> >> > Hi!
>> >> >
>> >> >> Add a misc device, "suspend_blocker", that allows user-space proce=
sses
>> >> >> to block auto suspend. The device has ioctls to create a suspend_b=
locker,
>> >> >> and to block and unblock suspend. To delete the suspend_blocker, c=
lose
>> >> >> the device.
>> >> >
>> >> > Rafael proposed write() interface. I don't think you answered that.
>> >> >
>> >>
>> >> I think an ioctl interface makes more sense. With a write interface
>> >> you either have to do string parsing, or invent some other protocol
>> >> between the driver and user-space.
>> >
>> > Or perhaps just use "userspace/%d" % pid as a name?
>>
>> This would not be as useful. The point of naming the suspend blockers
>> is to that we can easily identify them in the stats and kernel logs.
>> Using the pid has two problems. First, the pid gives no hint about
>> what it is used for, you have to look up the process somewhere else.
>> Second, we use more than one suspend blocker from the same process.
>>
>> >
>> > 1) can't be faked that trivially
>>
>> I don't think this is a big problem. If you don't trust the apps that
>> you give suspend blocker access to use unique names, we can add a
>> prefix. This can be added in a later patch though.
>>
>> >
>> > 2) small / mostly fixed size
>> >
>> > 3) can use nicer write protocol?
>> >
>> I don't think a write protocol is nicer. "ioctl(suspend_block_fd,
>> SUSPEND_BLOCKER_IOCTL_BLOCK);" seems less error prone and more
>> readable to me than "write(suspend_block_fd, "1", 1);",
>> "write(suspend_block_fd, "1", 2);" or "suspend_block_val =3D 1;
>> write(suspend_block_fd, &suspend_block_val,
>> sizeof(suspend_block_val));".
>>
>> >> > kzalloc on user-supplied argument. Sounds like bad idea.
>> >> >
>> >> > Aha. And probably integer overflow in the same line. Ouch.
>> >> >
>> >>
>> >> The size is limited to _IOC_SIZEMASK with is 13 or 14 bits depending
>> >> on the architecture. Do you want a lower limit on the name length?
>> >
>> > 16K of unswappable kernel memory for name is a bit too much, yes.
>>
>> What if I just truncate it to NAME_MAX.
>
> My main concern with the ioctl() interface is that you're adding a device
> file just in order to have the ioctl()s available. =A0Usually, however, a=
 device
> file's purpose is to implement file operations (open, close, read, write),
> while ioctl()s are used for doing things that the file operations are not
> suitable for.

In this case, we are adding a device file to get close (release).

> So, if your device only implements open(), close() and ioctl(), this is an
> indication that there's something wrong with the interface, because it do=
esn't
> do what one would generally expect it to do (ie. smells like an abuse). =
=A0That's
> why I think it would be better to use read() and write() instead of ioctl=
().

It not not clear to me how putting a control interface on top of read
and write is any less abusive.

> Of course, there also is a problem that people generally don't like addin=
g new
> ioctl()s without a _really_ good reason.

ioctls are better suited for issuing commands than read/write.

-- =

Arve Hj=F8nnev=E5g
