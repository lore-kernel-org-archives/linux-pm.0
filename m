From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Wed, 6 May 2009 18:31:36 -0700
Message-ID: <d6200be20905061831o43df8558pdbc0b5284f8a8f20@mail.gmail.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<20090505201624.GH1379@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090505201624.GH1379@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 5, 2009 at 1:16 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2009-05-05 21:18:42, Arve Hj??nnev??g wrote:
>> Add a misc device, "suspend_blocker", that allows user-space processes
>> to block auto suspend. The device has ioctls to create a suspend_blocker,
>> and to block and unblock suspend. To delete the suspend_blocker, close
>> the device.
>>
>
>> +static int create_user_suspend_blocker(struct file *file, void __user *=
name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t name=
_len)
>> +{
>> + =A0 =A0 struct user_suspend_blocker *bl;
>> + =A0 =A0 if (file->private_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 bl =3D kzalloc(sizeof(*bl) + name_len + 1, GFP_KERNEL);
> ...
>> +static long user_suspend_blocker_ioctl(struct file *file, unsigned int =
cmd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long =
_arg)
>> +{
>> + =A0 =A0 void __user *arg =3D (void __user *)_arg;
>> + =A0 =A0 struct user_suspend_blocker *bl;
>> + =A0 =A0 long ret;
>> +
>> + =A0 =A0 mutex_lock(&ioctl_lock);
>> + =A0 =A0 if ((cmd & ~IOCSIZE_MASK) =3D=3D SUSPEND_BLOCKER_IOCTL_INIT(0)=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D create_user_suspend_blocker(file, arg,=
 _IOC_SIZE(cmd));
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 }
>
> Wait a moment, wtf is this? Not one ioctl but one ioctl per length of
> string?!

This is not uncommon. _IOC encodes the size of the argument, and if
this is not a fixed size, then the raw ioctl number change based on
the size passed in. Look at input.h is you want other examples of
this.

-- =

Arve Hj=F8nnev=E5g
