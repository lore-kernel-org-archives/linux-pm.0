From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 14:22:44 +0100
Message-ID: <20100528132244.GA25189__28823.1007093147$1275053044$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005280041.43553.rjw@sisk.pl>
	<20100528001514.28e593ef@lxorguk.ukuu.org.uk>
	<201005280205.01561.rjw@sisk.pl>
	<AANLkTik-8HtTVOh3toXBZZlXYgDTFtfkm6EDYRw-UPm4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik-8HtTVOh3toXBZZlXYgDTFtfkm6EDYRw-UPm4@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Chan <mike@android.com>
Cc: Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Arve@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 05:49:36PM -0700, Mike Chan wrote:

> Even if we used the proposed QoS replacement, are there suggestions on
> how to keep the cpu idle for longer than 2 seconds in Linux without
> using suspend?

I believe that the "Maximum idle time on 32-bit is 2 seconds" issue is 
solved in recent kernels.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
