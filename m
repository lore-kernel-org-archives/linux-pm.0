From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Sat, 10 Apr 2010 21:36:43 +0200
Message-ID: <201004102136.43246.rjw__30816.1254426979$1270928093$gmane$org@sisk.pl>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<201004092242.17341.rjw@sisk.pl>
	<1270848027.3071.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1270848027.3071.0.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Vroon <tony@linx.net>
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Michal Hocko <mhocko@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 09 April 2010, Tony Vroon wrote:
> On Fri, 2010-04-09 at 22:42 +0200, Rafael J. Wysocki wrote:
> > Please check if the patch below changes anything.
> >  drivers/acpi/wakeup.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> That didn't change the behaviour for me, sorry.

Well, I would be sorry if it did, because the patch removed some useful code. :-)

> (I made sure to go through a full power down session before trying the
> patched kernel)

Thanks for testing.  So it looks like we don't disable the GPE during power off.

I'll try to figure out what's going on, please stay tuned.

Rafael
