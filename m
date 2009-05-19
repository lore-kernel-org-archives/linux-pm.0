From: Surinder P Singh <srplsnh@gmail.com>
Subject: cpuidle C-state accounting
Date: Tue, 19 May 2009 09:25:04 -0700
Message-ID: <20090519162504.GA26660@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I have a question about cpuidle C-state accounting in
cpuidle_idle_call() as implemented in kernel v2.6.29.

I understand it is possible for the target state entering callback to
return 0, if for some reason it could not enter the requested C-state
as decided by the governor. In this case, shouldn't the usage count be
updated conditionally to reflect the fact that the state may or may
not actually have been entered ? essentially, something like this:

--- cpuidle.c   2009-03-24 04:42:14.000000000 +0530
+++ cpuidle_modified.c  2009-05-19 11:39:58.000000000 +0530
@@ -86,7 +86,8 @@
                target_state = dev->last_state;

        target_state->time += (unsigned long long)dev->last_residency;
-       target_state->usage++;
+       if (dev->last_residency)
+               target_state->usage++;

        /* give the governor an opportunity to reflect on the outcome */
        if (cpuidle_curr_governor->reflect)


Cheers,
surinder
