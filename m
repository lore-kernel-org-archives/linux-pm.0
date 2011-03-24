From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [Bug 31432] Resume from suspend fails on new
 FireWire stack (TSB43AB22/A IEEE-1394a-2000 Controller)
Date: Thu, 24 Mar 2011 21:42:37 +0100
Message-ID: <20110324214237.7cd4a0cf__18829.719318501$1300999539$gmane$org@stein>
References: <bug-31432-35532@https.bugzilla.kernel.org/>
	<201103210659.p2L6xXQi019212@demeter2.kernel.org>
	<AANLkTimvEUdz+nTY80dTCSEPv5vGYiPKcGoxxkrm0OS9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimvEUdz+nTY80dTCSEPv5vGYiPKcGoxxkrm0OS9@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux1394-devel@lists.sourceforge.net
Cc: linux-pm@lists.linux-foundation.org, bugzilla-daemon@bugzilla.kernel.org, =?UTF-8?B?SmHFoWE=?= Bartelj <jasa.bartelj@gmail.com>
List-Id: linux-pm@vger.kernel.org

To keep the mailinglists in the loop:

This appears to be a hardware defect.  IRQ event logging switched on before
suspend reveals an endless storm of bus reset events which hints to a
damaged PHY.  https://bugzilla.kernel.org/show_bug.cgi?id=31432#c5
-- 
Stefan Richter
-=====-==-== --== ==---
http://arcgraph.de/sr/
