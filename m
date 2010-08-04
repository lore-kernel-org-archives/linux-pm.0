From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 15:54:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008041543030.6545__10742.1851753772$1280962565$gmane$org@asgard.lang.hm>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<20100804204208.GA21452@elf.ucw.cz>
	<20100804204839.GA4743@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100804204839.GA4743@srcf.ucam.org>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Aug 2010, Matthew Garrett wrote:

> On Wed, Aug 04, 2010 at 10:42:08PM +0200, Pavel Machek wrote:
>
>> This came like a bit of a shock to me ("why do they make it so complex
>> then"), but... it also means that as soon as you are able to stop
>> "unwanted" processing, you can just leave normal cpuidle mechanisms to
>> deal with the rest...
>
> How do you differentiate between "unwanted" and "wanted" processing in
> the same task in a race-free manner?

how much do you care? (not from a theoretical point of view, but from a 
practical point of view, how much difference does it make)

how much "unwanted" processing would you allow a process to do before 
shutting down?

how likely are apps that you would trust to just assert "I know better 
than the system or the user how important I am, don't you dare sleep now" 
that do this properly, but then do other processing that you really don't 
want to have happen? (I expect that if the authors of those apps ever ran 
into this case, they would just add another wakelock to prevent it)


If the only things you have running are apps that are trusted to take the 
wakelock, are you really going to sleep any more frequently with the 
wakelock infrastructure than you would with just idle detection? (this can 
be tested today by just stubbing out the wakelock checks so they have no 
effect on sleeping)


David Lang
