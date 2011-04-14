From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/2] Remove __weak definitions of platform
	PM callbacks
Date: Fri, 15 Apr 2011 01:16:01 +0200
Message-ID: <201104150116.01634.rjw__31587.7721565359$1302823593$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104130205.26988.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches are based on top of
https://patchwork.kernel.org/patch/702401/ .

[1/2] converts shmobile (both the ARM and SH flavors) to using a power domain
for overriding the platform bus type's PM callbacks, which makes it possible
to remove the __weak definitions of the runtime PM callbacks from platform.c,
which is done in [2/2].

Comments welcome.

Thanks,
Rafael
