From: Surinder P Singh <srplsnh@gmail.com>
Subject: cpuidle C-state accounting
Date: Wed, 20 May 2009 14:46:24 +0530
Message-ID: <f2235a630905200216g51d2a6f6w18fdfde1f5bfbd09@mail.gmail.com>
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
List-Id: linux-pm@vger.kernel.org

> But there are state aborts.  In those cases residency is low or 0.

Indeed, its the residency=0 cases that the patch I sent in my last
mail attempts to fix. The idea being, not to increment
target_state->usage if dev->last_residency was 0, i.e. the state
(whether it was the governor recommended state or  safe_state or any
other state) was  not entered or used.

Cheers,
surinder
