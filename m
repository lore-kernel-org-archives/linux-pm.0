From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 15:41:39 +0100
Message-ID: <20100528144139.GA27140__42835.88844487$1275057835$gmane$org@srcf.ucam.org>
References: <20100528043114.GC26177@thunk.org>
	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
	<20100528114123.GA22947@srcf.ucam.org> <4BFFB681.1000105@nokia.com>
	<AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk@mail.gmail.com>
	<4BFFC5DF.5030504@nokia.com> <20100528133900.GG26177@thunk.org>
	<4BFFCFC7.7070302@nokia.com> <20100528142124.GA26733@srcf.ucam.org>
	<AANLkTilj6i7Qi-eh7e3WWeh4zxKALqr-0yhAvWKis52t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilj6i7Qi-eh7e3WWeh4zxKALqr-0yhAvWKis52t@mail.gmail.com>
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
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 07:29:27AM -0700, Brian Swetland wrote:

> I need to think more about the cgroups approach, but I'm pretty sure
> it still suffers from wakeup race situations, and due to the
> complexity of userspace (at least ours), I suspect it would risk
> livelock/deadlock/priority-inversion style issues due to interaction
> between different processes in different groups.

I think the cgroups approach works if you assume that applications that 
consume wakeup events can be trusted to otherwise be good citizens. 
Everything that has no direct interest in wakeup events (except the 
generic Android userspace) can be frozen, and you can use the scheduler 
to make everything else Just Work. That's a rather big if, but you've 
got a better idea of the state of the Android app base than I do.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
