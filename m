From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] PM: Support for generic I/O power domains
	(v4)
Date: Sat, 28 May 2011 01:15:14 +0200
Message-ID: <201105280115.14556.rjw__41326.9206103452$1306542318$gmane$org@sisk.pl>
References: <201104290154.12966.rjw@sisk.pl> <201105082320.57185.rjw@sisk.pl>
	<201105160117.46927.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105160117.46927.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

Hi,

This is the third update of the patchset adding support for generic I/O power
domains. All patches were posted previously, but I needed to rebase shmobile
patches on top of the current mainline kernel.

>From my perspective, the patches are ready for merging and I'm going put
patches [1-4/5] into my power-domains branch for 2.6.41 (or whatever it turns
out to be) after 2.6.40-rc1 (or whatever it is going to be called) is out.
Patch [5/5] is optional.

The entire patchset has been tested with an ARM shmobile Mackerel board.

[1/5] - Support for generic I/O power domains (runtime PM part).
[2/5] - Support for generic I/O power domains (system sleep part).
[3/5] - Implementation of generic I/O power domains support for SH7372.
[4/5] - [RFC] Support of multiple power domain states.
[5/5] - Introduction of SH7372's A4MP power domain.

Thanks,
Rafael
