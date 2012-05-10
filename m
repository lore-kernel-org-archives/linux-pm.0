From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/2] ARM: DAVINCI: cpuidle - cleanups
Date: Thu, 10 May 2012 10:44:43 +0200
Message-ID: <1336639485-26955-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nsekhar@ti.com, khilman@ti.com, lenb@kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, linaro-dev@lists.linaro.org, linux-pm@lists.linux-foundation.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

These couple of patches use the new cpuidle core api to refactor
some part of the code. The first one removes the state count initialization
as it is done from the cpuidle core and the second one use the new
API and removes the ops.

The patchset is based on Lenb's tree on top of Robert Lee cpuidle consolidation
work.

I don't have this board, I was not able to test these patches.

Daniel Lezcano (2):
  ARM: DAVINCI: cpuidle - remove useless state count initialization
  ARM: DAVINCI: cpuidle - remove ops

 arch/arm/mach-davinci/cpuidle.c |   83 +++++++++++++--------------------------
 1 files changed, 27 insertions(+), 56 deletions(-)

-- 
1.7.5.4
