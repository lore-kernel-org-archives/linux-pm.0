From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: runtime PM: common hooks for static and runtime PM
Date: Wed, 03 Feb 2010 15:30:21 -0800
Message-ID: <877hqt7v8y.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

I'm implementing runtime PM for the TI OMAP SoCs by overriding the
platform_bus hooks.  All is working well for runtime PM, but it's 
brought up a couple snags for static PM.

Most of our drivers don't really need to distinguish between runtime
PM and static PM as we can hit the same power states when idle as we
can in suspend.  Before switching to runtime PM we've been using the
clock framework to do both runtime PM and static PM.  The driver would
disable its clocks & HW when idle and when going into suspend,
typically using a common 'disable' function.

In converting a test driver to runtime PM, I just converted this
common disable function from a clock disable to a
pm_runtime_put_sync() and the common enable function to do a
pm_runtime_get_sync().  This all worked well for runtime PM, resulting
in my platform_pm_runtime_* hooks being called where I can then
disable/re-enable the clocks/HW etc.  So far so good.

However, I'm not able to use the common function in the static suspend
path because dpm_prepare() does a pm_runtime_get_no_resume() which
prevents any runtime PM transitions during suspend.

I understand the motivation for this is probably to prevent runtime PM
transitions during static suspend, and that makes sense.  However, I'm
wondering if there's some other way to handle my problem without
having to have the driver have different paths for static and runtime
PM.

My current hack is to add an "extra" pm_runtime_put_sync() to the
driver's static suspend hook (and 'get' in the resume hook) to
essentially cancel out the 'get' held by dpm_prepare(), but I'm pretty
sure this is not an acceptable long-term solution.

Any other ideas?  Or maybe I've misunderstood something more basic.
Any pointers would be appreciated.

Thanks,

Kevin
