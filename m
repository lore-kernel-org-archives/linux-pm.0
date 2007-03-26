From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-pm][standby mode - S0/D2/C4] Wake up sources
	in standby
Date: Mon, 26 Mar 2007 09:57:35 +0200
Message-ID: <20070326075735.GA2178@elf.ucw.cz>
References: <200703250934.CHL31961@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703250934.CHL31961@tataelxsi.co.in>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

>    In standby mode, my understanding is that, the processor is in state
>    retaining mode.

Yes.

>    The context need not be saved for retaining the state prior to
>    entering standby mode.

yes.

>    I have set up the wake up source as external wake up (power on/off
>    switch).

Sounds like broken hw to me.

>    Is there any difference between Idle mode and standby mode.

Yes.
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
