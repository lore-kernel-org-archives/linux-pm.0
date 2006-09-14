From: Matthew Locke <matt@nomadgs.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Thu, 14 Sep 2006 02:47:44 -0700
Message-ID: <4259a021bf749468f0acdd3791b42465@nomadgs.com>
References: <20060913045405.BA7DD1A0084@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B6A3D9@de01exm64.ds.mot.com>
	<20060914091211.GA14874@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060914091211.GA14874@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org


On Sep 14, 2006, at 2:12 AM, Pavel Machek wrote:

> Hi!
>
>>>> Date: Mon, 11 Sep 2006 21:36:37 +0200
>>>> From: Pavel Machek <pavel@ucw.cz>
>>>>
>>>> Kernel interface is not something to be experimented with.
>>>
>>> Disagree.  How else to get it right??
>>> Try, learn, improve.  That's experimentation.
>>> Linux has no "stable API nonsense" ...
>>>
>>> The point of "cathedral vs. bazaar" was that experimentation
>>> and evolution are more successful processes than "get it
>>> right the first time".
>> ---
>>
>> I think Pavel's point was that the userspace interface to
>> the kernel (at least the syscall interface) is stable (open to
>> Extension by addition of syscalls, but closed to modification
>> or deletion of existing and that any experimentation needs to
>> happen before functionality goes into the mainstream.
>
> Yes, that was my point. (And I'd add "plus you can't get around that
> by introducing interface hidden by #ifdef").
>
>> That said, I do think we probably need to add a new interface to
>> cover operating points, because some of believe that policy needs
>> to be in user space and the whole point of the OP abstraction is
>> that operating points are atomic. You can't just add knobs to
>> control more factors, because all those knobs need to be turned
>> at the same time. Setting an operating point is inherently an
>> atomic operation, not n separate operations that can be taken
>> serially.
>
> Ok, "needs to be atomic" is first real argument for OP abstraction. I
> wonder if we can get around that by delaying the transaction until
> userspace tells us it made all the changes... otoh that is going to be
> messy.
>
> But do you have some reasonable way to integrate OP with cpufreq?

Yes, it was presented in the PowerOP/cpufreq integration patches.  The =

cpufreq_driver layer is the natural integration point.

>
> 								Pavel
> -- =

> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =

> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
