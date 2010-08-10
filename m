From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Tue, 10 Aug 2010 15:44:05 +0100
Message-ID: <20100810154405.475c2669__22978.3153896735$1281450911$gmane$org@lxorguk.ukuu.org.uk>
References: <20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
	<20100810044541.GA2817@linux.vnet.ibm.com>
	<20100810093849.138e2318@lxorguk.ukuu.org.uk>
	<20100810141107.GA12873@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100810141107.GA12873@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: david@lang.hm, menage@google.com, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Which reminds me. I forgot a very important way that user space signals
the kernel as to its intents.

The kernel can see whether code is sleeping by choice or sleeping because
someone blocked it (eg a page fault). The kernel also knows a lot about
the event being waited for (much more so in -rt than base).

We don't capture all of that info but it seems it would advance progress
in the right direction to do so better.

Alan
