From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: Corrupted files after suspend to disk
Date: Fri, 17 Feb 2012 00:07:43 +0100
Message-ID: <CAFLxGvwWBWTmv+uUH87UB3Ly31hjVU5kWpSyihGDKj6_8oc6WA@mail.gmail.com>
References: <201202162251.47063.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1202161722310.1150-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1202161722310.1150-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, esandeen@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 16, 2012 at 11:26 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 16 Feb 2012, Rafael J. Wysocki wrote:
>
>> > FWIW, we've been seeing a number of hard to diagnose failures
>> > with suspend to disk for the last few releases in Fedora.
>> > Eric Sandeen has been chasing https://bugzilla.redhat.com/show_bug.cgi?id=744275
>> > for a while, but there's no smoking gun that really explains what's
>> > getting into these states. Further complicating things, is that it
>> > doesn't seem to be 100% reproducable.
>>
>> I wonder if that's reproducible with the filesystems freezing patch I posted
>> some time ago (it will need some rebasing to apply to the current mainline or
>> 3.2.y).

Where can I find this patch?
I'll happily test it.
But it may take some time as the bug is not easy to reproduce.

>> I also thing that this problem discovered by Alan Stern may be involved:
>>
>> http://marc.info/?l=linux-pm&m=132940331030253&w=4
>
> Probably not, unless the filesystems in question are on a USB drive.

The filesystems are no on a USB device.

-- 
Thanks,
//richard
