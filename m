From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 4/9] Input: Block suspend while event queue
	is not empty.
Date: Wed, 6 May 2009 18:57:59 -0700
Message-ID: <d6200be20905061857i750e3d1dp136eec2c67a1a79c@mail.gmail.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<1241583529-5092-4-git-send-email-arve@android.com>
	<1241583529-5092-5-git-send-email-arve@android.com>
	<20090505200230.GF1379@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090505200230.GF1379@ucw.cz>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, dmitry.torokhov@gmail.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 5, 2009 at 1:02 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
>> Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that will =
block
>> suspend while the event queue is not empty. This allows userspace code to
>> process input events while the device appears to be asleep.
>>
>> Signed-off-by: Arve Hj??nnev??g <arve@android.com>
>
> Looks ok to =A0me, but I guess you should cc input maintainers.

OK.

>
>> @@ -582,6 +591,19 @@ static long evdev_do_ioctl(struct file *file, unsig=
ned int cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return evdev_ungrab(evdev, c=
lient);
>>
>> + =A0 =A0 case EVIOCGSUSPENDBLOCK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return put_user(client->use_suspend_blocker, i=
p);
>> +
>> + =A0 =A0 case EVIOCSSUSPENDBLOCK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&client->buffer_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!client->use_suspend_blocker && p)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_blocker_init(&client->=
suspend_blocker, "evdev");
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (client->use_suspend_blocker && !p)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_blocker_destroy(&clien=
t->suspend_blocker);
>> + =A0 =A0 =A0 =A0 =A0 =A0 client->use_suspend_blocker =3D !!p;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&client->buffer_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> This returns 0 even when you destroy already destroyed blocker
> (etc). Is that ok?

Yes. If events did not block suspend before the call, they still do
not block suspend after the call, so the requested state was reached.

-- =

Arve Hj=F8nnev=E5g
