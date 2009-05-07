From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 3/9] PM: suspend_block: Abort task freezing
	if a suspend_blocker is active.
Date: Thu, 7 May 2009 16:49:27 -0700
Message-ID: <d6200be20905071649h2d3a57c8h1c1cd72d4bea4d31@mail.gmail.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<1241583529-5092-4-git-send-email-arve@android.com>
	<20090505195753.GE1379@ucw.cz>
	<d6200be20905061851y12b07d59t11b43d74a07aad3b@mail.gmail.com>
	<20090507104143.GB6132@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507104143.GB6132@elf.ucw.cz>
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

On Thu, May 7, 2009 at 3:41 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2009-05-06 18:51:11, Arve Hj?nnev?g wrote:
>> On Tue, May 5, 2009 at 12:57 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> If a suspend_blocker is active, suspend will fail anyway. Since
>> >> try_to_freeze_tasks can take up to 20 seconds to complete or fail, ab=
orting
>> >
>> > Please fix try_to_freeze not to take significant time rather than
>> > this...
>>
>> I though we covered this already. Most of the 20 second delays we saw
>> on earlier kernel version have been fixed, but this code can run for
>> 20 seconds which is an unacceptable wakeup delay. Any
>> uninterruptible
>
> If the code runs for 20 seconds, it is a bug to be fixed.

The code gives up after 20 seconds, it does not normally run for 20
seconds. It is arguably a bug that it gives up after 20 seconds since
the time required to freeze all the threads grows with the number of
threads that are running. It could still be making progress after 20
seconds. Since the time required to freeze all tasks is the number of
tasks times the time it takes to interrupt each task there is no way
to ensure that the time required is insignificant. If we do not abort
task freezing when there is a wakeup event, then the worst case wakeup
latency is guarantied to be worse than the worst case latency for any
other uninterruptible kernel call.

>
> IOW the patch should not be needed when the bugs are fixed. You should
> not need it now.
>
> Can you drop it for now (or keep it in private tree or something). If
> you have scenario where it takes significant time and that can't be
> fixed, please present the scenario and we can reconsider it.
>

It can take a significant amount of time. It has to wait for every
thread it signalled to freeze which seems to be every user-space
thread. On my device, with 200 threads, this took less than 10ms half
the time, up to 460ms in the worst case.

> For now, it just makes stuff harder to review.

I think this patch is needed whether there are bugs or not, to ensure
low latency wakeup.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
>


-- =

Arve Hj=F8nnev=E5g
