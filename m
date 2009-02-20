From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 14:43:24 -0800
Message-ID: <d6200be20902201443l670f7ee4s8b9fd7d2400bbf9c__10068.326679948$1235170654$gmane$org@mail.gmail.com>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<20090220182213.GA1681@ucw.cz> <20090220182609.GA3289@srcf.ucam.org>
	<200902202149.25990.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902202149.25990.rjw@sisk.pl>
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

On Fri, Feb 20, 2009 at 12:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 20 February 2009, Matthew Garrett wrote:
>> On Fri, Feb 20, 2009 at 07:22:15PM +0100, Pavel Machek wrote:
>> >  On Mon 2009-02-16 23:23:30, Matthew Garrett wrote:
>> > > On Tue, Feb 17, 2009 at 12:19:38AM +0100, Rafael J. Wysocki wrote:
>> > >
>> > > > This, again, seems to be a bit x86-centric. :-)  The Android peopl=
e are telling
>> > > > us that on the hardware they deal with it does make sense to put t=
he entire
>> > > > system to sleep even for relatively short periods of time, since t=
he latencies
>> > > > involved are not too bad.
>> > >
>> > > Arve said that the power state was equivalent in idle and suspend, b=
ut
>> >
>> > ...for Arve's hardware. Not all embedded systems are like that, and
>> > OLPC / PCs are definitely not like that.
>>
>> And PCs have enough latency over suspend/resume that we can't do it
>> automatically in a non-intrusive manner anyway, so runtime pm is more
>> interesting there as well.
>
> Agreed.

That high latency is coupled to a large difference in power use. If
the latency of the lowest power state is too high to use from idle, it
makes it more important, not less important, to enter suspend when
possible.

-- =

Arve Hj=F8nnev=E5g
