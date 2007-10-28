From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: cpufreq-set problems [Was: Re: Ottawa Linux Power
	Management Summit, June 25-26, 2007 - Minutes]
Date: Sun, 28 Oct 2007 14:54:46 +0100
Message-ID: <20071028135446.GG26943@isilmar.linta.de>
References: <200709050426.04793.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709050426.04793.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wed, Sep 05, 2007 at 04:26:04AM -0400, Len Brown wrote:
> cpufreq_set_policy() doesn't match Nokia's needs as it is a 1-way
> notification, and there is no way to register constraints.

Could you elaborate a bit on this? cpufreq_update_policy() and
cpufreq_register_notifier() allows to register constraints, and then you can
use cpufreq_update_policy().

Best,
	Dominik
