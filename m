From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] intel_idle: add missing __percpu markup
Date: Sat, 07 Aug 2010 21:34:15 +0200
Message-ID: <4C5DB537.1090006__5801.60828908465$1281209740$gmane$org@kernel.org>
References: <1281204603-13406-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1281204603-13406-1-git-send-email-namhyung@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/07/2010 08:10 PM, Namhyung Kim wrote:
> intel_idle_cpuidle_devices is a percpu pointer but was missing __percpu markup.
> Add it.
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
