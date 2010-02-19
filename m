From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: s2disk hang update
Date: Fri, 19 Feb 2010 11:48:15 +0000
Message-ID: <9b2b86521002190348k61e3bce0m8d036d1068c05644__17782.8608001166$1266580183$gmane$org@mail.gmail.com>
References: <9b2b86521001020703v23152d0cy3ba2c08df88c0a79@mail.gmail.com>
	<201002172058.04043.rjw@sisk.pl>
	<9b2b86521002180453l176a83dand809dc239c220c08@mail.gmail.com>
	<201002182104.49631.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002182104.49631.rjw@sisk.pl>
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
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel <linux-kernel@vger.kernel.org>, hugh.dickins@tiscali.co.uk, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2/18/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday 18 February 2010, Alan Jenkins wrote:
>> On 2/17/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Wednesday 17 February 2010, Alan Jenkins wrote:
>> >> On 2/16/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> > On Tuesday 16 February 2010, Alan Jenkins wrote:
>> >> >> On 2/16/10, Alan Jenkins <sourcejedi.lkml@googlemail.com> wrote:
>> >> >> > On 2/15/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> >> >> On Tuesday 09 February 2010, Alan Jenkins wrote:
>> >> >> >>> Perhaps I spoke too soon.  I see the same hang if I run too many
>> >> >> >>> applications.  The first hibernation fails with "not enough
>> >> >> >>> swap"
>> >> >> >>> as
>> >> >> >>> expected, but the second or third attempt hangs (with the same
>> >> >> >>> backtrace
>> >> >> >>> as before).
>> >> >> >>>
>> >> >> >>> The patch definitely helps though.  Without the patch, I see a
>> >> >> >>> hang
>> >> >> >>> the
>> >> >> >>> first time I try to hibernate with too many applications
>> >> >> >>> running.
>> >> >> >>
>> >> >> >> Well, I have an idea.
>> >> >> >>
>> >> >> >> Can you try to apply the appended patch in addition and see if
>> >> >> >> that
>> >> >> >> helps?
>> >> >> >>
>> >> >> >> Rafael
>> >> >> >
>> >> >> > It doesn't seem to help.
>> >> >>
>> >> >> To be clear: It doesn't stop the hang when I hibernate with too many
>> >> >> applications.
>> >> >>
>> >> >> It does stop the same hang in a different case though.
>> >> >>
>> >> >> 1. boot with init=/bin/bash
>> >> >> 2. run s2disk
>> >> >> 3. cancel the s2disk
>> >> >> 4. repeat steps 2&3
>> >> >>
>> >> >> With the patch, I can run 10s of iterations, with no hang.
>> >> >> Without the patch, it soon hangs, (in disable_nonboot_cpus(), as
>> >> >> always).
>> >> >>
>> >> >> That's what happens on 2.6.33-rc7.  On 2.6.30, there is no problem.
>> >> >> On 2.6.31 and 2.6.32 I don't get a hang, but dmesg shows an
>> >> >> allocation
>> >> >> failure after a couple of iterations ("kthreadd: page allocation
>> >> >> failure. order:1, mode:0xd0").  It looks like it might be the same
>> >> >> stop_machine thread allocation failure that causes the hang.
>> >> >
>> >> > Have you tested it alone or on top of the previous one?  If you've
>> >> > tested it
>> >> > alone, please apply the appended one in addition to it and retest.
>> >> >
>> >> > Rafael
>> >>
>> >> I did test with both patches applied together -
>> >>
>> >> 1. [Update] MM / PM: Force GFP_NOIO during suspend/hibernation and
>> >> resume
>> >> 2. "reducing the number of pages that we're going to keep preallocated
>> >> by
>> >> 20%"
>> >
>> > In that case you can try to reduce the number of preallocated pages even
>> > more,
>> > ie. change "/ 5" to "/ 2" (for example) in the second patch.
>>
>> It still hangs if I try to hibernate a couple of times with too many
>> applications.
>
> Hmm.  I guess I asked that before, but is this a 32-bit or 64-bit system and
> how much RAM is there in the box?
>
> Rafael

EeePC 701.  32 bit.  512Mb RAM.  350Mb swap file, on a "first-gen" SSD.

Alan
