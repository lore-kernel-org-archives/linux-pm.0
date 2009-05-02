From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Sat, 2 May 2009 22:51:37 +0200
Message-ID: <20090502205137.GA1435@elf.ucw.cz>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<200904300034.09837.rjw@sisk.pl>
	<d6200be20904291749v55f5e425jcbb570c09a3901d1@mail.gmail.com>
	<200905021414.32565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905021414.32565.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > >> +config SUSPEND_BLOCK
> > >> +     bool "Suspend block"
> > >> +     depends on PM
> > >> +     select RTC_LIB
> > >
> > > depends on RTC_LIB
> > >
> > > select doesn't really work and I don't think it ever will.
> > 
> > Nothing depends on RTC_LIB, it is only selected.
> 
> If nothing in your code needs anything depending on RTC_LIB, why select it?

He wants to say nothing in _kernel proper_ depends on RTC_LIB:

pavel@amd:/data/l/linux-good$ grep 'select RTC_LIB' `find . -name
"Kconfig"`
./arch/arm/Kconfig:	select RTC_LIB
./arch/mips/Kconfig:	select RTC_LIB
./drivers/rtc/Kconfig:	select RTC_LIB
pavel@amd:/data/l/linux-good$ grep 'depends.*RTC_LIB' `find . -name
"Kconfig"`
pavel@amd:/data/l/linux-good$ 

RTC_LIB seems to be designed for select.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
