From: jimmy bahuleyan <knight.camelot@gmail.com>
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 21:05:21 +0530
Message-ID: <469A3EB9.8000304__40859.4104381793$1184513786$gmane$org@gmail.com>
References: <200707151433.34625.rjw@sisk.pl>
	<200707151810.33554.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707151810.33554.a1426z@gawab.com>
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
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Al Boldi wrote:
> 
> This should be the responsibility of the kexec'd hibernating kernel.  Note 
> though in (6), the normal kernel takes care of preparing devices, then the 
> hibernating kernel dumps the image and either calls S4 or S3.  On resume 
> from S3 it can immediately switch over to the normal kernel, and from S4 the 
> known bootup would occur.
> 
>> (8) Hibernation and restore should not be too slow
>>
>>     In my opinion, if more than one minute is needed to hibernate the
>> system with the help of certain hibernation framework, then this framework
>> is not very useful in practice.  It might be useful to perform some
>> special tasks (eg. moving a server to another place without taking it
>> down), but it is not very useful, for example, to notebook users.
> 
> The latest hibernating kexec patches boot a kexec'd modular kernel with 
> initramfs into crashkernel=16M@16M in less than one second.  Switch-back is 
> almost instant.  Add to this the time required to either store or restore 
> the image, and it may be obvious that this approach isn't slower, but maybe 
> even faster than the current swsusp.
> 

What about (9)? Would it be that a user choosing to build a kernel with
hibernate support gets a additional modular kernel built (which he
should then use for resumption) or he should configure & build the
modular kernel independent of main kernel?

Or will the Linux boot procedure change so that it always goes thru a
modular part followed by kexec (just to be uniform)?

Although the kexec approach seems interesting, the final user-scenario
seems a bit complex (or confusing).

-jb
-- 
Tact is the art of making a point without making an enemy.
