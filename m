From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/2] PM: Introduce hibernation and
	suspend notifiers
Date: Mon, 4 Jun 2007 00:38:53 +0200
Message-ID: <200706040038.54161.rjw__1537.97546304322$1180910036$gmane$org@sisk.pl>
References: <200705272229.21263.rjw@sisk.pl> <200706020243.20117.rjw@sisk.pl>
	<20070603164143.GB4093@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070603164143.GB4093@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 3 June 2007 18:41, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Make it possible to register hibernation and suspend notifiers, so that
> > subsystems can perform hibernation-related or suspend-related operations that
> > should not be carried out by device drivers' .suspend() and .resume() routines.
> 
> One more question: what will we call in suspend-to-both case? I do not
> think we can call SUSPEND_PREPARE with frozen tasks, so just one call
> to HIBERNATION_PREPARE?

Yes, right now it should work this way.

> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Ack.

Thanks!

Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
