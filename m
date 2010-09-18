From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: your mail
Date: Sat, 18 Sep 2010 11:36:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009181135000.10856-100000@netrider.rowland.org>
References: <BLU102-W16DEFB6CCB93D518FD5745EB7C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W16DEFB6CCB93D518FD5745EB7C0@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 18 Sep 2010, Raj Kumar wrote:

> Hi Alan,
> 
>  
> 
> I have question regarding the CPU frequency subsystem through which the frequency of the CPU is scaled.
> 
> e.g. If we have device driver (X device contains processor) that wants to scale its own processor based
> 
> upon the workload, (DVFS driver for this processor is implemented and registered with cpufreq subsystem)
> 
> then X device driver when detects waorkload,  Can this X device driver call policy governor APIS for scaling clock or
> 
> this X device driver can directly calls DVFS driver APIs directly?

I don't know.  I have never used cpufreq and I don't know how it works.

> I just want to know from our device driver how do call DVFS driver if DVFS driver is registered with cpu frequency subsystem?

Then you should ask somebody else.

Alan Stern
