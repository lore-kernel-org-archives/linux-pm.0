From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] pm: remove bus_type
	suspend_late()/resume_early() V2
Date: Sat, 23 May 2009 22:59:18 +0200
Message-ID: <20090523205918.GA17899@elf.ucw.cz>
References: <20090521082754.1020.73349.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090521082754.1020.73349.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2009-05-21 17:27:54, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Remove the ->suspend_late() and ->resume_early() callbacks
> from struct bus_type V2. These callbacks are legacy stuff
> at this point and since there seem to be no in-tree users
> we may as well remove them. New users should use dev_pm_ops.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
