From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Thu, 22 Apr 2010 20:54:59 -0700
Message-ID: <z2wd6200be21004222054qaf4a0b0doa13aea4c7ef049d7__30806.4584424303$1271994991$gmane$org@mail.gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<20100423022522.GB32490@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100423022522.GB32490@count0.beaverton.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2010/4/22 Matt Helsley <matthltc@us.ibm.com>:
...
> On Thu, Apr 22, 2010 at 06:08:51PM -0700, Arve Hj=F8nnev=E5g wrote:
>> +To create a suspend_blocker from user-space, open the suspend_blocker d=
evice:
>> + =A0 =A0fd =3D open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
>> +then call:
>> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_INIT(strlen(name)), name);
>
> Why not initialize the user suspend blocker struct by default and then
> allow each BLOCK to specify the name? Also, my guess is it's not
> really a name so much as a description of why we're blocking suspend,
> right?
>

There are stats tracked as long as the suspend blocker exists.
Specifying a new name every time you block suspend would make this
less useful.

> Should the kernel reject empty strings or strings composed only of
> "non-printing" characters?
>

Is there an existing function that check if a sting is "unsafe". If
so, I can add a call to this.

>> +
>> +To activate a suspend_blocker call:
>> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_BLOCK);
>> +
>> +To unblock call:
>> + =A0 =A0ioctl(fd, SUSPEND_BLOCKER_IOCTL_UNBLOCK);
>
> lsof will show which tasks hold the device open but not which ones
> are blocking suspend. If merely keeping the device open corresponded to
> blocking suspend then this would be obvious and no ioctls would be
> necessary -- just write() the name/description.

We track more information about suspend blockers than this.

>
> Do you block/unblock often enough that frequent open/close of the device =
are
> a problem?

Yes.

...
>> +
>> +static DEFINE_MUTEX(ioctl_lock);
>
> nit: Usually locks protect data -- not functions.
>
> Couldn't this be part of the user_suspend_blocker struct? That would allow
> the description/name to change as described above.

It mainly protects the allocation of that struct, so no. Allocating a
separate struct in open would work, but does not seem worth it at the
moment.

>
>> +
>> +struct user_suspend_blocker {
>> + =A0 =A0 struct suspend_blocker =A0blocker;
>> + =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[0];
>> +};
>
> <snip>
>
> Cheers,
> =A0 =A0 =A0 =A0-Matt Helsley
>



-- =

Arve Hj=F8nnev=E5g
