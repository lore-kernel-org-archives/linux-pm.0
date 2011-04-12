From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [RESEND PATCH] PM: add a config that give warnning
 if driver take too long on suspend/resume.
Date: Tue, 12 Apr 2011 13:26:58 +0800
Message-ID: <BANLkTik8bWF8c+BmrzzqOZiWWwujskgs7w@mail.gmail.com>
References: <BANLkTincwnm_2DBKibNP-JC5fqKJf5MWXQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1104111439430.1975-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1104111439430.1975-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Alan,

2011/4/12 Alan Stern <stern@rowland.harvard.edu>
>
> On Tue, 12 Apr 2011, Jiejing.Zhang =A0wrote:
>
> > > Bear in mind that rotating disk drives typically take several hundred
> > > milliseconds to spin down. =A0The warning would always trigger. =A0Th=
at
> > > doesn't seem particularly useful.
> > >
> >
> > I think it's better change the default value 0 to disable it, enable it=
 only
> > some one write a threshold.
> >
> > First of all, it's a debug function (depends on PM_DEBUG), It's useful
> > in embedded area, like mobile phone or e-book, they are suspend/resume =
very
> > frequently and required resume as quick as possible. This debug function
> > can used to figure out which driver(s) is/are slow on suspend/resume.
> >
> > I fact that embedded engineer meets a lot is, after some development the
> > total time of suspend/resume is become slow, since there was a lot driv=
er
> > may affect the total time, it's function can help them to figure out wh=
ich
> > driver is slow, and it's make life easier.
>
> Maybe you should mention this in the patch description.
>
> You know, the "initcall_debug" boot parameter will cause the kernel to
> log the amount of time each device spends doing suspend and resume.

Thanks for you reply.
Yes, you are right, this parameter can print out log of information,
also can echo 1 > /sys/module/kernel/parameters/initcall_debug to enable th=
is.
but the output is really not good to read, and hard to filter out
what's is time consume device:

This=A0 a snapshot of output of initcall_debug when suspend:

PM: Syncing filesystems ... done.
Freezing user space processes ...
PHY: 0:00 - Link is Up - 100/Full
(elapsed 2.71 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
calling=A0 mmc2:0001+ @ 12
call mmc2:0001+ returned 0 after 1 usecs
calling=A0 input9+ @ 12
call input9+ returned 0 after 2 usecs
calling=A0 input8+ @ 12
call input8+ returned 0 after 2 usecs
calling=A0 2-1.4.1:1.1+ @ 4006
call 2-1.4.1:1.1+ returned 0 after 0 usecs   <-- this can be ignore by thre=
shold
calling=A0 input7+ @ 12
call input7+ returned 0 after 1 usecs         <-- this too
calling=A0 2-1.4.1:1.0+ @ 4007
call 2-1.4.1:1.0+ returned 0 after 0 usecs   <-- this too
calling=A0 2-1.4:1.0+ @ 4008
calling=A0 mmc0:0001+ @ 12
call 2-1.4:1.0+ returned 0 after 0 usecs
call mmc0:0001+ returned 0 after 4 usecs
calling=A0 2-1.1:1.0+ @ 4010
calling=A0 2-1.4.1+ @ 4006
call 2-1.1:1.0+ returned 0 after 0 usecs
calling=A0 soc-audio.2+ @ 12
calling=A0 2-1.1+ @ 4007
call 2-1.4.1+ returned 0 after 23052 usecs    <-- name better be
"busname : device name "
calling=A0 2-1.4.1+ @ 4006
call 2-1.4.1+ returned 0 after 0 usecs
calling=A0 2-1.4+ @ 4009
call 2-1.1+ returned 0 after 25869 usecs         <-- this is really
time consuming.
calling=A0 2-1.1+ @ 4007
call 2-1.1+ returned 0 after 0 usecs
call 2-1.4+ returned 0 after 17828 usecs
calling=A0 2-1.4+ @ 4009
call 2-1.4+ returned 0 after 0 usecs
call soc-audio.2+ returned 0 after 1188954 usecs   <--- this too .
calling=A0 input6+ @ 12
call input6+ returned 0 after 1 usecs
calling=A0 2-1:1.0+ @ 4012
call 2-1:1.0+ returned 0 after 0 usecs
calling=A0 2-1+ @ 4012
calling=A0 alarm+ @ 12
call alarm+ returned 0 after 98 usecs
calling=A0 rtc0+ @ 12
call rtc0+ returned 0 after 3 usecs
calling=A0 input5+ @ 12
call 2-1+ returned 0 after 12385 usecs
calling=A0 2-1+ @ 4012
....
....
....
....
....
[ignore 100+ lines.]
PM: suspend of devices complete after 1895.908 msecs

---------log end--------------

you can see this there was lots of driver finish suspend within 10
usecs(most of them are).
call ahci.0+ returned 0 after 0 usecs
                                            ^^
and the name  like:
call 2-1.4.1+ returned 0 after 23052 usecs
       ^^^^^^^^^
I think add a bus name here is better.

Do you think I add a time threshold and a better readable name in
initcall_debug is a good idea ?
I've tried add some threshold into this code, but I don't know where
to put the threshold parameter.
The initcall_debug is a module parameter of kernel/main.c, I don't
think add some threshold here is a good idea.

Also, I think the mission of my patch, and initcall_debug is
different, my patch is aim to filter out some really time consuming
device, but initcall_debug seems to figure out where kernel died when
doing init/suspend/resume operation. It's hard to merge two together.

my patch put this option under PM_DEBUG, and the threshold file under
/sys/power/device_suspend_time_threshold

the output is like this:

bash-3.2# echo 500 > /sys/power/device_suspend_time_threshold
bash-3.2# request_suspend_state: mem (0->3) at 73269332502 (1970-01-02
03:12:18.107533376 UTC)
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
PM: device usb:2-1.1 suspend too slow, it takes          15.758 msecs
PM: device usb:2-1.4.1 suspend too slow, it takes        21.619 msecs
PM: device usb:2-1.4 suspend too slow, it takes          18.569 msecs
PM: device platform:soc-audio.2 suspend too slow, it takes       1216.710 m=
secs
da9052_tsi_suspend: called
PM: device platform:da9052-tsi suspend too slow, it takes        2.538 msecs
PM: device usb:2-1 suspend too slow, it takes    22.371 msecs
PM: suspend of devices complete after 1252.998 msecs
suspend wp cpu=3D400000000
PM: late suspend of devices complete after 0.775 msecs

--- [ log end ] ----

If you want to figure out which device suspend too slow, this patch
will do better.

Thanks.

Jiejing


>
> Alan Stern
>
