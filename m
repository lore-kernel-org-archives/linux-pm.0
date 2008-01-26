From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Q: x86 suspend/hibernation code consolidation
Date: Sat, 26 Jan 2008 01:32:08 +0100
Message-ID: <200801260132.09529.rjw__37943.9698918306$1201307827$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
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
To: Ingo Molnar <mingo@elte.hu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I'd like to move the 64-bit suspend/hibernation files from arch/x86/kernel to
arch/x86/power, modify the names of the 32-bit files already in
arch/x86/power and update the Makefiles accordingly, but there are some changes
queued for merging that touch the files in question.

When is the right time for making changes like that?

Rafael
