From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 14 Aug 2010 09:53:51 -0700
Message-ID: <20100814095351.6a996187__6213.09671919352$1281804893$gmane$org@infradead.org>
References: <20100809181638.GI3026@linux.vnet.ibm.com>
	<AANLkTikwHaKpLdRdxmZj6JDJnsZ+o-jzbVcXhRW3Jmd9@mail.gmail.com>
	<20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<20100813115751.3bbbafbd@lxorguk.ukuu.org.uk>
	<20100813152912.GE2511@linux.vnet.ibm.com>
	<20100814073843.GA27430@elf.ucw.cz>
	<20100814151048.GA2461@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100814151048.GA2461@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, Contreras <felipe.contreras@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, Felipe@smtp1.linux-foundation.org, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com
List-Id: linux-pm@vger.kernel.org

On Sat, 14 Aug 2010 08:10:48 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> So once you are down to one CPU, the last CPU shuts the system off,
> itself included?  Or does the last CPU "run" in a deep idle state
> throughout suspend?  (My guess is the former, and I am also curious
> whether the cache SRAMs are powered off, etc.  But figured I should
> ask rather than guessing.)

they tend to go "off".

however I think you're making an assumption that there is a
real difference between a deep idle state and "off"....

For modern x86 hardware, that assumption isn't really valid.
(other than a very very small sram that stores register content in the
idle case)



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
