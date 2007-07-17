From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 14:06:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707171404330.2467__20986.9192950011$1184707000$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
	<200707172217.01890.rjw@sisk.pl> <87odiag45q.fsf@jbms.ath.cx>
	<Pine.LNX.4.64.0707171335180.2467@asgard.lang.hm>
	<87bqeag369.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87bqeag369.fsf@jbms.ath.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Jul 2007, Jeremy Maitin-Shepard wrote:

> david@lang.hm writes:
>
> [snip]
>
>>>> * figure out which devices can wake up
>>>> * put devices into low power states (wake-up devices are placed in the Dx
>>>> states compatible with the wake capability, the others are powered off)
>
>> this can't be done by the image-saving kernel if that kernel doesn't know about
>> the device.
>
> The image-saving kernel can be made to know about all of the "wake up"
> devices; all other devices should have already been powered off by the
> "hibernated" kernel.

not nessasarily.

for example, you don't want the "hibernated" kernel to spin down your 
disks in the general case, but your image-writing kernel may not have 
drivers in it to talk to some of the disks. when things are powered 
off this just isn't an issue, but if you use S4 mode instead it is.

David Lang
