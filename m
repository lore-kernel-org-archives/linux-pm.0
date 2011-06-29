From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/6 v2] PM: Fix up interactions between system
	suspend/resume and runtime PM
Date: Wed, 29 Jun 2011 23:29:03 +0200
Message-ID: <201106292329.04163.rjw__20377.2964924157$1309383473$gmane$org@sisk.pl>
References: <201106260054.20578.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106260054.20578.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The majority of the patches in the series have been updated and I prepared
two documentation-only patches that are related to this series (posted
previously) and a PCI patch that I thought would be needed for 3.0, but is
only relevant along with [4/6].

On Sunday, June 26, 2011, Rafael J. Wysocki wrote:
> Hi,
> 
> The patches in this series are related to the interactions between system
> suspend/resume and the I/O runtime PM framework.  We've had quite some
> confusion and uncertainty in that area recently, so I'd like to clean it
> up once and for all, so that everyone knows what the rules are and why
> they are what they are.
 
[1/6] - Update documentation describing interactions between runtime PM and
        system suspend/resume.

[2/6] - Return special error code from runtime PM helers if runtime PM is
        disabled and make the SCSI error handling code take it into account.

[3/6] - Add early wakeup events detection to the PCI bus type.

[4/6] - Limit race conditions between runtime PM and system suspend/resume.

[5/6] - Fix descriptions of pm_runtime_enable/disable() and add a description
        of pm_runtime_barrier() to the runtime PM documentation.

[6/6] - Replace "run-time" with "runtime" everywhere in the runtime PM
        documentation and kerneldoc comments.

The patches are on top of the PM domains patchset I've just posted, which is
available from the git branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains

They are regarded as 3.1 material.

Thanks,
Rafael
