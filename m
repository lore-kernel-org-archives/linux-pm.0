From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 23:16:17 -0700
Message-ID: <AANLkTilIRYGuxxI9ytsFxCkPtJ4RDoOV6suYI5eFA1Oq__24919.7780307897$1275027515$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271517170.3239-100000@iolanthe.rowland.org>
	<1275023742.27810.7782.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275023742.27810.7782.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: felipe.balbi@nokia.com, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 10:15 PM, Peter Zijlstra <peterz@infradead.org> wro=
te:
> On Thu, 2010-05-27 at 15:19 -0400, Alan Stern wrote:
>> On Thu, 27 May 2010, Peter Zijlstra wrote:
>>
>> > I still don't see how blocking applications will cause missed wakeups =
in
>> > anything but a buggy application at worst, and even those will
>> > eventually get the event when they unblock.
>> >
>> > What seems to be the confusion?
>>
>> During forced suspend, applications are block because they are frozen.
>>
>> When an event occurs, the application is notified somehow. =A0But it
>> can't respond because it is frozen. =A0Hence the event remains sitting in
>> a kernel queue and the system goes ahead and suspends anyway. =A0The
>> application doesn't get thawed until the system wakes up at some
>> indefinite time in the future.
>
> If the kernel is awake to put things in queues, we're clearly not
> suspended and userspace is running ?!

Suspend is not an atomic operation. User space is frozen before
freezable kernel threads both of these happen before drivers are
suspended.

-- =

Arve Hj=F8nnev=E5g
