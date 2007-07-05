From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: The big suspend mess
Date: Thu, 5 Jul 2007 12:32:55 +0200
Message-ID: <b637ec0b0707050332p6a5d31afpe3c0baa97da9b068__2343.60478721118$1183631627$gmane$org@mail.gmail.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031456.40890.rjw@sisk.pl>
	<1183497290.3388.4.camel@localhost.localdomain>
	<200707032332.49694.rjw@sisk.pl>
	<18059.5165.861038.392332@cargo.ozlabs.ibm.com>
	<20070704221952.GM3492@stusta.de> <20070705002747.GA2952@elf.ucw.cz>
	<18060.16657.2143.11489@cargo.ozlabs.ibm.com>
	<20070705093251.GB3228@elf.ucw.cz> <468CC7F7.90803@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <468CC7F7.90803@googlemail.com>
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
To: Gabriel C <nix.or.die@googlemail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi.

On 7/5/07, Gabriel C <nix.or.die@googlemail.com> wrote:
> Pavel Machek wrote:
> > On Thu 2007-07-05 10:53:37, Paul Mackerras wrote:
> >
> >> Pavel Machek writes:
> >>
> >>
> >>> 0. Get someone to sign up as a maintainer for suspend, so we have
> >>> someone to blame for the mess? :-)
> >>>
> >> I thought that was Rafael?
> >>
> >
> > Rafael is good job trying to fix suspend when he can, but we do not
> > actually have "SUSPEND" entry in MAINTAINERS file.
> >                                                               Pavel
> >
>
> Huch ?;)
>
> We do :p
>
> ...
>
> SOFTWARE SUSPEND:
> P: Pavel Machek
> M: pavel@suse.cz
> L: linux-pm@lists.linux-foundation.org
> S: Maintained
>

I think he means SUSPEND (aka suspend-to-ram) not "SOFTWARE SUSPEND"
(aka suspend-to-disk)
