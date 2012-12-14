From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2][V2] cpuidle - remove power from the select equation
Date: Fri, 14 Dec 2012 14:57:33 +0100
Message-ID: <1355493455-30665-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, g.trinabh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, snanda-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The states could be sorted in the power backward order, we get rid of
some lines of code and by this way that fixes also a bug in the dynamic
c-states.

Changelog:

V2:
 * added the optimization in the select menu governor

Daniel Lezcano (2):
  cpuidle - remove the power_specified field in the driver
  cpuidle - optimize the select function for the 'menu' governor

 drivers/cpuidle/cpuidle.c        |   17 ++++-------------
 drivers/cpuidle/driver.c         |   25 -------------------------
 drivers/cpuidle/governors/menu.c |   20 ++++++++------------
 include/linux/cpuidle.h          |    2 +-
 4 files changed, 13 insertions(+), 51 deletions(-)

-- 
1.7.5.4
