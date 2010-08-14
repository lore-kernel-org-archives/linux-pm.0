From: Neil Brown <neilb@suse.de>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 14 Aug 2010 13:18:45 +1000
Message-ID: <20100814131845.58544209__41096.6014642783$1281756012$gmane$org@notabene>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<201008130528.21887.rjw@sisk.pl>
	<AANLkTinMmVdAVaCFXyDZpVRmZ9FCWYhtdeM=o4hdoZnT@mail.gmail.com>
	<201008131707.03484.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008131707.03484.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Aug 2010 17:07:02 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > 
> > There is no absolute need to start the suspend process from within the
> > kernel, but it makes the user space code much simpler for what we
> > need.  
> 
> I'm entirely aware of that.  Still, I think user space is the right place to
> initiate system suspend.
> 

For what it's worth - I completely agree.

Clearly there is no a lot of unanimity on this, and so lots of room to
experiment with different approaches.  It's best if we leave as much as
possible of that experimentation in user-space - just have the kernel do what
cannot be done elsewhere.

NeilBrown
