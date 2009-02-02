From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 15:10:10 -0800
Message-ID: <d6200be20902021510k104f2da9ha89fa00baff3910a@mail.gmail.com>
References: <200902021200.59992.u.luckas@road.de>
	<Pine.LNX.4.44L0.0902021005050.2550-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902021005050.2550-100000@iolanthe.rowland.org>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 2, 2009 at 7:09 AM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> On Mon, 2 Feb 2009, Uli Luckas wrote:
>> Except you always want early-suspend and auto-suspend at the same time. =
The
>> idea is, if all display of system states is off (early-suspend), we can
>> enable or disable the cpu at will (auto-suspend) because nobody will not=
ice.
>
> Why should the kernel have to get involved?  Why can't userspace manage
> both early-suspend and auto-suspend?

The kernel does not need to be involved in early-suspend. We use
early-suspend as a simple way to shut down the framebuffer and some
input devices.
If by auto-suspend you mean suspend after user inactivity (usually
after a number of seconds or minutes), then the kernel does not need
to be involved, but if you mean suspending when all wakelocks are
unlocked, the kernel needs to be involved to avoid delays. If the last
wakelock to be unlocked is a kernel wakelock, then user-space would
not know that it needs to re-attempt suspend.

> That is, consider the following: Userspace initiates an early-suspend
> by using a runtime PM interface to turn off the screen and some other
> devices.  After a short time, if they are still off, then userspace can
> initiate an auto-suspend by writing "auto-mem" to /sys/power/state.

Why do you want a delay?
Also, what do you mean by a runtime PM interface?

> All the kernel would need to know is the difference between
> auto-suspend and normal suspend: one respects wakelocks and the other
> doesn't.

If by normal suspend you mean what is supported in the kernel now,
then OK. We can support existing userspace code by ignoring wakelocks.
My intention was that you only enable the WAKELOCK config option when
using it, but I agree that it is better to allow the kernel to be
built with support for both modes.

What do you think should happen if user-space tries to use both interfaces?

-- =

Arve Hj=F8nnev=E5g
