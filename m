From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3] Freezer: Remove redundant check in
	try_to_freeze_tasks
Date: Sun, 27 May 2007 01:18:24 +0200
Message-ID: <20070526231824.GC15715@elf.ucw.cz>
References: <200705262317.48604.rjw@sisk.pl> <200705262329.07758.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705262329.07758.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2007-05-26 23:29:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> We don't need to check if todo is positive before calling time_after() in
> try_to_freeze_tasks(), because if todo is zero at this point, the loop will
> be broken anyway due to the while () condition being false.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK. Thanks for the cleanups!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
