From: Florian Mickler <florian@mickler.org>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 22:37:08 +0200
Message-ID: <20100605223708.7d8ff451__38022.7868598469$1275770378$gmane$org@schatten.dmk.lab>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org>
	<20100603234634.GA21831@elte.hu>
	<alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H.
	Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Felipe@smtp1.linux-foundation.org, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Jun 2010 19:16:55 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The thing is, unless there is some _really_ deep other reason to do 
> something like this, I still think it's total overdesign to push any 
> knowledge/choices like this into the scheduler. I'd rather keep things way 
> more independent, less tied to each other and to deep kernel subsystems.
> 
> IOW, my personal opinion is that somethng like a suspend (blocker or not) 
> decision simply shouldn't be important enough to be tied into the 
> scheduler. Especially not if it could just be its own layer.
> 
> That said, as far as I know, the Android people have mostly been looking 
> at the suspend angle from a single-core standpoint. And I'm not at all 
> convinced that they should hijack the existing "/sys/power/state" thing 
> which is what I think they do now.
> 
> And those two things go together. The /sys/power/state thing is a global 
> suspend - which I don't think is appropriate for a opportunistic thing in 
> the first place, especially for multi-core.
> 

This sounds right. 

If there is soo much need for a better solution, it will emerge. With
merged suspend blockers or not.

Just my 2 cents.

> 			Linus

Cheers,
Flo
