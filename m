From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 18:52:00 -0800
Message-ID: <4D50AFD0.9020704__3937.59104558757$1297179560$gmane$org@am.sony.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 02/07/11 04:22, Mark Brown wrote:
> It is very rare to find a current system which is both sufficiently
> resource constrained to want to compile out power management support
> and sufficiently power insensitive to be able to tolerate doing so.
> Since having the configuration option requires non-zero effort to
> maintain, with ifdefery in most drivers, but it is used with vanishing
> rarity it is simpler to just remove the option.

Proof by assertion that it is used with vanishing rarity.

> Begin doing so by hiding it from users - this should attract complaints
> from any active users. The option is left disabled for the IA64 Ski
> simulator which is a partial simulator for IA64 systems mostly missing
> device support. This is a very limited use case which is unlikely to
> ever want to enable most drivers.

That is not a good method of getting feedback from users.

 1) It immediately removes the ability to have CONFIG_PM undefined,
    without first giving active users a chance to provide feedback.

 2) The removal of that ability is not obvious ("make oldconfig" does
    not say anything about CONFIG_PM).  It is easy to overlook a
    config change that happens silently.

 3) The active users may not move to a newer version of the kernel
    that contains this change until after it has been decided that
    there are no users of the config option since no one complained
    in a timely manner.

Would it be appropriate to use Documentation/feature-removal-schedule.txt
if this truly will be removed?

-Frank
