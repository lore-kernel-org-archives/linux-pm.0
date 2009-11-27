From: Oliver Neukum <oliver@neukum.org>
Subject: Re: suggestion on resumption
Date: Fri, 27 Nov 2009 09:18:19 +0100
Message-ID: <200911270918.20029.oliver@neukum.org>
References: <200911262259.59152.oliver@neukum.org>
	<200911270147.44837.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911270147.44837.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 27. November 2009 01:47:44 schrieb Rafael J. Wysocki:
> On Thursday 26 November 2009, Oliver Neukum wrote:
> > Hi,
> >
> > using the USB autosuspend framework I've often faced characteristic
> > problems coding resume() methods. This has led me to an idea. Resume()
> > would be much easier to code if I knew about the reason of resumption,
> > especially about the code path resume() is called in. I wonder whether
> > we could introduce a message argument to resume and give it a few
> > bits from the caller.
> 
> Each of the callbacks in struct dev_pm_ops is executed in exactly one
>  context, so for each of them it is known why it was called.

But the resume method in the driver doesn't learn. It is an extrem hassle
not to know whether you are called synchronously (ie from open which
already holds a lock) or asynchronously (which means you need to guard
against open)

	Regards
		Oliver
