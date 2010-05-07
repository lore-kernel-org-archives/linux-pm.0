From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC,5/7] NUMA hotplug emulator
Date: Fri, 7 May 2010 16:11:42 +0200
Message-ID: <20100507141142.GA8696__14593.7979141765$1274012439$gmane$org@ucw.cz>
References: <20100513115625.GF2169@shaohui>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100513115625.GF2169@shaohui>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: akpm@linux-foundation.org, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> hotplug emulator: Abstract cpu register functions
> 
> Abstract function arch_register_cpu and register_cpu, move the implementation
> details to a sub function with prefix "__". 
> 
> each of the sub function has an extra parameter nid, it can be used to register
> CPU under a fake NUMA node, it is a reserved interface for cpu hotplug emulation
> (CPU PROBE/RELEASE) in x86.

I don't get it. CPU hotplug can already be tested using echo 0/1 >
online, and that works on 386. How is this different?

It seems to add some numa magic. Why is it important?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
