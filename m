From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/2] swsusp: Free more memory
Date: Sun, 22 Apr 2007 11:37:33 +0200
Message-ID: <200704221137.34104.rjw@sisk.pl>
References: <200704220002.37083.rjw@sisk.pl> <200704220005.39942.rjw@sisk.pl>
	<1177198299.4036.8.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177198299.4036.8.camel@nigel.suspend2.net>
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
To: nigel@nigel.suspend2.net
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday, 22 April 2007 01:31, Nigel Cunningham wrote:
> Hi.
> 
> On Sun, 2007-04-22 at 00:05 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Move the definition of PAGES_FOR_IO to kernel/power/power.h and introduce
> > SPARE_PAGES representing the number of pages that should be freed by the
> > swsusp's memory shrinker in addition to PAGES_FOR_IO so that device drivers can
> > allocate some memory (up to 1 MB total) in their .suspend() routines without
> > causing the suspend to fail.
> 
> 1MB is not going to be enough for people with DRI. I have a cycle on my
> machine recording 3510 extra pages (13 meg) allocated during the atomic
> copy, and I know there are others with larger numbers.

I know.  The other mechanism (ie. notifiers) is for them.

The idea of this patch is to make it possible to _avoid_ using the notifiers
if you need only a limited amount of memory.

Greetings,
Rafael
