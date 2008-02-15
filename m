From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/6] Generic thermal management: validate
	input parameters
Date: Fri, 15 Feb 2008 01:09:36 -0500
Message-ID: <200802150109.36632.lenb__27283.1144663089$1203055903$gmane$org@kernel.org>
References: <05B550FD4BD2014E841D83547B62600802AA64FF@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <05B550FD4BD2014E841D83547B62600802AA64FF@bgsmsx411.gar.corp.intel.com>
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
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 15 February 2008 00:22, Thomas, Sujith wrote:
> From: Thomas Sujith <sujith.thomas@intel.com>

Thanks Sujith, this patch series was a massive improvement over the last one --
checkpatch.pl clean and everything:-)

I think if you can get rid of the outlook-destroys-plain text via word-wrap
so you don't need to also attach the patches, then you're cookin' with gas.

In the mean time, I've loaded the attachments into the acpi test tree.
if you send more attachments in the future, please start them
with the 1st line as a Subject: so they look to the tools like e-mail.

eg.

Subject: intel_menlo: extract return values using PTR_ERR
From: Thomas Sujith <sujith.thomas@intel.com>

Need to extract errors using PTR_ERR macro and...


thanks,
-Len
