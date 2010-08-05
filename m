From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 15:16:20 +0100
Message-ID: <20100805141620.GA21459__37069.8077058934$1281023327$gmane$org@srcf.ucam.org>
References: <20100804185520.GA2417@srcf.ucam.org>
	<201008042251.08266.rjw@sisk.pl>
	<20100804205654.GA4986@srcf.ucam.org>
	<alpine.DEB.2.00.1008041529530.6545@asgard.lang.hm>
	<AANLkTimRZc2B1=ic-0jrGBX7ahCu=NCoQadCOePGDmh9@mail.gmail.com>
	<alpine.DEB.2.00.1008041554580.6545@asgard.lang.hm>
	<20100804231003.GL24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041616160.6545@asgard.lang.hm>
	<20100805134741.GC20565@srcf.ucam.org>
	<alpine.DEB.2.00.1008050706170.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008050706170.25170@asgard.lang.hm>
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

On Thu, Aug 05, 2010 at 07:07:06AM -0700, david@lang.hm wrote:
> On Thu, 5 Aug 2010, Matthew Garrett wrote:
>> The decision on whether or not to go to sleep isn't the difficult bit of
>> this problem space.
>
> but isn't that all that wakelocks do? affect the decision on whether or  
> not to go to sleep.

You could think of them that way, but it's not the useful aspect of them 
- that much could be implemented entirely in userspace. Wakelocks 
provide a mechanism for userspace to ensure that it's handled all 
received events before a system suspend takes place.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
