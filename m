From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] Hibernate cleanups
Date: Sat, 21 May 2011 14:08:28 +0200
Message-ID: <201105211408.28671.rjw__40774.2442483597$1305980023$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Frank Hofmann <frank.hofmann@tomtom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Following are three hibernate patches I didn't have the time to
work on before.

[1/3] - Update comments in kernel/power/hibernate.c
[2/3] - Remove arch_prepare_suspend()
[3/3] - Update kerneldoc comments in kernel/power/hibernate.c

Since they don't make any functional changes, I don't think it makes sense
to wait with them for the next merge window, so I'd like to push them
for 2.6.40 if no one objects.

Thanks,
Rafael
