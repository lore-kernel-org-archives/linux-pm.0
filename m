From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 3 Mar 2009 15:51:58 -0800
Message-ID: <d6200be20903031551s1b834c77u1469ef9025fda904__15439.6545295187$1236124552$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl> <200902272155.42010.rjw@sisk.pl>
	<d6200be20902271456w77951afata1d5f378ddbe6b84@mail.gmail.com>
	<200902281118.14595.rjw@sisk.pl>
	<d6200be20902281357r2d3a0075q77055c1781f174d7@mail.gmail.com>
	<20090303135750.GC5060@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090303135750.GC5060@elf.ucw.cz>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 3, 2009 at 5:57 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> If you ignore wakelocks with timeouts, the current
>> >> wakelock interface can be implemented with a global atomic_t to
>> >> prevent suspend, and a per wakelock atomic_t to prevent a single
>> >> client from changing the global reference count by more than one.
>> >>
>> >> There are a couple of reasons that I have not done this. It removes
>> >> the ability to easily inspect the system when it is not suspending.
>> >
>> > Care to elaborate?
>>
>> If you have a single atomic_t and it is not 0, you do not know who
>> incremented it.
>
> Which is okay for already debugged system. For debugging, yes some
> support can be nice.

Yes, but installing an app can turn your debugged system into an
undebugged system. I think is fine to have a kernel option to disable
all debugging support, I just don't think it is the top priority. I
have two options for making the no-stats no-timeout configuration
faster. Option one, always use a reference count, and implement the
other configurations on top of this. This makes the shipping
configuration slower. Option two, use a completely separate
implementation when stats or timeouts are enabled. This makes the fast
version virtually untested. Neither of these are very appealing at the
moment.

-- =

Arve Hj=F8nnev=E5g
