From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [Q] APM depends on PM_SLEEP?
Date: Fri, 5 Oct 2007 16:18:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0710051615350.10392__22399.5295157239$1191593970$gmane$org@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Why does APM depend on PM_SLEEP? So without sleep support you cannot use 
"Make CPU Idle calls when idle ", "Use real mode APM BIOS call to power 
off" etc? Found in 23-rc9-git of yesterday.

Thanks
Guennadi
---
Guennadi Liakhovetski
