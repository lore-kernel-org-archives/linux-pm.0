From: Pavel Machek <pavel@suse.cz>
Subject: Re: FW:  select with timeout across S3
Date: Mon, 1 Sep 2008 08:25:13 +0200
Message-ID: <20080901062513.GA9851__35648.6682351262$1220250722$gmane$org@ucw.cz>
References: <556445368AFA1C438794ABDA8901891C09639B7A@USA0300MS03.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <556445368AFA1C438794ABDA8901891C09639B7A@USA0300MS03.na.xerox.net>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> The behavior of linux (in both 2.4.x and 2.6.x) is when the processor
> sleeps, timeouts on select don't take into account the sleep time,
> only the run time.
> 
> For example, this program should pause for 10 minutes -- however
> if we go into S3 in the middle its pausing for (10 minutes + time in
> S3)
> 
> I saw this on both 2.6.20 and 2.6.22...

Can you test this on 2.6.27-rc? We did have some fixes in that
area....

							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
