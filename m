From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: resume from ram much slower
Date: Mon, 13 Aug 2007 22:55:33 +0200
Message-ID: <200708132255.34572.rjw@sisk.pl>
References: <200708101848.37222.arekm@maven.pl>
	<6bffcb0e0708101034x44ef5bd0we6a94e398c30c511@mail.gmail.com>
	<20070813195507.GB18731@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070813195507.GB18731@elf.ucw.cz>
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
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Arkadiusz Miskiewicz <arekm@maven.pl>
List-Id: linux-pm@vger.kernel.org

On Monday, 13 August 2007 21:55, Pavel Machek wrote:
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

This particular message only means that the device is unknown to ACPI and its
power state should be set to D3 (or equivalent).  PCI handles this correctly,
pnp also seems to handle it and there are no more users.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
