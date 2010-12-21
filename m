From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] ARM: Add initial hibernation support
 for Cortex A8 and A9
Date: Tue, 21 Dec 2010 20:51:06 +0100
Message-ID: <20101221195105.GA29126@elf.ucw.cz>
References: <1292910239-4313-1-git-send-email-myungjoo.ham@samsung.com>
	<AANLkTinFTAHzuEaLMn=xcevLCFvjga7RC6yztzC1fO5d@mail.gmail.com>
	<20101221145126.GU28157@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101221145126.GU28157@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: myungjoo.ham@gmail.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, Catalin Marinas <catalin.marinas@arm.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, kyungmin.park@samsung.com, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi!

> The same should be true of things like perf.
> 
> Things like the control register we already have the value cached, so
> there's little point saving another copy of it.
> 
> What we should also have is a callback into the proc-*.S files for
> them to save the processor specific registers such as the TTB registers.
> 
> And then, with non-secure mode, we run into issues about which registers
> we _can_ sanely read and write.
> 
> What I'm saying is that rather than copying stuff verbatim from the
> ARM ARM, _think_ first and see what is actually necessary.

Well, the patch is not exactly nice, but "simple and stupid" version
that just saves everything might be useful baseline for bisect
etc... and speed should not really be issue here.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
