From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 17:13:14 -0700
Message-ID: <AANLkTinatKEBfHhMnKc5wbys13P81PKWSc+nxccgHe-Y__10374.8925067068$1281053689$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.00.1008041722060.6545@asgard.lang.hm>
	<20100805004802.GP24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008042208350.25170@asgard.lang.hm>
	<20100805151211.GA10080@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008050832010.25170@asgard.lang.hm>
	<AANLkTi=Yyyc-hOPbkJtsnKCVzncnFq8DPnonmyckekwm@mail.gmail.com>
	<20100805203102.GN2447@linux.vnet.ibm.com>
	<AANLkTimaaLSwVusJ=w5-QptoauBnHH0JvCvmWUr0y+KD@mail.gmail.com>
	<alpine.DEB.2.00.1008051453450.30632@asgard.lang.hm>
	<AANLkTikCCeMG=DAQ04xqkvqH9tngBWyBA5VQTD4_15xU@mail.gmail.com>
	<20100805230304.GQ2447@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100805230304.GQ2447@linux.vnet.ibm.com>
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
Cc: david@lang.hm, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 5, 2010 at 4:03 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>> > so what would wake a phone up from suspend where the phone should go back to
>> > sleep in under a second?
>>
>> Here are some real-world examples from shipped android devices:
>> - battery gauging happens every 10 minutes, need to wake long enough
>> to chatter with the 1w interface and make sure the battery is not
>> exploding
>> - always on mail/im/calendar/etc sync often has network events that
>> happen every 5-10 minutes which cause devices to briefly wake up and
>> return to sleep
>> - gps tracker app might wake every couple minutes or every n gps
>> events to log location
>> - low power audio subsystems can wake you up every 1-4 seconds (pcm)
>> or 1-4 minutes (mp3) to fetch more data
>
> Interesting!
>
> So for an mp3 playback, does an Android suspend between data fetches?

It can if the latency is long enough (which is why I point out low
power audio which is usually high latency).  For low latency (system
sounds, etc) 10-25ms between buffers it's not practical to fully
suspend but we will go to the lowest power state in idle if possible.

Brian
