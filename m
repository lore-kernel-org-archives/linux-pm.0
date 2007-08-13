From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: resume from ram much slower
Date: Mon, 13 Aug 2007 16:21:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708131620090.2553-100000__1219.0030808144$1187036599$gmane$org@iolanthe.rowland.org>
References: <20070813195507.GB18731@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070813195507.GB18731@elf.ucw.cz>
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
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Arkadiusz Miskiewicz <arekm@maven.pl>
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Aug 2007, Pavel Machek wrote:

> Hi!
> 
> > [S-T-R wizards CC'ed]
> > 
> > On 10/08/07, Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> > > Hi,
> > >
> > > Starting 1-2 weeks ago I have very long resume from
> > > ram times. It takes more than 1 min to resume. Does anyone see such behaviour?
> > >
> > > Kernel from yesterday git, thinkpad z60m, suspend.sf.net tools 20070801
> > >
> > > "ACPI handle has no context!" are interesting btw.
> 
> 
> Usual way to debug it is to unload as many modules as possible, to
> find out if it is caused by one of them...
> 
> If that does not help, you can try playing with git to find out which
> commit caused the regression.

Another possibility: Compare the timestamps in your log with a log from 
an earlier kernel, to find out exactly where the extra delay occurred.

Alan Stern
