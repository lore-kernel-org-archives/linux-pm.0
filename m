From: Matt Helsley <matthltc@us.ibm.com>
Subject: [PATCH 0/6] Container Freezer: fixes for -mm
Date: Tue, 19 Aug 2008 16:22:32 -0700
Message-ID: <20080819232232.432973784__32676.4910402291$1219189094$gmane$org@us.ibm.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Paul Menage <menage@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Andrew,

	These patches stack on top of the series you already have for the
container freezer patches. I believe they address all of the comments from
you and Rafael so far. 

	Please consider these for -mm.

[PATCH 1/6] Container Freezer: Fix freezer Kconfig
[PATCH 2/6] Container Freezer: uninline thaw_process()
[PATCH 3/6] Container Freezer: Make freezer state names less generic
[PATCH 4/6] Container Freezer: Cleanup comment
[PATCH 5/6] Container Freezer: Rename check_if_frozen()
[PATCH 6/6] Container Freezer: Document the cgroup freezer subsystem

Cheers,
	-Matt Helsley

-- 
