From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 12:45:04 +0100
Message-ID: <20100528114504.GB22947__3542.67439474842$1275047163$gmane$org@srcf.ucam.org>
References: <20100527210808.GB8865@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005271723200.3239-100000@iolanthe.rowland.org>
	<20100527212852.GA9859@srcf.ucam.org>
	<1275040988.20005.29.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275040988.20005.29.camel@thorin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 12:03:08PM +0200, Bernd Petrovitsch wrote:
> On Don, 2010-05-27 at 22:28 +0100, Matthew Garrett wrote:
> > At the point where you're rewriting the application you can just make it 
> > adhere to our current behavioural standards anyway.
> 
> Thank you for confirming that the so-called "feature" is just there to
> make apps work in some area that are crappy anyways - and God knows in
> which other areas they are crappy too.

Kind of like memory protection, really. Or preemptive multitasking. Or 
many things that the kernel does to prevent badly written applications 
from interfering with other applications or the user's experience.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
