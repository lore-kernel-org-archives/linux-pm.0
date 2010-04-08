From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Fri, 9 Apr 2010 00:54:35 +0200
Message-ID: <201004090054.35949.rjw__7038.51125804267$1270767157$gmane$org@sisk.pl>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<201004082243.18393.rjw@sisk.pl>
	<1270766263.5923.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1270766263.5923.3.camel@localhost>
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
> Rafael,
> 
> I have the exact same "lid close = powering back on" regression on a
> Fujitsu-Siemens Lifebook S6420. Totally missed this thread before, but
> I'm glad that I'm not alone with this one.
> Happy to test any patches you may come up with; will an acpidump do for
> you or do you need additional data?

I need to figure out what actually happens and I'll need you to try a debug
patch, but it's not ready yet.

Rafael
