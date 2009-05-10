From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sun, 10 May 2009 07:37:53 +0200
Message-ID: <20090510053753.GE1363__13449.3250902326$1242046038$gmane$org@ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz>
	<Pine.LNX.4.64.0905070925500.8967@hp9800.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0905070925500.8967@hp9800.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenneth Crudup <kenny@panix.com>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2009-05-07 09:28:41, Kenneth Crudup wrote:
> 
> On Thu, 7 May 2009, Pavel Machek wrote:
> 
> > Given that distros ship uswsusp already... is that really an advantage.
> 
> Uswsusp has no compression. A suspend-to-disk that can take up to 5
> minutes in uswsusp takes 20 seconds with TuxOnIce. Uswsusp has no built-
> in hooks that allow me to run commands and set options during the suspend
> and resume process.

uswsusp supports compression, see suspend.sf.net. Oh and yes you can
interrupt it (with del key iirc).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
