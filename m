From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [rft]autosuspend for btusb
Date: Fri, 22 Aug 2008 16:38:41 +0200
Message-ID: <200808221638.41829.oliver__37665.1981067427$1219416158$gmane$org@neukum.org>
References: <200808221520.19791.oliver@neukum.org>
	<200808221551.57225.oliver@neukum.org>
	<1219415470.7591.472.camel@violet.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1219415470.7591.472.camel@violet.holtmann.net>
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
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag 22 August 2008 16:31:10 schrieb Marcel Holtmann:

Hi,

> > > Please explain the tx_in_flight stuff to me. It looks unneeded since we
> > > anchor all TX URBs anyway.
> > 
> > The completion of an URB may happen after the autosuspend timeout passed.
> > But we cannot use the pm counters as they are not accessible in interrupt.
> > Hence we must maintain a counter ourselves.
> 
> Can we not just check the number of URBs in the anchor? I am against
> just duplicating a counter, but then lets call it it what it is to make
> it gets not misused. It is a purely a PM counter.

Yes, we can do that. In fact a bool empty/!empty will do. I'll do that.

	Regards
		Oliver
