From: Pavel Machek <pavel@ucw.cz>
Subject: Re: power draw depending on PHY speed
Date: Tue, 1 Sep 2009 15:25:29 +0200
Message-ID: <20090901132529.GA2718@ucw.cz>
References: <76FA3B279DD9DA48896E2B40494495720368E449@USA7061MS02.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <76FA3B279DD9DA48896E2B40494495720368E449@USA7061MS02.na.xerox.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Cc: martyleisner@yahoo.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2009-08-28 08:26:13, Leisner, Martin wrote:
> While doing some current probe measurements (i.e. to measure the effects
> of NAP and frequency scaling with a freescale processor) I noticed some
> very
> significant differents if we ran on 100Mbit of 1000Mbit ethernet.

Yep, difference seems to be cca 1W. I had stupid shell script to switch it...

								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
