From: Colin Cross <ccross@android.com>
Subject: Re: cpuidle future and improvements
Date: Mon, 18 Jun 2012 11:15:30 -0700
Message-ID: <CAMbhsRQRFXcayyWjM1RirgFppVAK23z2+3EbYOCw-qmzuY9_2g@mail.gmail.com>
References: <4FDEE98D.7010802@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FDEE98D.7010802@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, Rob Lee <rob.lee@linaro.org>, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 18, 2012 at 1:40 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> I propose to host a cpuidle-next tree where all these modifications will
> be and where people can send patches against, preventing last minutes
> conflicts and perhaps Lenb will agree to pull from this tree. In the
> meantime, the tree will be part of the linux-next, the patches will be
> more widely tested and could be fixed earlier.

My coupled cpuidle patches were acked and temporarily in Len's
next/Linus pull branch, but were later dropped when the first pull
request to Linus was rejected.  I asked Len to either put the coupled
cpuidle patches into his next branch, or let me host them so people
could base SoC branches off of them and let Len pull them later, but
got no response.  If you do start a cpuidle for-next branch, can you
pull my coupled-cpuidle branch:

The following changes since commit 76e10d158efb6d4516018846f60c2ab5501900bc:

  Linux 3.4 (2012-05-20 15:29:13 -0700)

are available in the git repository at:
  https://android.googlesource.com/kernel/common.git coupled-cpuidle

Colin Cross (4):
      cpuidle: refactor out cpuidle_enter_state
      cpuidle: fix error handling in __cpuidle_register_device
      cpuidle: add support for states that affect multiple cpus
      cpuidle: coupled: add parallel barrier function

 drivers/cpuidle/Kconfig   |    3 +
 drivers/cpuidle/Makefile  |    1 +
 drivers/cpuidle/coupled.c |  715 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle.c |   68 ++++-
 drivers/cpuidle/cpuidle.h |   32 ++
 include/linux/cpuidle.h   |   11 +
 6 files changed, 813 insertions(+), 17 deletions(-)
 create mode 100644 drivers/cpuidle/coupled.c
