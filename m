From: Andrea Arcangeli <andrea@qumranet.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc5
Date: Thu, 13 Mar 2008 13:50:16 +0100
Message-ID: <20080313125016.GZ7365__407.755611422722$1205421195$gmane$org@v2.random>
References: <200803130214.36861.lenb@kernel.org>
	<20080312234516.bb079cc5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080312234516.bb079cc5.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 12, 2008 at 11:45:16PM -0700, Andrew Morton wrote:
> http://userweb.kernel.org/~akpm/mmotm/broken-out/revert-acpi-thermal-fixup.patch
> 
>   Hopeully fix a regression which Andrea Arcangeli hit.  Although I'm not sure
>   that he has confirmed that this revert actually works?

Last time I tried it fixed my boot failure (I found it by bisecting).

Thanks.
