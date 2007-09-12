From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [4/4] 2.6.23-rc6: known regressions
Date: Wed, 12 Sep 2007 10:19:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709121018560.16478@woody.linux-foundation.org>
References: <46E8187E.9000006@googlemail.com> <46E81ADC.4030902@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46E81ADC.4030902@googlemail.com>
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
Cc: Soeren Sonnenburg <kernel@nn7.de>, Arkadiusz Miskiewicz <arekm@maven.pl>, Thomas Voegtle <tv@lio96.de>, Greg KH <gregkh@suse.de>, Tino Keitel <tino.keitel@gmx.de>, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Christian Leber <christian@leber.de>, Andy Whitcroft <apw@shadowen.org>, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org



On Wed, 12 Sep 2007, Michal Piotrowski wrote:
> 
> Subject         : 2.6.23-rc6-git1 -- termios *_1 compile failures on powerpc
> References      : http://lkml.org/lkml/2007/9/12/101
> Last known good : ?
> Submitter       : Andy Whitcroft <apw@shadowen.org>
> Caused-By       : David Miller <davem@davemloft.net>
>                   commit f629307c857c030d5a3dd777fee37c8bb395e171
> Handled-By      : ?
> Status          : unknown

Should be fixed by b0052fcaefb829a29fdc6567274daf0b75329fc3 ("Define 
termios_1 functions for powerpc, s390, avr32 and frv").

		Linus
