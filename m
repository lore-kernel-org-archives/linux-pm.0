From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] PM: disable nonboot cpus before
 suspending devices
Date: Mon, 1 Feb 2010 15:41:49 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1002011527580.5334__21966.4815850139$1265035417$gmane$org@localhost>
References: <alpine.LFD.2.00.1001221841490.2266@localhost>
	<201001222148.23945.rjw@sisk.pl>
	<alpine.LFD.2.00.1001251601440.2100@localhost>
	<201001252237.42545.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001252237.42545.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

since you didn't like the idea of calling the driver callbacks with just
one cpu enabled, we gave your patch: "MM / PM: Force GFP_NOIO during
suspend/hibernation and resume" a try and i can confirm that this
fixes the issue on s390. Will this go in 2.6.33/stable?

greetings,
Sebastian
