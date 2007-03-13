From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [5/6] 2.6.21-rc3: known regressions
Date: Tue, 13 Mar 2007 22:46:38 +0100
Message-ID: <200703132246.39253.arekm@maven.pl>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org> <20070313125016.GV18731@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030671AbXCNG66@vger.kernel.org>
In-Reply-To: <20070313125016.GV18731@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org, Tomas Janousek <tomi@nomi.cz>, Thomas Gleixner <tglx@linutronix.de>, Soeren Sonnenburg <kernel@nn7.de>, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Lukas Hejtmanek <xhejtman@mail.muni.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 13 of March 2007, Adrian Bunk wrote:

> Subject    : ThinkPad Z60m: usb mouse stops working after suspend to =
ram
> References : http://lkml.org/lkml/2007/2/21/413
>              http://lkml.org/lkml/2007/2/28/172
> Submitter  : Arkadiusz Miskiewicz <arekm@maven.pl>
> Caused-By  : Konstantin Karasyov <konstantin.a.karasyov@intel.com>
>              commit 0a6139027f3986162233adc17285151e78b39cac
> Handled-By : Konstantin Karasyov <konstantin.a.karasyov@intel.com>
> Status     : problem is being debugged

It's fixed in git tree. Commit ff24ba74b6d3befbfbafa142582211b5a6095d45

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
