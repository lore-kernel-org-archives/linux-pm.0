From: Andreas Mohr <andi@lisas.de>
Subject: Re: [RFT] Input: speed up suspend/shutdown for PS/2 mice
	and	keyboards
Date: Sun, 27 Dec 2009 15:20:21 +0100
Message-ID: <20091227142021.GA30090__35009.2885703363$1261923680$gmane$org@rhlx01.hs-esslingen.de>
References: <20091221070951.GA4170@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091221070951.GA4170@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On an ATI SB600 (RS690), no problems either on mouse/kbd after a S2R cycle,
on current git with this patch applied (verified).
And this with a rather problematic "new-fangled, designer (tm)"
Logitech Wireless Keyboard M/N Y-RR54 , P/N 867512-0102 (plus mouse!),
plugged into PS/2 connectors!

Thanks for your work!

Andreas Mohr
