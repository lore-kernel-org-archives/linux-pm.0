From: Michal Feix <michal@feix.cz>
Subject: Re: Kernel stability on baytrail machines
Date: Tue, 20 Sep 2016 15:27:15 +0200
Message-ID: <52f4410f940da1122158888930d53d01@feix.cz>
References: <606d9b223f3c12775d108b98c4df72ae@feix.cz>
 <20160409160119.GA19362@xo-6d-61-c0.localdomain>
 <20160409201417.4436d4bd@lxorguk.ukuu.org.uk> <20160712194158.GA4834@laptop>
 <20160718143003.3477c0bc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160718143003.3477c0bc@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
List-Id: linux-pm@vger.kernel.org

Hi, I think there might be another clue on this one.

One of the comments is also mentioning an unfixed erratum of certain 
Baytrail processors, named as "EOI Transaction May Not be Sent if 
Software Enters Core C6 During an Interrupt Service Routine". This 
erratum can be found on several different processors, even on several 
non-baytrails, like Inte Xeon 3400 and similar.

I also came across a patch that was created for SUSE and that seems to 
be adressing this issue in pre 4.X kernels:

https://build.opensuse.org/package/view_file?file=22160-Intel-C6-EOI.patch&package=xen&project=home%3Acharlesa%3AopenSUSE11.3&rev=7

---
Michal


Dne 18.7.2016 15:30, One Thousand Gnomes napsal:
> On Tue, 12 Jul 2016 16:41:58 -0300
> Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> 
>> Hi Alan,
>> 
>> (Adding interested people to this thread)
>> 
>> On 09 Apr 08:14 PM, One Thousand Gnomes wrote:
>> > > > I do feel that the importance of the mentioned bug is currently
>> > > > underestimated. Can anyone here give a note, how much current linux
>> > > > kernel is supposed to be stable on general baytrail machines?
>> > >
>> > > If you did not get any replies... you might want to check MAINTAINERS file, and
>> > > put Intel x86 maintainers on Cc list.
>> > >
>> > > I'm sure someone cares :-).
>> >
>> > Yes we care, and there are people looking at the various reports.
>> >
>> 
>> Are there any updates on the status of this issue?
>> 
>> The current bugzilla report [1] marks this as a power management
>> issue. However, many reports indicate that it would only freeze
>> when running X, so it's not completely clear if it's related to
>> the gfx driver too.
> 
> There are two things we are currently tracking. One of them was merged
> which seems to have made my machine stable at least and fixes a problem
> related to the MMC. The second one we may need is a power related 
> changed
> to SPI to hold the CPU in C0/C1 whenever the ACPI _SEM is held.
> 
> Graphics shows these problems up because of the way the GPU causes 
> power
> state changes.
> 
> Alan
