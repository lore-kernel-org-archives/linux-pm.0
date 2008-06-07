From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Suspend and hibernation patchset for 2.6.26-rc3
Date: Sat, 7 Jun 2008 11:21:57 +0100
Message-ID: <200806071121.59619.carlos@strangeworlds.co.uk>
References: <200805212329.59539.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805212329.59539.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 May 2008 22:29:57 Rafael J. Wysocki wrote:
> Patches 01-06 and 11 have been sent to Len as 2.6.27 material.  They have
> been tested by me for some time (except for the most recent changes in
> patches 01 and 11) and have not lead to any problems so far.

Patch 11:

Tested-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

My box can now suspend & resume quite happily with acpi_sleep=old_ordering

(That's on latest 2.6.26 git + the patch series on top).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
