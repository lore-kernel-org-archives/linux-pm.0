From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5 update] PCI / ACPI PM: Propagate wake-up
	enable upstream
Date: Tue, 8 Sep 2009 23:11:48 +0200
Message-ID: <200909082311.48366.rjw__40936.8038912818$1252444892$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909020041.57754.rjw@sisk.pl>
	<200909040002.02562.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909040002.02562.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ykzhao <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-pm@vger.kernel.org

Hi,

The patchset has been confirmed to fix the issue it was designed for (ie.
it allows an add-on PCI card to wake-up the system from S3 by enabling the
GPE of the bridge upstream to wake up), so I'd like to get it in as soon as
reasonably possible.

Please review.

Thanks,
Rafael
