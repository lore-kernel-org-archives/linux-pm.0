From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: cpufreq-set problems [Was: Re: Ottawa Linux Power
	Management Summit, June 25-26, 2007 - Minutes]
Date: Mon, 29 Oct 2007 15:26:00 +0200
Message-ID: <1193664360.23273.24.camel@localhost.localdomain>
References: <200709050426.04793.lenb@kernel.org>
	<20071028135446.GG26943@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071028135446.GG26943@isilmar.linta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Sun, 2007-10-28 at 14:54 +0100, ext Dominik Brodowski wrote:
> Hi,
> 
> On Wed, Sep 05, 2007 at 04:26:04AM -0400, Len Brown wrote:
> > cpufreq_set_policy() doesn't match Nokia's needs as it is a 1-way
> > notification, and there is no way to register constraints.
> 
> Could you elaborate a bit on this? cpufreq_update_policy() and
> cpufreq_register_notifier() allows to register constraints, and then you can
> use cpufreq_update_policy().

we are using update policy, but the problem with the notifications as
cpufreq handles them, is that we wanted to have a specific sequence of
operations been done, while (if i'm not wrong) the cpufreq notifications
do not provide this feature.

Probably this is not really needed for traditional x86 systems, while
SoC allow to know at design time what sort of devices will be present in
the system.


-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
