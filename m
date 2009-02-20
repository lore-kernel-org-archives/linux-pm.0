From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 03:26:36 -0800
Message-ID: <d6200be20902200326g6caa211ai388d4aa9fc270a28__41395.6606564627$1235129344$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902191659020.7953-100000@iolanthe.rowland.org>
	<d6200be20902191839w1f74a962h30e859c8b2434f59@mail.gmail.com>
	<200902201149.37921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902201149.37921.rjw@sisk.pl>
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

On Fri, Feb 20, 2009 at 2:49 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
>> On Thu, Feb 19, 2009 at 2:08 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
>> >> > It might have to be platform-specific.  The Android people seem to =
have a
>> >> > pretty good idea of what criteria will work for them.
>> >>
>> >> I'd really like to know in what situations Androind is supposed to su=
spend
>> >> automatically.
>> >
>> > It might be better to ask in what situations Android is _not_ supposed
>> > to sleep automatically.  In other words, in what situations is a
>> > wakelock acquired?  Since the whole system is only a phone, this
>> > question should have a reasonably well-defined answer.
>>
>> On an android phone, any code that needs to run when the screen is off
>> must hold a wakelock (directly or indirectly). In general if an
>> application or the system is processing an event that may cause a user
>> notification (new email, incoming phone call, alarm, etc.) it needs to
>> prevent suspend. But, we also use wakelocks to upload stats or
>> download system updates in the background, and for media player or
>> (gps) data logging applications.
>
> All of this doesn't seem to require wakelocks acuired from kernel space.
> What do you need those wakelocks for?

Most events do not originate in user-space. Alarms start in our alarm
driver which locks a wakelock when its timer interrupt occurs. This
wakelock stays locked until the user-space alarm manager calls the
driver to wait for the next alarm. I've described how input events are
handled before. Without kernel wakelocks, if the user space power
manager had already turned off the screen and decided to suspend right
before a wakeup key is pressed, then that key could sit in the
in-kernel input queue until another key is pressed. Even if the
user-space thread read the key event before being frozen, it cannot
abort the suspend operation that was already started.

-- =

Arve Hj=F8nnev=E5g
