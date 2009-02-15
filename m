From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PM: x86-64 suspend-resume fix
Date: Sun, 15 Feb 2009 22:44:46 +0100
Message-ID: <200902152244.47326.rjw__2108.29157517782$1234734644$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Jiri Slaby <jirislaby@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Cyrill Gorcunov <gorcunov@openvz.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches clean-up and fix the x86-64 resume code.

1/2 is a cleanup, but it is simple enough to be applied now IMO.

2/2 is a bug fix based on 1/2, which is 2.6.29 material.

Please apply them to the suspend branch and push to Linus for 2.6.29 (Ingo
says he doesn't mind if they go through your tree).

Thanks,
Rafael
