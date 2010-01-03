From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [suspend/resume] Re: userspace notification from
	module
Date: Sun, 3 Jan 2010 22:33:19 +0100
Message-ID: <201001032233.19599.rjw__38766.2775967785$1262554422$gmane$org@sisk.pl>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<65e5aef6.33251eb4.4b3fecf4.a2f99@o2.pl>
	<4B4063AB.7080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B4063AB.7080401@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Borkmann <danborkmann@googlemail.com>
Cc: =?iso-8859-2?q?Bart=B3omiej_Zimo=F1?= <uzi18@o2.pl>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Walls <awalls@radix.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 03 January 2010, Daniel Borkmann wrote:
...
> Actually I think this is what signals are there for and bringing this
> information via signals would have least overhead, problem is that this
> is not POSIX compliant, but may be you could have a try at this?!

You need information to be passed both ways.

Namely, a power manager (be it a kernel module or a user space process) has
to communicate to the (other) processes that it's about to suspend and it
should wait for each of them to say that it's now OK to suspend.

You could do that with signals, but I guess it's not the easiest way. :-)

Rafael
