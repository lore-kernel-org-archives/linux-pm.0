From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bug-fix]:2.6.25-rc0 Generic thermal management
 [Patch 1/2]: validating input parameters
Date: Wed, 13 Feb 2008 10:33:09 -0800
Message-ID: <20080213103309.81ce6d36.akpm__40450.7134379402$1202928504$gmane$org@linux-foundation.org>
References: <05B550FD4BD2014E841D83547B62600802A3A1B0@bgsmsx411.gar.corp.intel.com>
	<20080211133827.16140ba0.akpm@linux-foundation.org>
	<05B550FD4BD2014E841D83547B62600802A6B2A7@bgsmsx411.gar.corp.intel.com>
	<20080212133446.a521a8bb.akpm@linux-foundation.org>
	<05B550FD4BD2014E841D83547B62600802A6BA72@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <05B550FD4BD2014E841D83547B62600802A6BA72@bgsmsx411.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@elte.hu, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Feb 2008 16:33:10 +0530
"Thomas, Sujith" <sujith.thomas@intel.com> wrote:

> 	For time being I am attaching the patch and in the meanwhile
> I'll figure out
> a way to fix the wordwrap issues. This was what Len Brown also had
> recommended.

This patch has no changelog.  Please include the full and up-to-date
changelog with each iteration of a patch.

This patch doesn't apply.  My version of Linux has

	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
		return -EINVAL;

whereas yours apparently has

  	if (trip >= tz->trips ||
  	    (trip < 0 && trip != THERMAL_TRIPS_NONE))
  		return -EINVAL;

(plus other changes).

Maybe you have some other patch which predeced this one.

You apparently didn't resend "[Bug-fix]:2.6.25-rc0 Generic thermal
management:ACPI [Patch 2/2]: buildfix for CONFIG_THERMAL=n" which was also
mangled.


So please just start again.  Resend all patches, against latest mainline,
with full changelogs and appropriate cc's, in an unmangled form.

Also it would be good if you could be a bit more conventional with the
patch titling.  For this one, 

Subject: [patch 1/2] Generic thermal management: validate input parameters

would suit.  Section 14 of Documentation/SubmittingPatches has some
explanation.

Thanks.
