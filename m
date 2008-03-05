From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Wed, 5 Mar 2008 16:48:56 +0100
Message-ID: <20080305154856.GC553__2774.4029918269$1204732277$gmane$org@one.firstfloor.org>
References: <20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<20080304172918.GA27332@one.firstfloor.org>
	<20080304183032.17084e39@mjolnir.drzeus.cx>
	<20080304174315.GB27332@one.firstfloor.org>
	<20080304190446.775165e3@mjolnir.drzeus.cx>
	<20080304183406.GC27332@one.firstfloor.org>
	<20080305070454.3df78593@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080305070454.3df78593@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 05, 2008 at 07:04:54AM +0100, Pierre Ossman wrote:
> I still don't follow. Perhaps you can express it in pseudo code? If I have a stale value that I cannot refresh, knowing that it is stale doesn't change anything.

Start: You discovered at some point where you currently have code a variable 
is not updated yet.
Fact: You have some new code that runs before that point
Information: The variable is updated later eventually in the idle exit path.
Fact II: You require the variable to be updated in your new code
Possible solutions: 
(1) you move your new code in a point of the idle exit path after the variable 
is updated 
(2) you move the code that updates the variable earlier before your code
Solution: I described the first variant which is likely easier.
How: I told you where it is updated, so that shouldn't be too difficult. 
Action: Implement solution (1) or (2) 
Action: Test if it works
Check: If test succeeded exit 
Otherwise: Restart at Start

-Andi
