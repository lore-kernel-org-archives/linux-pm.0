From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i386: Do not restore reserved memory after
	hibernation
Date: Sat, 2 Jun 2007 10:38:34 +0200
Message-ID: <200706021038.35038.rjw@sisk.pl>
References: <200706012158.32832.rjw@sisk.pl>
	<200706020850.28299.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706020850.28299.arvidjaar@mail.ru>
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
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-pm <linux-pm@lists.osdl.org>, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday, 2 June 2007 06:50, Andrey Borzenkov wrote:
> On Friday 01 June 2007, Rafael J. Wysocki wrote:
> > Hi,
> >
> > This patch is designed to fix
> > http://bugzilla.kernel.org/show_bug.cgi?id=7995
> >
> > Unfortunately, the reporter is unresponsive, 
> 
> well, we have our life too ...
> 
> I confirm that this patch works.

OK, thanks for the confirmation.

> Unfortunately 2.6.22-rc here tends to hang on resume from STD often enough
> use. It just sits there with cursor in upper left corner, no output on 
> screen, nothing. I believe to have seen discussion about USB deadlock during 
> resume but cannot find it anymore. The problem is sporadic enough to render 
> bisect useless.

I think we had a bug report related to it yesterday, from a system where it
happened 100% of the time.  Hopefully, we'll be able to nail it down.

As usual, it's not reproducible on any of my test boxes ...

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
