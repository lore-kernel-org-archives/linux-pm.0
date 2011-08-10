From: Christian Robottom Reis <kiko@linaro.org>
Subject: Re: [PATCH 1/2] cpumask: introduce cpumask for
	hotpluggable CPUs
Date: Tue, 9 Aug 2011 23:01:57 -0300
Message-ID: <20110810020157.GA29494__15669.8348270313$1312995694$gmane$org@anthem.async.com.br>
References: <1312940007-26069-1-git-send-email-mturquette@ti.com>
	<1312940007-26069-2-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1312940007-26069-2-git-send-email-mturquette@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 09, 2011 at 06:33:26PM -0700, Mike Turquette wrote:
> - *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
> - *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
> - *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
> - *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
> + *     cpu_possible_mask     - has bit 'cpu' set iff cpu is populatable
> + *     cpu_hotpluggable_mask - has bit 'cpu' set iff cpu is hotpluggable
> + *     cpu_present_mask      - has bit 'cpu' set iff cpu is populated
> + *     cpu_online_mask       - has bit 'cpu' set iff cpu available to scheduler
> + *     cpu_active_mask       - has bit 'cpu' set iff cpu available to migration

Why not fix the 'iff' typo while you're here?
-- 
Christian Robottom Reis, Engineering VP
Brazil (GMT-3) | [+55] 16 9112 6430 | [+1] 612 216 4935
Linaro.org: Open Source Software for ARM SoCs
