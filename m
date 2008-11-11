From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [0/2] Hibernation patches for suspend branch (was: Re:
	[PATCH -next] Hibernate: Take overlapping zones into account)
Date: Tue, 11 Nov 2008 21:30:25 +0100
Message-ID: <200811112130.26074.rjw__41373.9191987135$1226435513$gmane$org@sisk.pl>
References: <200811081356.13060.rjw@sisk.pl>
	<alpine.LFD.2.00.0811111300580.4480@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0811111300580.4480@localhost.localdomain>
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
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, Andy Whitcroft <apw@shadowen.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 11 of November 2008, Len Brown wrote:
> 
> On Sat, 8 Nov 2008, Rafael J. Wysocki wrote:
> 
> > Hi Len,
> > 
> > Please add this patch to the suspend branch.
> 
> Please re-send a checkpatch clean version.
> 
> Also, the comments on this patch (and the next) are mal-formed.
> The commit message must be before the first "---" and the throw-away
> comments must be after it, rather thant the reverse.
> 
> I ask others to get this right, so it seems most fair that I do the
> same for you -- otherwise your next patch will have the same problems
> and others will follow your example of not sending the "perfect patch"

OK, here you go.  The following two messages contain the updated patches
(still, 4 out of the 5 checkpatch.pl "errors" in the first patch were plain
wrong IMO).

Thanks,
Rafael
