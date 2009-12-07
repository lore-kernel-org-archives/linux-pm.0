From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 22:37:20 -0800
Message-ID: <20091206223720.77cc8d80__43392.7666781985$1260167776$gmane$org@infradead.org>
References: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
	<1260158279.27069.181.camel@rzhang1-desktop>
	<alpine.LFD.2.00.0912062122460.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912062122460.3560@localhost.localdomain>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Dec 2009 21:57:55 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> Now, the problem remains that when you walk the device tree starting
> off all these potentially asynchronous events, you don't want to do
> that serialization part (the "parent suspend") as you walk the tree -
> because then you would only ever do one single level asynchronously.
> Which is why I suggested splitting the suspend into a "pre-suspend"
> phase (and a "post-resume" one). Because then the tree walk goes from

> I dunno. Maybe I'm overlooking something, but the above is much
> closer to what I think would be worth doing.

with what you're describing I suspect the current async function calls
could be used;
in the first tree walk, the drivers do an async_schedule() of the
things they want done asynchronous;
all the core then needs to do is a full synchronization step between the
two tree walks... and we get pretty much all the benefits without
needing the read-then-write-lock primitive for synchronization.

alternative would be to do the synchronization in the part where we
know there's a dependency (like your lock is doing); 
but instead of a lock we could store the async cookie there; and just
wait on that in the 2nd phase....  this would be more finegrained, and
an optimization from the "global synchronize"... but I'm not sure it'll
be worth it in practice; it will if there's significant cost in various
parts of the tree AND in the 2nd run; if the 2nd run is cheap in
general, you're not going to get real extra parallelism at the price of
more complexity.
-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
