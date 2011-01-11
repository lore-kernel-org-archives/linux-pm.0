From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: Make cpuidle_enable_device() call
	poll_idle_init()
Date: Tue, 11 Jan 2011 01:02:22 +0100
Message-ID: <201101110102.22204.rjw__16109.1898604811$1294704248$gmane$org@sisk.pl>
References: <201101080029.20744.rjw@sisk.pl>
	<alpine.LFD.2.02.1101101754320.7945@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1101101754320.7945@x980>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 11, 2011, Len Brown wrote:
> >  /**
> >   * cpuidle_enable_device - enables idle PM for a CPU
> >   * @dev: the CPU
> > @@ -176,6 +215,8 @@ int cpuidle_enable_device(struct cpuidle
> >  		ret = __cpuidle_register_device(dev);
> >  		if (ret)
> >  			return ret;
> > +	} else {
> > +		poll_idle_init(dev);
> >  	}
> 
> how about calling poll_idle_init() unconditionally here
> and deleting the call to it from within __cpuidle_register_device()?

Fine by me, as long as poll_idle_init() is called before the conditional. :-)

Thanks,
Rafael
