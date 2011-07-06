From: asinghal@codeaurora.org
Subject: [RFC] Unprepare callback for cpuidle_device
Date: Wed, 6 Jul 2011 13:23:48 -0700 (PDT)
Message-ID: <a619d8bbefd2f390a13d09084583dd39.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: johlstei@codeaurora.org
List-Id: linux-pm@vger.kernel.org

We plan to use high resolution timers in one of our modules, with the
requirement that we cancel these timers when the cpu goes idle and restart
them when the cpu comes out of idle.

We are cancelling the timers in cpuidle prepare callback. The problem is
that if the need_resched() call in drivers/cpuidle/cpuidle.c returns true,
how do we restart the timer? If the call returns false, we can restart the
timer in the cpuidle enter callback.

The solution to the problem that we have in mind is adding an unprepare
callback to the cpuidle_device struct, and calling it if needs_resched()
returns true. Another option is to implement deferred timers for hrtimers.
Which of the two options is the better solution, or is there another
feasible alternative?

sincerely,
Amar Singhal
