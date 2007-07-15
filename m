From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 16:58:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707151654420.25614__43822.3339886919$1184544636$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707151918340.30402-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707151918340.30402-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Jul 2007, Alan Stern wrote:

> On Sun, 15 Jul 2007, Al Boldi wrote:
>
>> Alan Stern wrote:
>>> On Sun, 15 Jul 2007, Al Boldi wrote:
>
>>>> This should be the responsibility of the kexec'd hibernating kernel.
>>>> Note though in (6), the normal kernel takes care of preparing devices,
>>>> then the hibernating kernel dumps the image and either calls S4 or S3.
>>>> On resume from S3 it can immediately switch over to the normal kernel,
>>>> and from S4 the known bootup would occur.
>>>
>>> Is it really that simple?  Somehow I doubt it.  In order for some
>>> devices to remain available for the kexec'd kernel to use, they cannot
>>> be suspended at the ACPI level.  So the kexec'd kernel will have to
>>> handle the ACPI requirements for those devices.  Likewise, it would
>>> have to handle the ACPI interactions which need to be done after all
>>> devices are prepared for the transition to S3 or S4.
>>
>> Ok, after applying the latest kexec patches, I was able to use the kexec'd
>> kernel to suspend to ram and resume to the normal kernel, while working
>> under a full-blown X session.  It went without a hitch.  All that is needed
>> now are the dump/restore hibernation-image routines.
>
> That's exactly my point.  While doing suspend-to-RAM from a kexec'd
> kernel may be simple, saving the hibernation image will add
> complications.

suspend-to-RAM should not involve kexec, the only reason for doing the 
kexec to to get a seperate userspace to use for suspend-to-disk operations 
instead of trying to partially freeze the sustem and keep useing it.

David Lang
