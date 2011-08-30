From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] PM: Generic PM domains and device PM QoS
Date: Wed, 31 Aug 2011 00:17:02 +0200
Message-ID: <201108310017.03103.rjw__28111.004891298$1314846980$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset illustrates how device PM QoS may be used along with
PM domains in my view.

Actually, it consists of two parts.  Namely, patches [1-3/5] seem to be
suitable for 3.2, unless somebody hates them, but patches [4-5/5] are
total RFC.  They haven't been tested, only compiled, so the use of them
is not encouraged (they may kill your dog or make your cat go wild, or
do something equally nasty, so beware).  Their purpose is to illustrate
an idea that I'd like to discuss at the PM miniconference during the
LPC.

[1/5] - Split device PM domain data into a "base" and additional fields
        (one need_restore field at the moment, but the subsequent patches
        add more fields).

[2/5] - Make runtime PM always release power.lock if power.irq_safe is set.

[3/5] - Add function for reading device PM QoS values safely.

[4/5] - Add governor function for stopping devices.

[5/5] - Add generic PM domain power off governor function.

Thanks,
Rafael
