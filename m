From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] ACPI / ACPICA: Fix problems related to GPE
	reference counting
Date: Tue, 8 Jun 2010 10:46:48 +0200
Message-ID: <201006081046.48488.rjw__35010.5455298491$1275987799$gmane$org@sisk.pl>
References: <201006080024.46142.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006080024.46142.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I decided to split this big patch into a series of smaller ones addressing one
issue each.  I think all of the issues addressed by [2-5/5] may be regarded as
regressions from 2.6.33, because that kernel didn't have these problems.

[1/5] - Not really a fix, but [2/5] depends on it and I don't see a reason to
        duplicate that thing even more.
[2/5] - Low-level GPE manipulation fix
[3/5] - Fix possible issue with re-enabling a GPE after event handling
[4/5] - Fix the initialization of GPEs
[5/5] - Fix GPE sysfs interface

Please review, possibly apply.

Thanks,
Rafael
