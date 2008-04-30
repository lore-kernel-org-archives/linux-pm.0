From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [RFC][PATCH 5/5] Add a Signal Control Group Subsystem
Date: Wed, 30 Apr 2008 00:48:34 -0700
Message-ID: <1209541714.6095.72.camel__37094.6590592668$1209541883$gmane$org@localhost.localdomain>
References: <20080424064756.643890130@us.ibm.com>
	<20080424064758.113999091@us.ibm.com>
	<20080424143032.7e659522.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080424143032.7e659522.pj@sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Jackson <pj@sgi.com>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, clg@fr.ibm.com, menage@google.com, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Thu, 2008-04-24 at 14:30 -0500, Paul Jackson wrote:
> > +static struct cftype kill_file = {
> > +	.name = "kill",
> 
> The name "kill" seems ambiguous to me.  It suggests that any write
> will send some default signal (TERM or KILL?) to all tasks in the
> cgroup, rather like the 'killall' command.
> 
> I'm guessing that more people, on seeing this file in a cgroup
> directory, will guess correctly what it does if it were named
> "signal" or "send_signal" or some such.

OK, I renamed it signal.send and replaced all uses of "kill" in the code
to indicate that we're actually sending a signal -- not "KILL"ing
things :).

Cheers,
	-Matt
