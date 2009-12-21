From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Tue, 22 Dec 2009 07:04:28 +1100
Message-ID: <4B2FD4CC.5070609__32654.8636578538$1261426029$gmane$org@crca.org.au>
References: <200912210140.19713.rjw@sisk.pl> <4B2F22EF.6040500@crca.org.au>
	<1261425499.4328.10.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1261425499.4328.10.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi.

Maxim Levitsky wrote:
> On Mon, 2009-12-21 at 18:25 +1100, Nigel Cunningham wrote: 
>> Hi.
>>
>> Rafael J. Wysocki wrote:
>>> I'm not sure what the next step should be at this point.  To me, the picture is
>>> quite clear now, but perhaps we ought to run more tests on some other machines
>>> or something.  Please let me know what you think.
>> Looks great. If you do decide you want other machines tested, I'll
>> happily try the machines around here:
>>
>> - Dell M1530
>> - Omnibook XE3-GF.
>> - Via LN10000 based Mythtv Box
>> - Desktop machine - Some Intel-based mobo I've forgotten the name of.
>>
>> I've been quietly following the thread, but have lost track of what
>> iteration of the patch you're on, so if you'd give me a pointer to it,
>> I'd be grateful.
>>
>> By the way, I haven't forgotten about sending some real patches for
>> swsusp (ie more than just cleanups). I'm just busy with other things and
>> also thinking carefully about what order to do things in.
> 
> I vote for ability to save all ram to the disk.
> After several days of testing I managed to make my system do s2disk
> really reliable (~300 cycles tested), but suspending when memory is
> tight still fails sometimes.
> 
> I didn't yet use your tuxonice system  though.

Well, I want to and intend on working towards merging as much of
TuxOnIce as people will allow in, but it will take a long time because
there are so many modifications to do, I don't have that much time to
work on it, am splitting the time I do have and am still have a couple
of new features I want to do to TuxOnIce.

Regards,

Nigel
