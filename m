From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 15:41:30 -0800
Message-ID: <20090216154130.3ecf4050__46108.4859482527$1234827865$gmane$org@infradead.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902170019.40599.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kyle Moffett <kyle@moffetthome.net>, Oliver@smtp1.linux-foundation.org, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, mark@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Feb 2009 00:19:38 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > In addition, in hardware there does seem to be the trend where idle
> > and suspend are converging (just look at the OLPC)...   with
> > chipsets powering down all unused pieces, and cpus in idle taking
> > basically no power, there no longer is much of a difference in
> > reality between suspend and good-idle...
> 
> This, again, seems to be a bit x86-centric. :-)  

actually absolutely not. To the contrary. It is, as you said, the
embedded systems that have, and increasingly get, finer grained per
device controls. (x86 embedded and otherwise). The more fine grained
control you have, the less a system wide state will give you in
additional power savings. This is pretty much the industry trend for
all power sensitive systems.

Android might be using last years hardware. I'm not saying we shouldn't
support that, but we need to be careful to not design the system only
looking backwards.



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
