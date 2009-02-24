From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 23 Feb 2009 16:02:42 -0800
Message-ID: <d6200be20902231602h5c69ead3s5f3f206497f1b19e__11200.6939169534$1235434002$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl> <200902212120.37684.rjw@sisk.pl>
	<d6200be20902231513h31661a95n63407b5194b56d51@mail.gmail.com>
	<200902240053.11164.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902240053.11164.rjw@sisk.pl>
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

On Mon, Feb 23, 2009 at 3:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday 24 February 2009, Arve Hj=F8nnev=E5g wrote:
>> On Sat, Feb 21, 2009 at 12:20 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> On Sat, Feb 21, 2009 at 1:47 AM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> >> > On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> >> On Fri, Feb 20, 2009 at 3:57 PM, Rafael J. Wysocki <rjw@sisk.pl> w=
rote:
>> >> >> > On Saturday 21 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> >> >> On Fri, Feb 20, 2009 at 7:56 AM, Rafael J. Wysocki <rjw@sisk.pl=
> wrote:
>> >> >> >> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> >> >> >> On Fri, Feb 20, 2009 at 2:49 AM, Rafael J. Wysocki <rjw@sisk=
.pl> wrote:
>> >> >> >> >> > On Friday 20 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> >> >> >> >> On Thu, Feb 19, 2009 at 2:08 PM, Alan Stern <stern@rowlan=
d.harvard.edu> wrote:
>> > [--snip--]
>> >> >> > The idea is to have both /sys/power/state and /sys/power/sleep a=
t the same
>> >> >> > time, where /sys/power/state will work just like it does right n=
ow.  Sure,
>> >> >> > there must be mutual exclusion between the two, but that's a mat=
ter of
>> >> >> > implementation IMO.
>> >> >>
>> >> >> If you want to only prevent suspend though one interface, you have=
 to
>> >> >> also pass information to the driver about its suspend hook is being
>> >> >> called so it can conditionally return -EBUSY. The wakelock interfa=
ce
>> >> >> requires less code in each driver.
>> >> >
>> >> > Well, I don't think so.  Moreover, it requires you to spread wakelo=
cks all
>> >> > over the place if you don't use the timeouted ones which, let's fac=
e it, is
>> >> > hardly acceptable.
>> >>
>> >> Your method does not reduce the number of places that has to be
>> >> modified. Any component where we add a wakelock, you have to add a
>> >> suspend handler to abort suspend when we would have held a wakelock.
>> >
>> > Well, maybe not, but it doesn't introduce entirely new API for device =
drivers.
>> > Instead, it extends the existing interfaces which I think is more appr=
opriate.
>>
>> The existing interfaces require polling. I don't think extending these
>> interfaces to make the polling faster is a better solution than adding
>> an interface to avoid polling.
>>
>> Also, with your solution, how would you modify evdev.c to prevent
>> suspend while the event queue is not empty. This code does not have
>> any suspend hooks and the queue is not tied to any thread.
>
> Well, why do you need to modify evdev.c in the first place?

It is the only code that knows that there are unprocessed input events.

-- =

Arve Hj=F8nnev=E5g
