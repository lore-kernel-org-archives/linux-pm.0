From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Mon, 25 May 2009 23:15:04 +1000
Message-ID: <1243257304.16743.108.camel__17508.832694921$1243257324$gmane$org@nigel-laptop>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905090046.21282.rjw@sisk.pl>
	<1241825408.19600.384.camel@nigel-laptop>
	<200905090143.10980.rjw@sisk.pl>
	<1243245907.16743.101.camel@nigel-laptop>
	<20090525124358.GB13446@elf.ucw.cz>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090525124358.GB13446@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Mon, 2009-05-25 at 14:43 +0200, Pavel Machek wrote:
> > Oh, before I forget to mention and you ask - how to know what allowance
> > for the drivers? I use a sysfs entry - the user then just needs to see
> > what's needed on their first attempt, set up a means of putting that
> > value in the sysfs file in future (eg /etc/hibernate/tuxonice.conf) and
> > then forget about it.
> 
> I do believe needed ammount of memory can differ between between
> different suspend attempts. I'd say difference between no X, X w/ 3D,
> X w/ active 3D could be significant.

Yes, but people don't generally change their X configuration. There
would certainly be less memory required without X, but it doesn't hurt
to allow for too many pages being allocated.

> Plus... swsusp gets without configuring that, and I'd prefer as little
> tunables as possible. (In swsusp case, 4MB is reserved for drivers,
> and it is a bug if they need more).

Perhaps this is one of the causes of swsusp (and uswsusp) not working
for people. 4MB is often enough, but often not enough. Actually,
thinking some more about it, it's probably not a problem for swsusp and
uswsusp simply because you have large amounts of memory free anyway. I
agree that they probably shouldn't need more, but wouldn't call it a bug
if more is requested - it's an arbitrary limit.

Regards,

Nigel
