From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Wed, 6 May 2009 18:42:59 -0700
Message-ID: <d6200be20905061842l64e71797r11807dff47f335ed@mail.gmail.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<20090505201225.GG1379@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090505201225.GG1379@ucw.cz>
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

On Tue, May 5, 2009 at 1:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> Add a misc device, "suspend_blocker", that allows user-space processes
>> to block auto suspend. The device has ioctls to create a suspend_blocker,
>> and to block and unblock suspend. To delete the suspend_blocker, close
>> the device.
>
> Rafael proposed write() interface. I don't think you answered that.
>

I think an ioctl interface makes more sense. With a write interface
you either have to do string parsing, or invent some other protocol
between the driver and user-space.

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
>> + =A0 =A0 if (!bl)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 if (copy_from_user(bl->name, name, name_len))
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_fault;
>> + =A0 =A0 suspend_blocker_init(&bl->blocker, bl->name);
>> + =A0 =A0 file->private_data =3D bl;
>> + =A0 =A0 return 0;
>
> kzalloc on user-supplied argument. Sounds like bad idea.
>
> Aha. And probably integer overflow in the same line. Ouch.
>

The size is limited to _IOC_SIZEMASK with is 13 or 14 bits depending
on the architecture. Do you want a lower limit on the name length?

> Plus you actually 'trust' the string from userspace. Someone passes
> "evdev" there and can masquerade as a part of kernel.

Yes. I could add a prefix to userspace names, but it did not seem
worth the effort since the name is not used as a key for anything.

>
>> +static int user_suspend_blocker_release(struct inode *inode, struct fil=
e *file)
>> +{
>> + =A0 =A0 struct user_suspend_blocker *bl =3D file->private_data;
>> + =A0 =A0 if (!bl)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 suspend_blocker_destroy(&bl->blocker);
>> + =A0 =A0 kfree(bl);
>> + =A0 =A0 return 0;
>> +}
>
> What happens if someone does dup() on such file descriptor?
>

Then you have two file descriptors pointing to the same suspend
blocker. Release is called when the last reference goes away.

-- =

Arve Hj=F8nnev=E5g
