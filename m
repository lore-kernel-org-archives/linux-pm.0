From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Mon, 16 Aug 2010 17:09:11 +0100
Message-ID: <20100816160911.GA3479__16808.2199445509$1281975060$gmane$org@srcf.ucam.org>
References: <20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<20100813115751.3bbbafbd@lxorguk.ukuu.org.uk>
	<20100813152912.GE2511@linux.vnet.ibm.com>
	<20100814073843.GA27430@elf.ucw.cz>
	<20100814151048.GA2461@linux.vnet.ibm.com>
	<20100814095351.6a996187@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100814095351.6a996187@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: david@lang.hm, menage@google.com, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, swmike@swm.pp.se
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 14, 2010 at 09:53:51AM -0700, Arjan van de Ven wrote:

> they tend to go "off".
> 
> however I think you're making an assumption that there is a
> real difference between a deep idle state and "off"....
> 
> For modern x86 hardware, that assumption isn't really valid.
> (other than a very very small sram that stores register content in the
> idle case)

Really? I thought the TSC stopped in suspend. Does having a package go 
into C6 mean that the RAM goes into self-refresh?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
