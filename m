From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC: A proposal for power capping through forced
	idle in the	Linux Kernel
Date: Mon, 21 Dec 2009 09:57:13 +0100
Message-ID: <20091221085713.GA1622__48914.1251463026$1261385908$gmane$org@ucw.cz>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman Qazi <sqazi@google.com>
Cc: linux-pm@lists.linux-foundation.org, Taliver Heath <taliver@google.com>, Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Google is implementing power capping, a technology that improves the
> power efficiency of data centers. There are also some interesting
> applications of this technology for laptops and cell phones.  Google
> aims to send most of its Linux technology upstream. So, how can we get
> this feature into the mainline kernel?
...
> Aside from this, every cgroup has a new quantity added to the CPU
> component called "Power Capping Priority".  This quantity indicates
> the order in which the scheduler attributes the time spent injecting
> idle cycles to specific processes.  This allows us to discriminate
> among processes when it comes to accounting for the injected idle
> time.  There is also an indication of interactivity versus batch for
> the cgroup provided in the CPU component of the cgroup.
> 
> Basic Algorithm:
> 
> Rather than blindly blasting the machine with the minimum required
> idle cycles, our implementation keeps track of naturally occurring
> idle cycles as follows:

(Rather complex algorithm snipped)

Well.. having all this complexity just for forcing idle... And it
still will not work, right? Linux kernel is not real time, so you
can't guarantee anything.

OTOH realtime people already have tools you could make good use of:
your power capping approach looks like 'high priority idle task that
needs to run for 2 seconds every 5 seconds' or something...

Talk to rt people?
								Pavel 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
