From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: runtime: fix recursive locking warning
 of lockdep from rpm_resume
Date: Fri, 22 Oct 2010 10:25:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010221024140.1529-100000@iolanthe.rowland.org>
References: <1287748694-3046-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1287748694-3046-1-git-send-email-tom.leiming@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Oct 2010 tom.leiming@gmail.com wrote:

> From: Ming Lei <tom.leiming@gmail.com>
> 
> For device with no_callbacks flag set, its power lock and its parent's
> power lock may be held nestedly in rpm_resume, so we should take
> spin_lock_nested(lock, SINGLE_DEPTH_NESTING) to acquire parent power lock
> to avoid lockdep warning.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  drivers/base/power/runtime.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 1dd8676..126ca49 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -503,7 +503,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>  	 * the resume will actually succeed.
>  	 */
>  	if (dev->power.no_callbacks && !parent && dev->parent) {
> -		spin_lock(&dev->parent->power.lock);
> +		spin_lock_nested(&dev->parent->power.lock, SINGLE_DEPTH_NESTING);
>  		if (dev->parent->power.disable_depth > 0
>  		    || dev->parent->power.ignore_children
>  		    || dev->parent->power.runtime_status == RPM_ACTIVE) {

Quite correct; I don't know why this didn't show up during my testing.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
