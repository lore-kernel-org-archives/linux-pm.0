From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC] pm: remove device_type
	suspend()/resume()
Date: Mon, 1 Jun 2009 21:59:14 +0200
Message-ID: <20090601195913.GA5412@elf.ucw.cz>
References: <20090601103836.10959.43392.sendpatchset@rx1.opensource.se>
	<200906012040.58290.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906012040.58290.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

On Mon 2009-06-01 20:40:57, Rafael J. Wysocki wrote:
> On Monday 01 June 2009, Magnus Damm wrote:
> > From: Magnus Damm <damm@igel.co.jp>
> > 
> > This patch removes the legacy callbacks ->suspend() and
> > ->resume() from struct device_type. These callbacks seem
> > unused, and new code should instead make use of struct
> > dev_pm_ops.
> > 
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> 
> This is fine by me.
> 
> Greg, Pavel, Alan, any objections?

Ok with me.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
