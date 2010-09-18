From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: your mail
Date: Sat, 18 Sep 2010 17:56:06 +0200
Message-ID: <20100918155606.GA16269@isilmar-3.linta.de>
References: <BLU102-W16DEFB6CCB93D518FD5745EB7C0@phx.gbl>
	<Pine.LNX.4.44L0.1009181135000.10856-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1009181135000.10856-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Raj,

On Sat, Sep 18, 2010 at 11:36:16AM -0400, Alan Stern wrote:
> > I have question regarding the CPU frequency subsystem through which the frequency of the CPU is scaled.
> > 
> > e.g. If we have device driver (X device contains processor) that wants to scale its own processor based
> > 
> > upon the workload, (DVFS driver for this processor is implemented and registered with cpufreq subsystem)
> > 
> > then X device driver when detects waorkload,  Can this X device driver call policy governor APIS for scaling clock or
> > 
> > this X device driver can directly calls DVFS driver APIs directly?

Best would be to register a cpufreq policy notifier,
(cpufreq_register_notifier()), and then call cpufreq_update_policy()
whenever the "X device driver" needs to modify its frequency constraints.

In addition, it would be best to discuss this on the cpufreq mailing list at

cpufreq@vger.kernel.org

Best,
	Dominik
