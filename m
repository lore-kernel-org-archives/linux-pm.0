From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: Remove CONFIG_PM_VERBOSE
Date: Thu, 19 May 2011 15:07:24 +0200
Message-ID: <20110519130723.GB4996__18433.4519705319$1305810571$gmane$org@elf.ucw.cz>
References: <201105140042.04064.rjw@sisk.pl> <201105162032.33480.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105162032.33480.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 2011-05-16 20:32:33, Rafael J. Wysocki wrote:
> On Saturday, May 14, 2011, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Now that we have CONFIG_DYNAMIC_DEBUG there is no need for yet
> > another flag causing dev_dbg() and pr_debug() statements in the
> > core PM code to produce output.  Moreover, CONFIG_PM_VERBOSE
> > causes so much output to be generated that it's not really useful
> > and almost no one sets it.
> > 
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=23182
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK

> There are no comments, so my understanding is that no one has any objections to
> this patch.  If that really is the case, I'm going to put it into
> suspend-2.6/linux-next for 2.6.40.

And sorry for slow responses.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
