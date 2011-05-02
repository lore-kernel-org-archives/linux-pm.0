From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [Q] error handling in runtime PM
Date: Mon, 2 May 2011 13:49:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105021339140.13244@axis700.grange>
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

Hi all

There are currently several functions similar to __pm_runtime_suspend() in 
runtime.c, working according to the same principle: they check if the 
RPM_GET_PUT flag is set, if so, they increment, or decrement-and-test the 
usage-count, then call the actual worker function, e.g., rpm_suspend(). 
This latter function can fail, then its return code will be passed back to 
the caller, but - the usage counter will not be restored. Is this a design 
decision or a bug?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
