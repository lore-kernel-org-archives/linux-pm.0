From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC Disable suspend on a specific device] This is	a
	little change in linux power scheme
Date: Tue, 7 Apr 2009 10:06:11 +0200
Message-ID: <20090407080611.GF1408@ucw.cz>
References: <200904072257.23756.rjw@sisk.pl> <200904081013.25301.rjw@sisk.pl>
	<49DC5F58.7070705@gandalf.sssup.it>
	<200904081034.56624.rjw@sisk.pl>
	<49DC6442.3040506@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49DC6442.3040506@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

Hi!

> > I think this is a rather fundamental issue and it requires some more thought.
> >
> > What platform is your device based on, BTW?

> I'm working on an openmoko freerunner gta02 and do some work on android 
> framework.
> It's a smartphone
> http://wiki.openmoko.org/wiki/Main_Page
> 
> The bluetooth device for example in the Freerunner has a direct I2S connection to
> the WM8753.  Audio from a bluetooth headset is decoded by and sent digitially 
> to the WM8753 which does the digital to analogue conversion and 
> routes it out via the appropriate outputs.
> Analogue problem has the ti-caplyso when the audio is routed for a phone call.

I still believe it should be done in the driver... at least
today. Perhaps driver should just keep i2s/bluetooth powered up when
it is in use.

Perhaps we need new state 'sleep but keep working' for cases like
that; echo mem > state should force machine to drop calls etc. There
should be another value where stuff that is in use keeps being powered
up; I also suspect that that's what android wants to use. 

> Is the correct answer to you question?
 
Yes :-).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
