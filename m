From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Fri, 06 Jul 2007 18:59:13 +1000
Message-ID: <1183712354.3388.126.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
	<200707052337.27066.oliver@neukum.org> <200707060913.24131.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707060913.24131.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-07-06 at 09:13 +0200, Rafael J. Wysocki wrote:
> 
> The only reason (I know of) why we don't handle uninterruptible tasks in the
> freezer is that we're afraid of the suspend process deadlocking with an
> uninterruptible task holding a lock, but AFAICS the probability of such an
> event is extremely small.

What would deadlock specifically ? One of the drivers trying to acquire
that lock ? It would be a driver bug then.

> Also, the powermac suspend will deadlock in such cases, so the fact that
> it doesn't deadlock means that they don't occur very often (if at all).

Ben.
