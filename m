From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Mon, 9 Aug 2010 18:17:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008091812520.23481__26565.8525786877$1281403226$gmane$org@asgard.lang.hm>
References: <20100806225453.GA3947@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061651530.30564@asgard.lang.hm>
	<AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100809201822.441905f7@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 9 Aug 2010, Alan Cox wrote:

>> But wouldn't an office suite run as a power-oblivious application on an
>> Android device?  After all, office applications do not need to run when
>
> I was waiting for soemone to leap down the pit I dug  Office suites have
> some quite important background activities. Consider the case of a power
> oblivious Open Office. You type a critical document, you suspend, your
> phone battery dies a bit later, you lost your document. Office suites do
> timed backing up as one simple obvious example. That could become a power
> aware behaviour but the truely power oblivious office suite is a myth.

this is a good example of why the office suite should be a privilaged 
application. If the system were to consider it privilaged, it could 
wake up when the timer is scheduled to fire to save the document.

the office suite probably has a periodic timer that would fire every 10 
min no matter what, but if there was a reason to change it, it could be 
modified to only setup the timer when the document is changed. If no 
changes can take place because the system is asleep, the timer never gets 
setup.

David Lang
