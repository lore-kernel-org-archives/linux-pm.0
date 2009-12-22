From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: RFC: A proposal for power capping through forced
 idle in the Linux Kernel
Date: Tue, 22 Dec 2009 20:57:43 +0100
Message-ID: <20091222205743.4b6cf677__13.0754815929279$1261511848$gmane$org@infradead.org>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<20091214161922.6f252492@infradead.org>
	<1261511304.4937.116.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1261511304.4937.116.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Salman Qazi <sqazi@google.com>, Taliver@smtp1.linux-foundation.org, Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Heath <taliver@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 22 Dec 2009 20:48:24 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, 2009-12-14 at 16:19 -0800, Arjan van de Ven wrote:
> 
> > I like the general idea, I have one request (that I didn't see
> > quite in your explanation): Please make sure that all cpus in the
> > system do their idle injection at the same time, so that memory can
> > go into power saving mode as well during this time etc etc...
> 
> And then you're going to ask that it scales too, right? :-)
> 
> Gang-scheduling is inherently non scalable, be it for idle time or
> not.

well... there's many ways to do this... one option is to agree, ahead
of time, which jiffies values you're going to do the idle thing on.
Say every 100 jiffies where jiffies % 100 is 0....

then the scalability thing isn't a big deal.. and you still do it all
at the same time. Or at least "enough" at the same time for it to not
matter



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
