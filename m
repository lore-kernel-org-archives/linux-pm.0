From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 11:16:32 +0100
Message-ID: <20090227101632.GG4582__42878.4776050181$1235729771$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0902211135170.7396-100000@netrider.rowland.org>
	<200902212214.59660.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902212214.59660.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


> To summarize, we can:
> * Use a refcount such that automatic suspend will only be possible if it's
>   equal to zero (but that need not be the only criterion).
> * Use a per-device flag in dev_pm_info that will be set whenever the device
>   driver increases the refcount and unset whenever the driver decreases the
>   refcount.
> * Use a per-process flag that will be set whenever the process increases the
>   refcount and unset whenever the process decreases the refcount.

Yes, that sounds sane, and that's how reasonable wakelock
implementation should look like.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
