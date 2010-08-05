From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 15:33:02 +0100
Message-ID: <20100805143302.GA21938__43062.6671914526$1281021900$gmane$org@srcf.ucam.org>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100804205654.GA4986@srcf.ucam.org>
	<AANLkTi=fH=XqJ0QgaMwPr5efacWAFo5h0khD7RjL4n8L@mail.gmail.com>
	<201008050220.51805.rjw@sisk.pl>
	<AANLkTikK+OCrg8Jx5SpTbg6iFDX12MKZrTsdOr4mRJN0@mail.gmail.com>
	<20100805134057.GB20565@srcf.ucam.org>
	<alpine.DEB.2.00.1008050717260.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008050717260.25170@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 05, 2010 at 07:22:53AM -0700, david@lang.hm wrote:

> I'm not sure it's possible to completely eliminate the race, even with  
> wakelocks there is some time between the time you last check if the  
> wakelock is set and when the hardware finishes responding to your 
> commands to go to sleep (Unless you can set a level-based interrupt that 
> will wake you up as soon as you finish going to sleep)

It's typically the case that you can - we've even seen that on x86 with 
ACPI GPEs.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
