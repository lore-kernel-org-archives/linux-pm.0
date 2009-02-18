From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 14:35:26 -0800
Message-ID: <d6200be20902181435o1794007bpfbab1f9e41979bad@mail.gmail.com>
References: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
	<200902180022.00239.rjw@sisk.pl>
	<d6200be20902172046sf00599ckc6710c6132d6b92f@mail.gmail.com>
	<200902182217.48321.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902182217.48321.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 18, 2009 at 1:17 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday 18 February 2009, Arve Hj=F8nnev=E5g wrote:
>> On Tue, Feb 17, 2009 at 3:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Tuesday 17 February 2009, Alan Stern wrote:

>> >> Kernel wakelocks are a separate matter.  They are more like a form of
>> >> optimization, preventing the kernel from starting an auto-suspend when
>> >> some driver knows beforehand that it will return -EBUSY.
>> >
>> > I think kernel-side autosuspend (or rather autosleep) should only happ=
en
>> > after certain subset of devices have been suspended using a per-device
>> > run-time autosuspend mechanism.
>>
>> When the last wakelock is released the task that we woke up to perform
>> has finished. Why wait to re-enter suspend.
>
> I don't really understand this comment.  Could you please explain a bit?

If some devices are autosuspended after a local inactivity timeout, I
don't want to wait for those devices to autosuspend if I know the code
that needed to run is done. This could cause delays in the normal
case, and it could prevent suspend if a background process (not using
wakelocks) is accessing a disk more frequently than its idle timeout.

>
>> >> > Phase 3: Probably explicit control left to open/close.
>> >>
>> >> While that's generally a good idea, it's important to recognize that
>> >> some devices should be runtime-suspended even while they are open.
>> >
>> > From the kernel side, yes (and that should be transparent to the user =
space
>> > having them open).  By the user space, no.
>>
>> Allowing user space to suspend input devices while they are still open
>> is useful. The user-space code that reads from the input devices does
>> not need to know if the device is suspended or not, and the kernel
>> cannot auto suspend input devices based on inactivity.
>
> Hmm.  Why can't it?

Because they stop working. It is OK for us to turn off the touchscreen
when the screen is off, but when the screen is on the user will touch
items on the screen and expect them to respond. (We could also turn
off the touchscreen when the keyguard is on, but we don't currently do
this.)

-- =

Arve Hj=F8nnev=E5g
