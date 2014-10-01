From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v7 00/11] kernel: Add support for restart handler call chain
Date: Wed, 01 Oct 2014 15:32:41 +0200
Message-ID: <17880788.QtjeWKsOjD@phil>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net> <20140930142002.e09ef32392a2b5a7c81e5e57@linux-foundation.org> <20140930223000.GA20946@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140930223000.GA20946@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jonas Jensen <jonas.jensen@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tomasz Figa <t.figa@samsung.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 30. September 2014, 15:30:00 schrieb Guenter Roeck:
> On Tue, Sep 30, 2014 at 02:20:02PM -0700, Andrew Morton wrote:
> > On Tue, 19 Aug 2014 17:45:27 -0700 Guenter Roeck <linux@roeck-us.net> 
wrote:
> > > Introduce a system restart handler call chain to solve the described
> > > problems.> 
> > So someone has merged eight of these patches into linux-next but these
> > three:
> > 
> > watchdog-s3c2410-add-restart-handler.patch
> > clk-samsung-register-restart-handlers-for-s3c2412-and-s3c2443.patch
> > clk-rockchip-add-restart-handler.patch
> > 
> > were omitted.  What's up?
> 
> Most likely PBKC on my side; Looks like I forgot to add those when I created
> the immutable branch for others to merge. Sorry for that :-(.
> 
> Having said that, I somehow thought that the clock patches would go in
> through the clock tree. Heiko, did I get that wrong ? Separately, I sent a
> pull request that includes the watchdog patch to Wim.

I didn't realise that the patches would get dropped from -mm until I the 
removal notices this morning. So meanwhile I've send a pull to Mike for the 
Rockchip and S3C2412/2416/2443 restart handling.

So, as your pull includes the samsung watchdog restart, we should be hopefully 
all set again :-) .


Heiko
