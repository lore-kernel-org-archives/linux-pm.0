From: Brad Campbell <brad@fnarfbargle.com>
Subject: Re: Linux 3.0-rc4 intermittent failure to resume
Date: Wed, 29 Jun 2011 13:34:16 +0800
Message-ID: <4E0AB958.8020704@fnarfbargle.com>
References: <4E0286F3.6030003@wasp.net.au>
	<201106231402.59491.rjw@sisk.pl>	<4E03F95B.9030101@fnarfbargle.com>
	<4E093ECD.7040600@fnarfbargle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E093ECD.7040600@fnarfbargle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 28/06/11 10:39, Brad Campbell wrote:
> On 24/06/11 10:41, Brad Campbell wrote:
>> On 23/06/11 20:02, Rafael J. Wysocki wrote:
>>> On Thursday, June 23, 2011, Brad Campbell wrote:
>>>> G'day all,
>>>>
>>>> I've recently moved from tuxonice to mainline uswsusp. I'm getting intermittent failure to resume
>>>> problems. No message in dmesg that I can find, it just boots clean. Is there something I can do to
>>>> get some debug info on this? It's really, really annoying.
>>>>
>>>> About 75% of the time it works perfectly, and I can find no rhyme or reason to why it suddenly just
>>>> decides to ignore the saved state.
>>>>
>>>> 32 bit userspace with a statically linked 64 bit s2disk, s2both&    resume. 64 bit kernel.
>>> Do you use the i915 driver?
>>>
>> Indeed I do.
> Just a follow up to this.
> It looks like adding "early writeout = y" to my /etc/suspend.conf has worked around the problem.
>

Ok, so after _lots_ of investigating it was not early writeout. The 
culprit was/is the Ubuntu initramfs scripts.

On the occasions it failed to resume (which were many) it turns out 
/bin/resume was being called prior to udev having created /dev/snapshot.

I put a simple wait loop in the resume script to wait for the creation 
of /dev/snapshot and I've not had a fail to resume since.

Curse you asynchronous dynamic device creation <shakes fist>

Regards,
Brad
