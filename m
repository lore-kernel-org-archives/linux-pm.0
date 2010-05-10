From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 10 May 2010 11:06:15 -0700
Message-ID: <87632vhbs8.fsf__7422.8920777843$1273514982$gmane$org@deeprootsystems.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87wrvl5479.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Mon\, 03 May 2010 09\:40\:26 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hello,

I think many folks are still confused about exactly the problem being
solved by this series as well as mixed up between opportunistic
suspend and suspend blockers.  Also, how this series impatcs the rest
of the kernel (especially PM-aware drivers and subsystems) has caused
a bit of confusion.

To help with the confusion, I think a much clearer description of the
problem being solved and the proposed solution is needed.  

To that end, I created a starting point for that below which
summarizes how I understand the problem and the proposed solution, but
of course this should be filled out in more detail and updated as part
of the documentation that goes with this series.

Hope this helps improve the understanding of this feature,

Kevin



Table of Contents
=================
1 Problem Statement 
2 Solution: Opportunistic suspend 
    2.1 When to use a suspend blocker 
    2.2 Usage in PM aware drivers 


1 Problem Statement 
~~~~~~~~~~~~~~~~~~~~

Want to to hit deep power state, even when the system is not actually
idle.

Why?

- some hardware is not capable of deep power states in idle
- difficulty getting userspace and/or kernel to be idle

2 Solution: Opportunistic suspend 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create an additional "idle path" which has new rules for determining
idleness.  When this new "idle" is reached, trigger full-system
suspend.  Since a suspend is triggered whenever the opportunity
arises, this is called opportunistic suspend.

The new rules for making the idleness decision are simple:

1.  system may suspend if and only if no suspend blockers are held

2.1 When to use a suspend blocker 
==================================

[A list of reasons why suspend blockers might be used would be very
 helpful here.] 

- ensure wakeup events propagate to userspace (e.g. keypad example in doc)

- screen is on

- someone mentioned "Google use cases"
  (would be nice to hear about more of these)

2.2 Usage in PM aware drivers 
==============================

[An example of how a driver already using runtime PM would use 
 a suspend blocker would also be helpful.
