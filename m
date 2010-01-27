From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: really deprecate deprecated user
	ioctls
Date: Thu, 28 Jan 2010 00:05:50 +0100
Message-ID: <201001280005.50666.rjw__44172.6580764682$1264633606$gmane$org@sisk.pl>
References: <1264610778-13242-1-git-send-email-jslaby@suse.cz>
	<20100127194811.GB4626@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100127194811.GB4626@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 27 January 2010, Pavel Machek wrote:
> On Wed 2010-01-27 17:46:17, Jiri Slaby wrote:
> > They were deprecated and removed from exported headers more than 2
> > years ago. Inform users about their removal in the future now.
> > 
> > (Switch cases needed to be reorderded for an easy fall through.)
> > 
> > And add an entry to feature-removal-schedule.
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Pavel Machek <pavel@ucw.cz>
> 
> ACK.

Applied.

Rafael
