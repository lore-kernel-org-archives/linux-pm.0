From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.16-rc3 fails to resume on MacBookPro10,1 -
Date: Sat, 3 Mar 2018 11:00:28 +0100
Message-ID: <CAJZ5v0iVmE0jwRW1f6hnohSVzKsZbLr0axi+VKoR+FQcHM+_7w@mail.gmail.com>
References: <CA+Y=x3=U_zheHBxeNSzL9nSdXOZB7rs-JDNr36323uJ9Uhx0Hg@mail.gmail.com>
 <CA+Y=x3=+kPXJRNYo91i4yJiqqVHDsMhn2pAwkmAH2LV3usd7Hg@mail.gmail.com> <20180303092417.GA30917@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180303092417.GA30917@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Worsley <amworsley@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, 844788@bugs.debian.org
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 3, 2018 at 10:24 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> On Sat 2018-03-03 17:27:36, Andrew Worsley wrote:
>> On 3 March 2018 at 16:41, Andrew Worsley <amworsley@gmail.com> wrote:
>> > Basically hangs on resuming after decompressing. The last statement
>> > displayed is "resume: Image successfully loaded"
>> >  - I attach a photo as I can't get access to it
>> ....
>> > Bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=844788
>> >
>> > I couldn't get anything from the function keys with this latest kernel.
>> ...
>>
>> By plugging in a USB keyboard I can get sysrq stuff to work - but
>> stupidly the kernel disables all the useful ones so I will have to
>> compile a new kernel with it set to 1 so I can get some traces.
>> Really annoyed by this default setting, presumably from debian?
>> Wished there was a boot command line option to configure the allowed
> options.
>
> So hibernation is broken on x86-64?
>
> Ideas for debugging:
>
> 1) get that sysrq to work, backtrace where it is hung would be very
> useful.
>
> 2) try v4.15.

That one works for me FWIW.

> 3) try without KPTI enabled. Probably noone knows how it interacts
> with that...
>
> (And 4), we should really start doing some periodic testing of hibernation).

I do that, but the period is not particularly short ...
