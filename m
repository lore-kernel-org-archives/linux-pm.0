From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Wed, 28 Apr 2010 15:31:03 -0700
Message-ID: <k2gd6200be21004281531y270549d7g8383f2c8a55038d4__23960.651519201$1272493986$gmane$org@mail.gmail.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<1272429119-12103-2-git-send-email-arve@android.com>
	<1272429119-12103-3-git-send-email-arve@android.com>
	<201004282258.51354.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004282258.51354.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday 28 April 2010, Arve Hj=F8nnev=E5g wrote:
>> Add a misc device, "suspend_blocker", that allows user-space processes
>> to block auto suspend. The device has ioctls to create a suspend_blocker,
>> and to block and unblock suspend. To delete the suspend_blocker, close
>> the device.
>>
>> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ...
>> +
>> +#include <linux/fs.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/slab.h>
>> +#include <linux/suspend_blocker.h>
>> +#include <linux/suspend_block_dev.h>
>> +
>> +enum {
>> + =A0 =A0 DEBUG_FAILURE =A0 =3D BIT(0),
>> +};
>> +static int debug_mask =3D DEBUG_FAILURE;
>
> What's the exact purpose of this?

To show errors returned to user space. I can turn it off by default if you =
want.

>
>> +module_param_named(debug_mask, debug_mask, int, S_IRUGO | S_IWUSR | S_I=
WGRP);
>> +
>> +static DEFINE_MUTEX(ioctl_lock);
>> +
>> +struct user_suspend_blocker {
>> + =A0 =A0 struct suspend_blocker =A0blocker;
>> + =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[0];
>> +};
>
> Why is this not in a header?

It's private to this file.

>
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



-- =

Arve Hj=F8nnev=E5g
