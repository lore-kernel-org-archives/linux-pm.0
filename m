From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] acpi: intel_idle : break dependency
	between modules
Date: Sat, 30 Jun 2012 00:27:04 +0200
Message-ID: <201206300027.05175.rjw@sisk.pl>
References: <201206271506.29034.trenn@suse.de>
	<201206282124.09857.rjw@sisk.pl> <4FED69BE.20707@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FED69BE.20707@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 29, 2012, Daniel Lezcano wrote:
> On 06/28/2012 09:24 PM, Rafael J. Wysocki wrote:
> > On Thursday, June 28, 2012, Daniel Lezcano wrote:
> >> When the system is booted with some cpus offline, the idle
> >> driver is not initialized. When a cpu is set online, the
> >> acpi code call the intel idle init function. Unfortunately
> >> this code introduce a dependency between intel_idle and acpi.
> >>
> >> This patch is intended to remove this dependency by using the
> >> notifier of intel_idle. This patch has the benefit of
> >> encapsulating the intel_idle driver and remove some exported
> >> functions.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > This one looks good to me too.
> > 
> > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Thanks for the review Rafael.
> 
> > Len, are you going to take it?
> 
> Rafael, Len,
> 
> After the discussion [1], I put in place a tree at:
> 
> ssh://git.linaro.org/srv/git.linaro.org/git/people/dlezcano/cpuidle-next.git
> #cpuidle-next
> 
> I proposed this tree to group the cpuidle modifications and prevent the
> last minutes conflict when Len will apply them.
> 
> I also included the tree into linux-next for wider testing.

I can't speak for Len, but I'm not sure he'll like this.

Anyway, you seem to have the same material as Len in that tree, won't there
be any conflicts in linux-next?

Rafael
