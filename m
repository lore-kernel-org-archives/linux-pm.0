From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/4] PM: Remove redundant checks from
 core device resume routines
Date: Sun, 12 Dec 2010 17:34:12 -0800
Message-ID: <AANLkTi=UVOQb15EdpfSeD+Qh8x779pJpsSCTyGvf-gxG__1171.12620869211$1292204218$gmane$org@mail.gmail.com>
References: <201012130128.31243.rjw@sisk.pl> <201012130131.24970.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012130131.24970.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

So I really like this series not only because it implements what I
suggested, but also because each patch seems to remove more lines than
it adds. That's always nice, and much too unusual.

But in this one, I really think you should simplify/clarify things further:

On Sun, Dec 12, 2010 at 4:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> +++ linux-2.6/drivers/base/power/main.c
> @@ -485,20 +485,17 @@ void dpm_resume_noirq(pm_message_t state
> =A0 =A0 =A0 =A0transition_started =3D false;
> =A0 =A0 =A0 =A0while (!list_empty(&dpm_noirq_list)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device *dev =3D to_device(dpm_noirq=
_list.next);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int error;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_device(dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->power.status > DPM_OFF) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int error;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.status =3D DPM_O=
FF;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&dpm_list_mtx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.status =3D DPM_OFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&dpm_list_mtx);

I think you should move the device to the dpm_suspended list _here_,
before dropping the mutex. That way the power.status thing matches the
list.

So then you'd just remove the crazy conditional "if it's still on a
list, move it to the right list" thing, and these two lines:

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!list_empty(&dev->power.entry))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_move_tail(&dev->power=
.entry, &dpm_suspended_list);

Would just be that plain

        list_move_tail(&dev->power.entry, &dpm_suspended_list);

before you even drop the lock. That look much simpler, and the list
movement seems a lot more obvious, no?

If an unregister event (or whatever) happens while you had the mutex
unlocked, it will just remove it from the new list (the one that
matches the power state). So no need for that whole complexity with
"what happens with the list if somebody removed the device while we
were busy suspending/resuming it".

Or am I missing something?

(And same comment for that other identical case in dpm_complete())

                 Linus
