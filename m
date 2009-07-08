From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 8)
Date: Wed, 8 Jul 2009 13:40:06 +0900
Message-ID: <aec7e5c30907072140y7dd3b4c7ge7cb0b750bef3226__40607.3951897726$1247028079$gmane$org@mail.gmail.com>
References: <200907080007.38595.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0907072222210.13052-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0907072222210.13052-100000@netrider.rowland.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 8, 2009 at 11:54 AM, Alan Stern<stern@rowland.harvard.edu> wrot=
e:
> On Wed, 8 Jul 2009, Rafael J. Wysocki wrote:
>
>> > I've now jumped from v5 to v8 and I feel that the code is getting
>> > cleaner and cleaner. Very nice.
>>
>> That's mostly thanks to Alan.
>
> I haven't had time yet to look through the new code. =A0Things have been
> very busy.
>
>> > Issue 1:
>> > ------------
>> > Device drivers which do not perform any hardware access in probe()
>> > work fine. During software setup in probe() the runtime pm code is
>> > initialized with the following:
>> >
>> > + =A0 pm_suspend_ignore_children(&dev->dev, true);
>> > + =A0 pm_runtime_set_suspended(&dev->dev);
>> > + =A0 pm_runtime_enable(&dev->dev);
>> >
>> > Before accessing hardware I perform:
>> > + =A0 pm_runtime_resume(pd->dev);
>> >
>> > When done with the hardware I do:
>> > + =A0 pm_runtime_suspend(pd->dev);
>> >
>> > Not so complicated. Am I supposed to initialize something else as well?
>
> No, that's all you need.

Ok, thank you!

>> > All good with the code above, but there seem to be some issue with how
>> > usage_count is counted up and down and when runtime_disabled is set:
>> >
>> > 1. pm_runtime_init(): usage_count =3D 1, runtime_disabled =3D true
>> > 2. driver_probe_device(): pm_runtime_get_sync()
>> > 3. pm_runtime_get_sync(): usage_count =3D 2
>> > 4. device driver probe(): pm_runtime_enable()
>> > 5. pm_runtime_enable(): usage_count =3D 1
>> > 6. driver_probe_device(): pm_runtime_put()
>> > 7. pm_runtime_put(): usage_count =3D 0
>> >
>> > I expect runtime_disabled =3D false in 7.
>
> Wasn't it? =A0It should have been set to false in step 4 and remained
> that way.

I may misunderstand, but in v8 won't the pm_runtime_enable() function
do a atomic_dec_test() where the counter value will go from 2 to 1 in
the case above? This would mean that atomic_dec_test() returns false
so runtime_disabled is never modified.

Thanks for your feedback,

/ magnus
