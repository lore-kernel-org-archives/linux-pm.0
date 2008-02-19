From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: APM depends on PM_SLEEP?
Date: Tue, 19 Feb 2008 12:11:15 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802191209260.5385@axis700.grange>
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
List-Id: linux-pm@vger.kernel.org

Hi

Could anyone explain me why APM depends on PM_SLEEP? Isn't it a valid 
configuration, when I don't want to sleep / suspend, but need APM to, say, 
turn my machine off using APM_REAL_MODE_POWER_OFF, or if I need 
APM_DISPLAY_BLANK?

Thanks
Guennadi
---
Guennadi Liakhovetski
