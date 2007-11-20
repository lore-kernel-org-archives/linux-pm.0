From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend/hibernation patches for 2.6.25
Date: Wed, 21 Nov 2007 00:59:53 +0100
Message-ID: <200711210059.54210.rjw__27683.5827077322$1195602309$gmane$org@sisk.pl>
References: <200711192332.15078.rjw@sisk.pl>
	<200711200141.06595.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711200141.06595.lenb@kernel.org>
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
Cc: Adrian Bunk <bunk@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 20 of November 2007, Len Brown wrote:
> thanks for re-sending, Rafael.
> 
> I've created a new "suspend" branch -- currently
> rooted on Linus' latest.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git suspend
> 
> I've re-based the older hibernate patches onto
> the new branch, and added the batch you just sent.
> 
> Note that the suspend branch is included in my test branch,
> which akpm pulls into -mm.

Thanks for all that!

I'm now seeing the suspend branch on gitweb, but when I do

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6

I get a repository with only one branch which is "test" and indeed
.git/refs/heads contains this one only.  What should I do to get the suspend
branch (and the others) too with git clone (or git fetch)?

Rafael
