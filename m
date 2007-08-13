From: Pavel Machek <pavel@ucw.cz>
Subject: Re: resume from ram much slower
Date: Mon, 13 Aug 2007 21:55:07 +0200
Message-ID: <20070813195507.GB18731@elf.ucw.cz>
References: <200708101848.37222.arekm@maven.pl>
	<6bffcb0e0708101034x44ef5bd0we6a94e398c30c511@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6bffcb0e0708101034x44ef5bd0we6a94e398c30c511@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arkadiusz Miskiewicz <arekm@maven.pl>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> [S-T-R wizards CC'ed]
> 
> On 10/08/07, Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> > Hi,
> >
> > Starting 1-2 weeks ago I have very long resume from
> > ram times. It takes more than 1 min to resume. Does anyone see such behaviour?
> >
> > Kernel from yesterday git, thinkpad z60m, suspend.sf.net tools 20070801
> >
> > "ACPI handle has no context!" are interesting btw.


Usual way to debug it is to unload as many modules as possible, to
find out if it is caused by one of them...

If that does not help, you can try playing with git to find out which
commit caused the regression.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
