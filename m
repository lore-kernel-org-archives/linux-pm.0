From: Florian Mickler <florian@mickler.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 07:46:28 +0200
Message-ID: <20100804074628.4acc0ed2__559.732275042002$1280900903$gmane$org@schatten.dmk.lab>
References: <20100801210548.23f77ff6@infradead.org>
	<alpine.DEB.2.00.1008012153300.25170@asgard.lang.hm>
	<20100802140933.GB2405@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>
	<AANLkTi=1kBuyPS_P+eNLcnRu1mJH6BzpzQW_sENZuL1L@mail.gmail.com>
	<alpine.DEB.2.00.1008022121430.6545@asgard.lang.hm>
	<AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>
	<alpine.DEB.2.00.1008022203470.6545@asgard.lang.hm>
	<AANLkTinFT5jq4nUhUpzS5S4TVDQGj0S7RtRgxNhsz2UF@mail.gmail.com>
	<alpine.DEB.2.00.1008031611100.6545@asgard.lang.hm>
	<20100804001015.GJ2407@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008031723530.6545@asgard.lang.hm>
	<AANLkTinjH0C0bSK=Y2wKASnbJFsR2BN303xBXkaHbmRC@mail.gmail.com>
	<alpine.DEB.2.00.1008032111350.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008032111350.25170@asgard.lang.hm>
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
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, "Paul E.
	McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, 3 Aug 2010 21:47:49 -0700 (PDT)
david@lang.hm wrote:

> > Suspend is not an android only concept. The android extensions just
> > allow us to aggressively use suspend without loosing (or delaying)
> > wakeup events. On the hardware that we shipped we can enter the same
> > power mode from idle as we do in suspend, but we still use suspend
> > primarily because it stops the monotonic clock and all the timers that
> > use it. Changing suspend to behave more like an idle mode, which seems
> > to be what you are suggesting, would not buy us anything.
> 
> Ok, If I am understanding you correctly I think this is an important 
> point.
> 
> What Android calls suspend is not what other linux distros call suspend, 
> it's just a low-power mode with different wakeup rules.
> 
> Is this correct?

I think my laptop (x86-64) uses the same notion of suspend as Android.
I am confused now. Android 'suspend' is equivalent to 
'echo "mem" > /sys/power/state' 
 
Which distros call it "low-power mode with different wakeup rules"?
Gentoo doesnt. In KDE/Gnome it's also called suspend or suspend-to-ram
iirc. 



Cheers,
Flo
