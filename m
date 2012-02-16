From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: Corrupted files after suspend to disk
Date: Fri, 17 Feb 2012 00:22:50 +0100
Message-ID: <CAFLxGvw1-mgHsM3oqqTJN=tXRPOddhtWt_vWgRTA2jwZMqnvaQ@mail.gmail.com>
References: <201202162251.47063.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1202161722310.1150-100000@iolanthe.rowland.org>
	<CAFLxGvwWBWTmv+uUH87UB3Ly31hjVU5kWpSyihGDKj6_8oc6WA@mail.gmail.com>
	<201202170016.14313.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201202170016.14313.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, esandeen@redhat.com
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 17, 2012 at 12:16 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, February 17, 2012, richard -rw- weinberger wrote:
>> On Thu, Feb 16, 2012 at 11:26 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Thu, 16 Feb 2012, Rafael J. Wysocki wrote:
>> >
>> >> > FWIW, we've been seeing a number of hard to diagnose failures
>> >> > with suspend to disk for the last few releases in Fedora.
>> >> > Eric Sandeen has been chasing https://bugzilla.redhat.com/show_bug.cgi?id=744275
>> >> > for a while, but there's no smoking gun that really explains what's
>> >> > getting into these states. Further complicating things, is that it
>> >> > doesn't seem to be 100% reproducable.
>> >>
>> >> I wonder if that's reproducible with the filesystems freezing patch I posted
>> >> some time ago (it will need some rebasing to apply to the current mainline or
>> >> 3.2.y).
>>
>> Where can I find this patch?
>> I'll happily test it.
>> But it may take some time as the bug is not easy to reproduce.
>
> This is the last version posted:
>
> http://marc.info/?l=linux-kernel&m=132775832509351&w=4
>
> However, it only may help if you use the kernel-based hibernation i.e.
> "echo disk > /sys/power/state" (that may be worth testing without the
> patch too, but Fedora is using this AFAICS, so it probably has that
> problem too).

Okay, I'll use kernel-based hibernation from now on.
If the problem still occurs I'll apply your patch.

Stay tuned!

-- 
Thanks,
//richard
