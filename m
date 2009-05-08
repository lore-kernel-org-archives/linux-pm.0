From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 09 May 2009 08:37:18 +1000
Message-ID: <1241822238.19600.336.camel__6829.29377439923$1241822387$gmane$org@nigel-laptop>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<1241746459.19600.246.camel@nigel-laptop>
	<200905082144.57955.bzolnier@gmail.com>
	<200905082303.02677.rjw@sisk.pl>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905082303.02677.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Fri, 2009-05-08 at 23:03 +0200, Rafael J. Wysocki wrote:
> Also, I think we should aim at targets that are possible to achieve.
> Namely,
> it is clear to me that various parts of TuxOnIce will have to be reviewed and
> commented by the memory management people, the file systems people, the
> architecture-dependent code maintainers and so on, and it is much easier to
> get someone to have a look at a relatively short series of patches doing one
> specific thing at a time than to have him review an entire subsystem.

Seeking review is why I've posted the code.

I'm not sure what file systems people have to review in what I've
posted.

I guess the memory management part would be the separate saving of LRU
pages and the means by which GEM pages are tracked.

Re architecture dependent code maintainers: I don't know what they'd
have to do. Nothing in arch/ is touched by the patches I posted.

Regards,

Nigel
