From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 03 Jun 2010 10:14:01 +0200
Message-ID: <1275552841.27810.34984.camel__41037.6543215991$1275552971$gmane$org@twins>
References: <Pine.LNX.4.44L0.1005271141410.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271751240.3032@localhost.localdomain>
	<20100603042403.GC20028@linux-sh.org>
	<AANLkTinxP73uOG4XtnTtS1LZnWDvvgpAFN5Uv_xdKEwk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinxP73uOG4XtnTtS1LZnWDvvgpAFN5Uv_xdKEwk@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-06-02 at 23:58 -0700, Brian Swetland wrote:
> 
> I haven't poked around too much with how things work in SMP
> environments -- are there per-cpu idle threads? 

Yes, and we recently grew the infrastructure for asymmetric MP in the
processing capacity sense.
