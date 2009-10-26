From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug #14483] WARNING: at drivers/base/sys.c:353
	__sysdev_resume+0x54/0xca()
Date: Mon, 26 Oct 2009 22:01:55 +0100
Message-ID: <200910262201.55087.rjw__30859.333734452$1256590897$gmane$org@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera>
	<6dRYo8ss7vL.A.hyE.2qe5KB@chimera> <4AE601B1.7050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AE601B1.7050000@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 26 October 2009, Justin P. Mattock wrote:
> Rafael J. Wysocki wrote:
> > This message has been generated automatically as a part of a report
> > of recent regressions.
> >
> > The following bug entry is on the current list of known regressions
> > from 2.6.31.  Please verify if it still should be listed and let me know
> > (either way).
> >
> >
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14483
> > Subject		: WARNING: at drivers/base/sys.c:353 __sysdev_resume+0x54/0xca()
> > Submitter	: Justin Mattock<justinmattock@gmail.com>
> > Date		: 2009-10-25 19:58 (2 days old)
> > References	: http://marc.info/?l=linux-kernel&m=125650070420168&w=4
> >
> >
> >
> >    
> yeah this happens on the first go of
> echo mem > /sys/power/state
> for both of my imac's I have here.
> (on the second  try, this message does not appear)

Thanks for the update.

Rafael
