From: Pavel Machek <pavel@suse.cz>
Subject: Re: FW:  select with timeout across S3
Date: Tue, 27 Jan 2009 10:15:33 +0100
Message-ID: <20090127091533.GC8543__42497.633994981$1233047883$gmane$org@atrey.karlin.mff.cuni.cz>
References: <20080911092408.GA14503@elf.ucw.cz>
	<739522.18279.qm@web50606.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <739522.18279.qm@web50606.mail.re2.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: marty <martyleisner@yahoo.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

> I don't see a behavior change in the current kernels.
> 
> Select(2) timeouts only count the time the machine is up -- not sleeping...
> 
> I had a patch for 2.6.20 that I tried (it modified schedule_timeout) -- 
> it didn't do anything useful in 2.6.27-rc5.

Do you have some code to demonstrate that? We may want to fix this one
some day...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
