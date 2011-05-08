From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/5] PM: Support for generic I/O power
	domains (v2)
Date: Sun, 8 May 2011 23:20:56 +0200
Message-ID: <201105082320.57185.rjw__4033.68189367956$1304890094$gmane$org@sisk.pl>
References: <201104290154.12966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104290154.12966.rjw@sisk.pl>
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

On Friday, April 29, 2011, Rafael J. Wysocki wrote:
Hi,

This is an update of the patchset adding support for generic I/O power domains.
The first patch and the last two patches have been posted already and
discussed, the remaining two are new.
 
The patches are on top of the branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git power-domains

[1/5] - Add support for generic I/O power domains (runtime PM).
[2/5] - Introduce generic prepare and complete callbacks for system-wide
        power transitions.
[3/5] - Add PM sleep support to the generic I/O power domains code introduced
        in [1/5]
[4/5] - Use the new code to add support for I/O power domains on the SH7372 SoC.
[5/5] - Add support for power domain A4MP on SH7372.

Please let me know what you think.

Thanks,
Rafael
