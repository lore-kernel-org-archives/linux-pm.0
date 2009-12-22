From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: RFC: A proposal for power capping through forced
 idle in the Linux Kernel
Date: Tue, 22 Dec 2009 20:48:24 +0100
Message-ID: <1261511304.4937.116.camel__10067.3349843875$1261511480$gmane$org@laptop>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<20091214161922.6f252492@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091214161922.6f252492@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Salman Qazi <sqazi@google.com>, Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Taliver Heath <taliver@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-12-14 at 16:19 -0800, Arjan van de Ven wrote:

> I like the general idea, I have one request (that I didn't see quite in
> your explanation): Please make sure that all cpus in the system do
> their idle injection at the same time, so that memory can go into power
> saving mode as well during this time etc etc...

And then you're going to ask that it scales too, right? :-)

Gang-scheduling is inherently non scalable, be it for idle time or not.
