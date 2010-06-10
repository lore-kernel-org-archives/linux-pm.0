From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Wed, 9 Jun 2010 21:51:38 -0700
Message-ID: <AANLkTilrJYg-z6mbRfhhrDdhpWUYSXGQEMCGgBj24xZs__21422.0501170077$1276145564$gmane$org@mail.gmail.com>
References: <AANLkTilALyvthzh8rMiDFFP_QTz_o5hxdE8tArMUonpP@mail.gmail.com>
	<Pine.LNX.4.44L0.1006091031030.1728-100000@iolanthe.rowland.org>
	<AANLkTil2JhBgJ27qcTARVj2wVgEltxZKPOc9Ddu4c8yY@mail.gmail.com>
	<alpine.DEB.2.01.1006092117100.17462@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.01.1006092117100.17462@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/6/9  <david@lang.hm>:
> On Wed, 9 Jun 2010, Arve Hj?nnev?g wrote:
>
>>
>> The power may not see the event, the process that reads the event will
>> always see it. If the power manager is not in the poll call when the
>> event happens, the process that reads the event can read the event
>> before the power manager calls poll.
>>
>
>>
>> All input events that can wake the system are handled by one
>> user-space suspend blocker. Input devices come and go so we would need
>> to add and remove the fds dynamically.
>
>
>>
>> For that to work the wakeup events would have to be reported to the
>> power manager in a reliable way in the first place. Passing the file
>> descriptor that the app uses to the power manager does not work for
>> this, since the app could read the event while the power manager was
>> not in the poll call and the power manager would never see it. Also,
>> existing apps don't pass their file descriptors to the power manager,
>> so it has the get the event from somewhere else.
>>
>
> why could the suspend blocker process see all events, but the power manag=
er
> process not see the events?
>

Because in this proposal the power manager only looks for the events
(on the same queue) when no user space suspend blockers are active.

> have the userspace talk to the power manager the way it does to the suspe=
nd
> blocker now and what's the difference?
>
> effectivly think s/suspend blocker/power manager/ (with the power manager
> doing all the other things that are proposed instead of grabbing the
> wakelock), the difference should be hidden to the rest of userspace.
>
> what am I missing here?
>

The current user space interface does not require that clients
register the file descriptors that they get wakeup events from with
another process.

-- =

Arve Hj=F8nnev=E5g
