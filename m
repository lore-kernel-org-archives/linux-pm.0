From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/3] use new pm_ops in DRM drivers
Date: Fri, 04 Apr 2008 08:47:47 +1100
Message-ID: <1207259267.10388.334.camel@pasglop>
References: <200804020207.40278.rjw@sisk.pl> <200804020209.47207.rjw@sisk.pl>
	<200804031150.55967.jbarnes@virtuousgeek.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804031150.55967.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org


On Thu, 2008-04-03 at 11:50 -0700, Jesse Barnes wrote:
> +static struct pm_ops i915_pm_ops = {
> +       .prepare = NULL, /* DRM core should prevent any new ioctls? */
> +       .complete = NULL, /* required to re-enable DRM client requests
> */

The DRM core could definitely provide generic prepare & complete that
sync'up with user space, making sure the command streams stop etc...

Ben.
