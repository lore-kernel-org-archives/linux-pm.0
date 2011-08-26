From: Jeff Ohlstein <johlstei@codeaurora.org>
Subject: Sysfs nodes deleted and recreated on SMP suspend
Date: Fri, 26 Aug 2011 13:08:58 -0700
Message-ID: <4E57FD5A.5080005__6573.85272575102$1314389793$gmane$org@codeaurora.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

So I have been working with the cpufreq sysfs nodes on an SMP system,
and one thing I noticed is that they go away each time I suspend and
resume. This is due to the use of the hotplug mechanism for suspend. I
am able to handle these failures by checking for the error and reopening
the file, but having to do this each time the system suspends seems
unnecessary to me.

Does anyone see any value in making these nodes stay around, at least in
the suspend case of hotplug? I understand that they should go away on
systems where a cpu can actually be physically removed, but if we are
just suspending it seems like we should be as transparent to userspace
as possible.

Jeff
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
