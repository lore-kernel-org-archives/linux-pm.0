From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sun, 10 May 2009 07:38:40 +0200
Message-ID: <20090510053840.GG1363__44011.4222503782$1242045797$gmane$org@ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz> <200905080037.19722@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905080037.19722@centrum.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: trekker.dk@centrum.cz
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2009-05-08 00:37:39, trekker.dk@centrum.cz wrote:
> Well...
> 
> >
> >
> >To summarise disadvantages:
> >
> >- only core has 8000 LoC
> >- it does stuff that can be easily done in userspace
> >     (and that todays distros _do_ in userspace).
> >- it duplicates uswsusp functionality.
> >- compared to [u]swsusp, it received little testing
> >
> 
> To summarise advatages - for me tuxonice is the only hibernation method that works.
> (Till now I've had 3 machines - no one of them able to resume with in-kernel swsusp.)
> 

Which kernels you tried, what hw it is? Can you do s2ram?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
