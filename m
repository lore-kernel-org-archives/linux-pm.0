From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Need help on Suspend on RAM
Date: Wed, 8 Oct 2008 19:01:08 +0200
Message-ID: <20081008170108.GA1471@ucw.cz>
References: <48E1D492.5040606@st.com> <48E1EC46.9090103@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <48E1EC46.9090103@st.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Francesco VIRLINZI <francesco.virlinzi@st.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2008-09-30 11:07:18, Francesco VIRLINZI wrote:
> Hi all
> I think I find a fix (?)
> In the file:
> kernel/time/timekeeping.c
> I'm removing the functions:
>  - timekeeping_suspend and
>  - timekeeping_resume
> I forgot to say that I have no real ClockSource (this means that in 
> suspend also the clocksource is suspended...)

Simply commenting this out is probably not the right solution.. could
you find why it breaks your system and talk to tglx?

								Pavel


> Regards
>  Francesco
> 
> Francesco VIRLINZI ha scritto:
> > Hi all
> > I'm working on Suspend on RAM on kernel 2.6.23.17 on a Sh4 based platform.
> > The suspend on RAM seems really working.
> > But it I suspend the board more then 3/4 times than the system doesn't 
> > resume the user space
> >  but via JTAG I see the kernel is running.
> >
> > I enabled CONFIG_DETECT_SOFTLOCKUP and the kernel prints:
> >
> > |BUG: soft lockup detected on CPU#0|
> >
> > Moreover I installed the patch suggested in http://lwn.net/Articles/287024/
> > and it seems the kernel is running in:
> > -   run_timer_softirq
> >
> >
> > and doing some other test I can confirm the kernel is really there...
> >
> > In the board there is no real RTC... All the 'time' is based on the 
> > system timer
> >  and between suspend/resume the timer is really stopped.
> >
> > Do you have some suggestion?
> >
> > Regards
> > Ciao
> >  Francesco
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> >
> >   
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
