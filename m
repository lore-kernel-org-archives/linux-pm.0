From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/6][resend] removing unused fields in the
	structure
Date: Thu, 17 Nov 2011 11:26:34 +0100
Message-ID: <1321525600-2466-1-git-send-email-daniel.lezcano__27987.6873865307$1321526074$gmane$org@linaro.org>
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
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org
List-Id: linux-pm@vger.kernel.org

 This patchset applies on the 'next' branch of the linux-lenb git tree.

resend : Cc'ed linux-pm mailing list also

Daniel Lezcano (6):
  cpuidle : move code to prevent forward declaration
  cpuidle : remove unused 'governor_data' field
  acpi : remove 'latency_ticks' in acpi_processor_cx
  acpi : remove 'time' field in acpi_processor_cx
  acpi : remove 'usage' field in acpi_processor_cx
  acpi : remove 'power' field from acpi_processor_cx

 drivers/acpi/processor_idle.c |   11 ----
 drivers/cpuidle/cpuidle.c     |  116 ++++++++++++++++++++---------------------
 include/acpi/processor.h      |    4 --
 include/linux/cpuidle.h       |    1 -
 4 files changed, 57 insertions(+), 75 deletions(-)

-- 
1.7.4.1
