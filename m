From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume if KMS is used
Date: Mon, 25 Jan 2010 10:35:25 -0800
Message-ID: <20100125103525.2b766b9c__20434.523598715$1264444768$gmane$org@jbarnes-piketon>
References: <201001240055.59479.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001240055.59479.rjw@sisk.pl>
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
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, pm@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Jan 2010 00:55:59 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> If a non-KMS graphics driver is used, the kernel carries out a VT
> switch during suspend/resume to avoid possible problems with freezing
> X at a wrong time and to cause X to repaint everything after resume.
> 
> This is not necessary any more if the KMS is used, so skip the kernel
> VT switch during suspend/resume for i915 in the KMS mode.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> 
> Hi,
> 
> I've been testing this patch for over a week and haven't seen a
> single problem related to it during this time.
> 
> Are there any objections to it?

This probably belongs in the core DRM KMS code instead of the driver.
I can imagine that there may be some X driver code that still needs to
be executed on suspend/resume for some drivers, so this may introduce
bugs, but it's definitely the right way to go.

Dave?

-- 
Jesse Barnes, Intel Open Source Technology Center
