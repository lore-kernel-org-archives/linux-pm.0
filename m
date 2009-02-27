From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 21:54:01 +0100
Message-ID: <200902272154.03539.rjw__9200.43879091299$1235768271$gmane$org@sisk.pl>
References: <200902192215.18365.rjw@sisk.pl> <200902271522.41915.rjw@sisk.pl>
	<20090227142946.GA13650@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090227142946.GA13650@srcf.ucam.org>
Content-Disposition: inline
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 27 February 2009, Matthew Garrett wrote:
> On Fri, Feb 27, 2009 at 03:22:39PM +0100, Rafael J. Wysocki wrote:
> > On Friday 27 February 2009, Pavel Machek wrote:
> > > Wakelocks done right are single atomic_t... and if you set it to 0,
> > > you just unblock "sleeper" thread or something. Zero polling and very
> > > simple...
> > 
> > Except that you have to check all of the wakelocks periodically in a loop =>
> > polling.  So?
> 
> Why do you need to check them? If you're taking this approach you just 
> have something like:
> 
> suspend_unblock() {
> 	if (atomc_dec_and_test(&suspend_lock))
> 		suspend();
> }
> 
> and then check that the lock count is still 0 after device_suspend(). 
> There's no need to poll.

I was talking about wakelocks as originally proposed.

Using a refcount along with per-driver and per-process flags (probably two
refcounts would be more efficient in fact) is the latest idea and I agree it
wouldn't require polling.  However, if you refer to that, please don't use the
name "wakelock". :-)

Thanks,
Rafael
