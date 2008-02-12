From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bug-fix]:2.6.25-rc0 Generic thermal management
 [Patch 1/2]: validating input parameters
Date: Tue, 12 Feb 2008 13:34:46 -0800
Message-ID: <20080212133446.a521a8bb.akpm__19730.9395451613$1202852236$gmane$org@linux-foundation.org>
References: <05B550FD4BD2014E841D83547B62600802A3A1B0@bgsmsx411.gar.corp.intel.com>
	<20080211133827.16140ba0.akpm@linux-foundation.org>
	<05B550FD4BD2014E841D83547B62600802A6B2A7@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <05B550FD4BD2014E841D83547B62600802A6B2A7@bgsmsx411.gar.corp.intel.com>
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

On Tue, 12 Feb 2008 21:27:44 +0530
"Thomas, Sujith" <sujith.thomas@intel.com> wrote:

> > The patch is fairly seriously wordwrapped.
> Should be fixed now.

No, even after I fixed all the wordwrapping I saw a large amount
of fuzz and several rejects when trying to apply the patch.

There's a reason why Len uses his kernel.org account to get real work done ;)
