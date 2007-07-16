From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 23:49:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707152342140.19248@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707151918340.30402-100000@netrider.rowland.org>
	<200707160802.46567.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707160802.46567.a1426z@gawab.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Jul 2007, Al Boldi wrote:

>
> david@lang.hm wrote:
>> suspend-to-RAM should not involve kexec, the only reason for doing the
>> kexec to to get a seperate userspace to use for suspend-to-disk operations
>> instead of trying to partially freeze the sustem and keep useing it.
>
> Or you could do suspend-to-disk-and-RAM.  But in the above case, it was meant
> to test kexec compatibility with device suspend/resume calls.

the point I am trying to make here is that there is no reason that the 
kexec approach needs to do _any_ suspend/resume calls.

all that is needed is the ability of the new kernel to initialize the 
devices it needs.

suspend-to-disk-and-ram could be implemented as three 
seperate steps

1. suspend-to-disk

2. resume-from-disk

3. suspend-to-ram

followed by either

4. resume-from-ram

or

4. battery dies and loptop powers off completely

5. power-on boot.

6. resume-from-disk

all that you need to do is to make sure that the system doesn't run 
anything that would affect permanent media or the outside world between 
steps #2 and #3

yes it's more steps, but each step is logicly seperate, and each step will 
be excercised on a regular basis, so the combination of the steps will 
also be reliable.

this is far better then creating yet another way to pause the system that 
only a few people will use.

David Lang
