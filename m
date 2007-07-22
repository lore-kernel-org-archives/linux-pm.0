From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Power Management framework proposal
Date: Sun, 22 Jul 2007 10:26:28 -0700
Message-ID: <1185125189.2714.13.camel__34638.6722442277$1185125346$gmane$org@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2007-07-21 at 23:49 -0700, david@lang.hm wrote:

> this approach would allow the transition of ALL drivers to the new mode of 
> operation in one fell swoop, and then adding additional power management 
> features is just adding to the existing list rather then implementing new 
> functions.


I have a concern with this approach though. It seems to assume that
there is one global thing somewhere that sets the system state; in my
experience that is the wrong approach; in fact there is a very definite
evidence that there are many decisions on power that are to be made
local at a high frequency. An example of this is the processor speed;
the ondemand governer does exactly this for the cpus that can switch
speeds fast; it's just impossible to beat such a local, fast decision
with anything on a global scale.

On the other hand, some things (the high level goals and constraints)
are obviously global.

However, your design seems to want to put the low level settings in a
global thing, and that is just a mistake.
